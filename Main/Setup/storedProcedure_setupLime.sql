-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
EXEC sp_configure 'show advanced options', 1
RECONFIGURE
GO

EXEC sp_configure 'Ole Automation Procedures', 1
RECONFIGURE
GO

-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE LimeGoRun 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @token INT;
DECLARE @ret INT;
DECLARE @positionFirst INT;
DECLARE @positionLast INT;


-- Variable declaration related to the Request.
DECLARE @url NVARCHAR(MAX);
DECLARE @authHeader NVARCHAR(64);
DECLARE @contentType NVARCHAR(64);
DECLARE @apiKey NVARCHAR(64);

-- Variable declaration related to the JSON string.
DECLARE @json AS TABLE(Json_Table NVARCHAR(MAX))

-- Set the API Key
--använd
SET @apiKey = 'fd8b0d17-e940-4d0c-bae9-34f8ee6bb74f';

--måste = true för att inte stega igenom alla sidor
DECLARE @peek NVARCHAR(64) = 'false';

-- Set Authentications
SET @authHeader = 'go-api:'+@apiKey;
SET @contentType = 'application/json';

	CREATE TABLE NewLimeGoEvents(
	position varchar(100) NOT NULL,
	email varchar(100) NOT NULL,
	eventType varchar(100) NOT NULL,
	);

--while loop is commented out, might be used later
WHILE 1=1
BEGIN
	-- Define the URL
	SET @url = 'https://api.lime-go.com/v1/event/feed/?peek=' + @peek + '&data=[out:json]&apikey=' + @apiKey;

	-- This creates the new object.
	EXEC @ret = sp_OACreate 'MSXML2.XMLHTTP', @token OUT;
	IF @ret <> 0 RAISERROR('Unable to open HTTP connection.', 10, 1);

	-- This calls the necessary methods.
	EXEC @ret = sp_OAMethod @token, 'open', NULL, 'GET', @url, 'false';
	EXEC @ret = sp_OAMethod @token, 'send'

	-- Grab the responseText property, and insert the JSON string into a table temporarily. This is very important, if you don't do this step you'll run into problems.
	INSERT into @json (Json_Table) EXEC sp_OAGetProperty @token, 'responseText'

	-- Select the JSON string from the Table we just inserted it into. You'll also be able to see the entire string with this statement.
	SELECT * FROM @json

	IF (NOT EXISTS (SELECT * FROM OPENJSON((SELECT * FROM @json),'$.items')))
		BREAK;


	INSERT into NewLimeGoEvents 
	SELECT 
	 position,
	 email,
	 eventType
	FROM OPENJSON((SELECT * FROM @json),'$.items')   -- USE OPENJSON to begin the parse.

	WITH (
		coworker NVARCHAR(MAX) AS JSON,
		eventType NVARCHAR(MAX),
		position NVARCHAR(MAX)
	) AS Coworker

	CROSS APPLY OPENJSON([Coworker].[coworker])
	WITH ( 
	 firstName NVARCHAR(MAX),
	 lastName NVARCHAR(MAX),
	 email NVARCHAR(MAX)
	)
	GROUP BY position, email, eventType 



	/*
	INSERT LimeGoUser(email, 1)  
	SELECT email
	FROM NewLimeGoEvents
	WHERE NOT EXISTS (SELECT email FROM LimeGoUser u WHERE u.email = NewLimeGoEvents.email);
	*/

	DELETE @json

	END;

	INSERT INTO LimeGoEvents 
	SELECT * FROM NewLimeGoEvents

	CREATE TABLE NewLimeGoUser(email NVARCHAR(100), meetings INT) 


	INSERT INTO NewLimeGoUser
	SELECT 
	email,
	COUNT(*) AS meetings
	FROM NewLimeGoEvents
	WHERE eventType = 'MeetingBooked' OR eventType = 'MeetingReported'
	GROUP BY email

	INSERT INTO NewLimeGoUser VALUES ('test', 1)

	MERGE dbo.LimeGoUser AS U USING dbo.NewLimeGoUser AS N
	ON (N.email = U.email)
	
	WHEN MATCHED
		THEN 
		UPDATE SET U.salesMeetings = U.salesMeetings + N.meetings 
	
	WHEN NOT MATCHED BY TARGET
		THEN 
		INSERT (email, salesMeetings) 
		VALUES (N.email, N.meetings);


	DROP TABLE NewLimeGoEvents
	DROP TABLE NewLimeGoUser

END
GO
