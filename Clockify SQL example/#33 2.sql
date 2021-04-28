
DROP FUNCTION dateFormating
GO

CREATE FUNCTION dateFormating (@duration NVARCHAR(MAX))

RETURNS NVARCHAR(MAX)


BEGIN 

	DECLARE @start NVARCHAR(MAX)
	DECLARE @end NVARCHAR(MAX)
	DECLARE @result NVARCHAR(MAX)
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

DECLARE @duration NVARCHAR(MAX);

DECLARE @ret NVARCHAR(MAX);

EXEC @ret = dateFormating
	@duration = '{"start":"2021-04-26T09:00:47Z","end":"2021-04-26T10:14:17Z","duration":"PT1H13M30S"}'; 

select @ret
