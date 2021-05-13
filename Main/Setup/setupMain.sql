-- Måste aktivera SQLCMD Mode i Query-fliken
--CREATE DATABASE Konsulttrappan
--Insert into API(pname,APIkey) Values ('LimeGo', <NYCKEL>)
--Insert into API(pname,APIkey) Values ('Clockify', <NYCKEL>)

-- Skriv in sökvägen till dessa filer på din dator
--:r C:\Users\Hampus\Documents\GitHub\MinixDAT257\Setup\setupQuery.sql
--:r C:\Users\Hampus\Documents\GitHub\MinixDAT257\Setup\InsertIntoClockifyUser.sql
--:r C:\Users\Hampus\Documents\GitHub\MinixDAT257\Setup\InsertIntoLimeGoUser.sql
--:r C:\Users\Hampus\Documents\GitHub\MinixDAT257\Setup\inserttorelations.sql

/*
Skapa Stored Procedures i SQL Server Management Studio:
1. Konsulttrappan -> Programmability -> Stored Procedures
2. Högerklicka och välj NEW -> Stored Procedure
3. Ersätt allt i fönstret som öppnas med kod från MinixDAT257\Setup\storedProcedure_setupClockify.sql
4. Upprepa och skapa en ny procedure för
	MinixDAT257\Setup\storedProcedure_setupLime.sql
	MinixDAT257\Setup\storedProcedure_setupRelation.sql

Skapa jobb:
5. Högerklicka på SQL Server Agent i Object Explorer och välj START
6. Välj Jobs -> New Job
7. Ange namn på jobbet
8. Välj Steps -> New 
9. Ange namn på steget
10. I fältet Command, skriv in följande:
	USE Konsulttrappan
	SET TEXTSIZE -1
	EXEC LimeGoRun
11. Upprepa för Clockify och Relations, där LimeGoRun byts ut mot
	ClockifyRun
	RelationRun
12. Se till att spara varje steg genom att klicka OK
13. Justera ordningen av stegen:
	Sista steget ska vara procedure för Relation.
	Sista steget ska On Success vara "Quit the job reporting success" och resterande vara "Go to the next step".
	Detta ställs in genom Step -> Advanced -> On success action

Schemalägg jobbet:
14. Högerklicka på det skapade jobbet ovan -> Properties
15. Välj Schedules -> New 
16. Ställ in önskad frekvens på uppdateringen
*/