Setup database by running setupMain.sql

How to connect database to PowerBI

1. Click on SQL Server
2. Put in server credentials
3. Choose relevant tables and press transform data
4. Transform the data as needed

Create a new column in Relation that has this condition:

if [isITconsultant] = 1 then

(if [workedHours] < 100 or [salesMeetings] < 5 then "Junior konsult" 
else if [workedHours] < 200 or [salesMeetings] < 10 then "Konsult" 
else "Senior konsult")

else
(if [workedHours] < 50 or [salesMeetings] < 15 then "Junior konsult" 
else if [workedHours] < 100 or [salesMeetings] < 30 then "Konsult" 
else "Senior konsult")