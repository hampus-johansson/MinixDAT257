EXEC sp_configure 'show advanced options', 1
RECONFIGURE
GO


EXEC sp_configure 'Ole Automation Procedures', 1
RECONFIGURE 
GO


DROP FUNCTION dateFormating
GO

CREATE FUNCTION dateFormating (@duration NVARCHAR(MAX))

RETURNS int


BEGIN 

	DECLARE @start NVARCHAR(MAX)
	DECLARE @end NVARCHAR(MAX)
	DECLARE @result int
	set @start = replace(@duration,'T',' ')
	set @start = replace(@start,'Z','')
	set @start = (SELECT SUBSTRING(@start,11,19))

	set @end = replace(@duration,'T',' ')
	set @end = replace(@end,'Z','')
	set @end = (SELECT SUBSTRING(@end,39,19))

	set @result = DATEDIFF(second,@start,@end)

	--set @result =  just nu står det i sekunder

	-- Enklaste är att köra datediff timeinterval start och end, där man tar bort z och t
	RETURN (@result)

END
GO




-- Variable declaration related to the Object.
DECLARE @token INT;
DECLARE @ret INT;

-- Variable declaration related to the Request.
DECLARE @url NVARCHAR(MAX);
DECLARE @url2 NVARCHAR(MAX);
DECLARE @authHeader NVARCHAR(64);
DECLARE @contentType NVARCHAR(64);
DECLARE @apiKey NVARCHAR(32);

-- Variable declaration related to the JSON string.
DECLARE @json AS TABLE(Json_Table NVARCHAR(MAX))
DECLARE @json2 AS TABLE(Json_Table NVARCHAR(MAX))
-- Set Authentications
SET @authHeader = 'OTU2ODIzYTItZjk1OC00ODUwLTgxNDQtNGFmN2QyMzg5Y2I2';
SET @contentType = 'application/json';

-- Set the API Key, I'm just grabbing it from another table in my Database.
SET @apiKey = 'YjUxZGZiMWUtMmY2My00NTNhLTk4ODMtYWIzYmI3M2ZjNDRh'

-- Define the URL
SET @url = 'https://api.clockify.me/api/v1/workspaces/5efdd4e97ce08f0c087a3298/users/?page-size=54'

-- This creates the new object.
EXEC @ret = sp_OACreate 'MSXML2.XMLHTTP', @token OUT;
IF @ret <> 0 RAISERROR('Unable to open HTTP connection.', 10, 1);

-- This calls the necessary methods.
EXEC @ret = sp_OAMethod @token, 'open', NULL, 'GET', @url, 'false';
EXEC @ret = sp_OAMethod @token, 'setRequestHeader', NULL, 'X-Api-Key:', @authHeader;
EXEC @ret = sp_OAMethod @token, 'setRequestHeader', NULL, 'Content-type', @contentType;
EXEC @ret = sp_OAMethod @token, 'send'

-- Grab the responseText property, and insert the JSON string into a table temporarily. This is very important, if you don't do this step you'll run into problems.
INSERT into @json (Json_Table) EXEC sp_OAGetProperty @token, 'responseText'

-- Select the JSON string from the Table we just inserted it into. You'll also be able to see the entire string with this statement.
SELECT * FROM @json

IF OBJECT_ID('tempUsers', 'U') IS NOT NULL
DROP TABLE tempUsers

SELECT 
	*
into tempUsers FROM OPENJSON((SELECT * FROM @json))   -- USE OPENJSON to begin the parse.
	WITH (
		fullName NVARCHAR(50) '$.name',
		email NVARCHAR(50) '$.email',
		id NVARCHAR(50) '$.id'
	) 

IF OBJECT_ID('users', 'U') IS NOT NULL
DROP TABLE users

SELECT IDENTITY(int, 1,1) AS Ident, tempUsers.fullname, tempUsers.email, tempUsers.id
INTO users
FROM tempUsers; 




DECLARE @Counter INT , @MaxId INT, 
        @id NVARCHAR(100)
SELECT @Counter = min(Ident) , @MaxId = max(Ident) 
FROM users

DECLARE @entry NVARCHAR(100)
set @entry = '/time-entries/?page-size=10000'

IF OBJECT_ID('tempEntries', 'U') IS NOT NULL
DROP TABLE tempEntries

create table tempEntries (userId NVARCHAR(MAX), duration NVARCHAR(MAX))


WHILE(@Counter IS NOT NULL
     AND @Counter <= @MaxId)
BEGIN
	SELECT @id = id
   FROM users WHERE Ident = @Counter

SET @url2=FORMATMESSAGE('https://api.clockify.me/api/v1/workspaces/5efdd4e97ce08f0c087a3298/user/'+@id+@entry);


EXEC @ret = sp_OAMethod @token, 'open', NULL, 'GET', @url2, 'false';
EXEC @ret = sp_OAMethod @token, 'setRequestHeader', NULL, 'X-Api-Key:', @authHeader;
EXEC @ret = sp_OAMethod @token, 'setRequestHeader', NULL, 'Content-type', @contentType;
EXEC @ret = sp_OAMethod @token, 'send'


INSERT into @json2 (Json_Table) EXEC sp_OAGetProperty @token, 'responseText'



INSERT into tempEntries(userId, duration) 

	SELECT userId, SUM(dbo.dateFormating(timeInterval))

	 FROM OPENJSON((SELECT * FROM @json2),'$')   -- USE OPENJSON to begin the parse.
		WITH (
			[userId]  NVARCHAR(MAX),
			[timeInterval]  NVARCHAR(MAX)  AS JSON  
		) AS timeInterval 
		CROSS APPLY OPENJSON([timeInterval])
		WITH (
			duration NVARCHAR(MAX)
		)
		group by userId


   delete from @json2 
   SET @Counter  = @Counter  + 1        
END

INSERT INTO ClockifyUser(email, workedHours, clockID, isITconsultant) SELECT email, COALESCE(duration,0), id, 0 FROM tempentries  RIGHT JOIN users ON userId = id
