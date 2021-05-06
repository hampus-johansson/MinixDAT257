DROP FUNCTION dateFormating
GO

CREATE FUNCTION dateFormating (@duration NVARCHAR(MAX), @billable NVARCHAR(MAX))

RETURNS int


BEGIN 

IF @billable = 'true'
BEGIN
    DECLARE @start NVARCHAR(MAX)
    DECLARE @end NVARCHAR(MAX)
    DECLARE @result NVARCHAR(MAX)
    DECLARE @test NVARCHAR(MAX)

    set @test = (SELECT SUBSTRING(@duration,39,19))

    if (CHARINDEX ('null',@duration)>0)
    BEGIN
	set @start = (SELECT SUBSTRING(@start,11,19))
    set @duration = REPLACE(@duration,'null',@start) 
    END

    set @start = replace(@duration,'T',' ')
    set @start = replace(@start,'Z','')
    set @start = (SELECT SUBSTRING(@start,11,19))

    set @end = replace(@duration,'T',' ')
    set @end = replace(@end,'Z','')
    set @end = (SELECT SUBSTRING(@end,39,19))


    set @result = DATEDIFF(second,@start,@end)

    --set @result =  just nu står det i sekunder

    -- Enklaste är att köra datediff timeinterval start och end, där man tar bort z och t
END
	ELSE
	BEGIN
	set @result = 0
	END
    RETURN (@result)

END
GO

DECLARE @duration NVARCHAR(MAX);
DECLARE @billable NVARCHAR(MAX);
DECLARE @ret NVARCHAR(MAX);  

EXEC @ret = dateFormating  

@duration = '{"start":"2021-04-26T09:00:47Z","end":"null","duration":"null"}';
@billable = '{false}';

select @ret
