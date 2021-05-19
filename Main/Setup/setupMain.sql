-- Måste aktivera SQLCMD Mode i Query-fliken
--CREATE DATABASE Konsulttrappan


-- 1

-- Kör först denna

--:r C:\Users\phili\OneDrive\Dokument\GitHub\MinixDAT257\Main\Setup\setupQuery.sql 

-- 2
--Insert into API(pname,APIkey) Values ('LimeGo', 'fd8b0d17-e940-4d0c-bae9-34f8ee6bb74f')
--Insert into API(pname,APIkey) Values ('Clockify', 'OTU2ODIzYTItZjk1OC00ODUwLTgxNDQtNGFmN2QyMzg5Y2I2')  

-- 3

-- Skriv in sökvägen till dessa filer på din dator

--:r C:\Users\phili\OneDrive\Dokument\GitHub\MinixDAT257\Main\Setup\InsertIntoClockifyUser.sql
--:r C:\Users\phili\OneDrive\Dokument\GitHub\MinixDAT257\Main\Setup\InsertIntoLimeGoUser.sql
--:r C:\Users\phili\OneDrive\Dokument\GitHub\MinixDAT257\Main\Setup\InsertIntorelations.sql

/*
Skapa Stored Procedures i SQL Server Management Studio:
1. Kör filerna nedan
--:r C:\Users\phili\OneDrive\Dokument\GitHub\MinixDAT257\Setup\storedProcedure_setupClockify.sql
--:r C:\Users\phili\OneDrive\Dokument\GitHub\MinixDAT257\Setup\storedProcedure_setupLime.sql
--:r C:\Users\phili\OneDrive\Dokument\GitHub\MinixDAT257\Setup\storedProcedure_setupRelation.sql

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
16. Ställ in önskad frekvens på uppdateringen (exempelvis 1 gång var timme)
*/

