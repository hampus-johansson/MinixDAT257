
/*
  UNDERSTANDING THE Show Advanced Options
  ------------------------------------------------------------------------------------------------------------------
  Some configuration options, such as affinity mask and recovery interval, are designated as advanced options. By 
  default, these options are not available for viewing and changing. To make them available, set the ShowAdvancedOptions 
  configuration option to 1.
*/


EXEC sp_configure 'show advanced options', 1
RECONFIGURE
GO

/*
  UNDERSTANDING THE OLE Automation Procedue
  ------------------------------------------------------------------------------------------------------------------
  Use the Ole Automation Procedures option to specify whether OLE Automation objects can be instantiated within 
  Transact-SQL batches. This option can also be configured using the Policy-Based Management or the sp_configure stored 
  procedure. The Ole Automation Procedures option can be set to the following values.
  Value: 0
  Definition: OLE Automation Procedures are disabled. Default for new instances of SQL Server.
  Value: 1
  Definition: OLE Automation Procedures are enabled.
  
  When OLE Automation Procedures are enabled, a call to sp_OACreate will start the OLE shared execution environment. The current 
  value of the Ole Automation Procedures option can be viewed and changed by using the sp_configure system stored procedure.
*/

EXEC sp_configure 'Ole Automation Procedures', 1
RECONFIGURE
GO



-- Variable declaration related to the Object.
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


	CREATE TABLE NewLimeGoEvents(
	position varchar(100) NOT NULL,
	email varchar(100) NOT NULL,
	eventType varchar(100) NOT NULL,
	);


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

	INSERT INTO LimeGoEvents 
	SELECT * FROM NewLimeGoEvents

	/*
	INSERT LimeGoUser(email, 1)  
	SELECT email
	FROM NewLimeGoEvents
	WHERE NOT EXISTS (SELECT email FROM LimeGoUser u WHERE u.email = NewLimeGoEvents.email);
	*/

	MERGE dbo.LimeGoUser AS U USING dbo.NewLimeGoEvents AS N
	ON (N.email = U.email)
	
	WHEN MATCHED AND eventType = 'MeetingBooked'
		THEN 
		UPDATE SET U.salesMeetings = U.salesMeetings + 1 
	
	WHEN NOT MATCHED BY TARGET AND eventType = 'MeetingBooked'
		THEN 
		INSERT (email, salesMeetings) 
		VALUES (N.email, 1);


	DROP TABLE NewLimeGoEvents
	DELETE @json

	END;

