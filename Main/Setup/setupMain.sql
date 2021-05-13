-- M�ste aktivera SQLCMD Mode i Query-fliken
--CREATE DATABASE Konsulttrappan


-- 1
-- K�r f�rst denna
--:r C:\Users\phili\OneDrive\Dokument\GitHub\MinixDAT257\Main\Setup\setupQuery.sql 

-- 2
--Insert into API(pname,APIkey) Values ('LimeGo', 'fd8b0d17-e940-4d0c-bae9-34f8ee6bb74f')
--Insert into API(pname,APIkey) Values ('Clockify', 'YjUxZGZiMWUtMmY2My00NTNhLTk4ODMtYWIzYmI3M2ZjNDRh')

-- 3
-- Skriv in s�kv�gen till dessa filer p� din dator

--:r C:\Users\phili\OneDrive\Dokument\GitHub\MinixDAT257\Main\Setup\InsertIntoClockifyUser.sql
--:r C:\Users\phili\OneDrive\Dokument\GitHub\MinixDAT257\Main\Setup\InsertIntoLimeGoUser.sql
--:r C:\Users\phili\OneDrive\Dokument\GitHub\MinixDAT257\Main\Setup\inserttorelations.sql

/*
Skapa Stored Procedures i SQL Server Management Studio:
1. Konsulttrappan -> Programmability -> Stored Procedures
2. H�gerklicka och v�lj NEW -> Stored Procedure
3. Ers�tt allt i f�nstret som �ppnas med kod fr�n MinixDAT257\Setup\storedProcedure_setupClockify.sql
4. Upprepa och skapa en ny procedure f�r
	MinixDAT257\Setup\storedProcedure_setupLime.sql
	MinixDAT257\Setup\storedProcedure_setupRelation.sql
Skapa jobb:
5. H�gerklicka p� SQL Server Agent i Object Explorer och v�lj START
6. V�lj Jobs -> New Job
7. Ange namn p� jobbet
8. V�lj Steps -> New 
9. Ange namn p� steget
10. I f�ltet Command, skriv in f�ljande:
	USE Konsulttrappan
	SET TEXTSIZE -1
	EXEC LimeGoRun
11. Upprepa f�r Clockify och Relations, d�r LimeGoRun byts ut mot
	ClockifyRun
	RelationRun
12. Se till att spara varje steg genom att klicka OK
13. Justera ordningen av stegen:
	Sista steget ska vara procedure f�r Relation.
	Sista steget ska On Success vara "Quit the job reporting success" och resterande vara "Go to the next step".
	Detta st�lls in genom Step -> Advanced -> On success action
Schemal�gg jobbet:
14. H�gerklicka p� det skapade jobbet ovan -> Properties
15. V�lj Schedules -> New 
16. St�ll in �nskad frekvens p� uppdateringen
*/