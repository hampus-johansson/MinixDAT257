USE [tempdb]


EXEC sp_configure 'show advanced options', 1
RECONFIGURE
GO


EXEC sp_configure 'Ole Automation Procedures', 1
RECONFIGURE 
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
SET @authHeader = 'YjUxZGZiMWUtMmY2My00NTNhLTk4ODMtYWIzYmI3M2ZjNDRh';
SET @contentType = 'application/json';

-- Set the API Key, I'm just grabbing it from another table in my Database.
SET @apiKey = 'YjUxZGZiMWUtMmY2My00NTNhLTk4ODMtYWIzYmI3M2ZjNDRh'

-- Define the URL
SET @url = 'https://api.clockify.me/api/v1/workspaces/60740385f455dc1737d51d67/users'

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

IF OBJECT_ID('users', 'U') IS NOT NULL
DROP TABLE users

SELECT 
	*
into users FROM OPENJSON((SELECT * FROM @json))   -- USE OPENJSON to begin the parse.
	WITH (
		fullName NVARCHAR(50) '$.name',
		email NVARCHAR(50) '$.email',
		id NVARCHAR(50) '$.id'
	) 

Select * from users

SET @url2 = 'https://api.clockify.me/api/v1/workspaces/60740385f455dc1737d51d67/user/5fd752195722436c579c8580/time-entries'

EXEC @ret = sp_OAMethod @token, 'open', NULL, 'GET', @url2, 'false';
EXEC @ret = sp_OAMethod @token, 'setRequestHeader', NULL, 'X-Api-Key:', @authHeader;
EXEC @ret = sp_OAMethod @token, 'setRequestHeader', NULL, 'Content-type', @contentType;
EXEC @ret = sp_OAMethod @token, 'send'


INSERT into @json (Json_Table) EXEC sp_OAGetProperty @token, 'responseText'

-- Select the JSON string from the Table we just inserted it into. You'll also be able to see the entire string with this statement.
SELECT * FROM @json
