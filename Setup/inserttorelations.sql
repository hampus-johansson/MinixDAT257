INSERT INTO Relation(email, workedHours, salesMeetings, isITconsultant) 
SELECT ClockifyUser.email, COALESCE(ClockifyUser.workedHours, 0) AS workedHours, COALESCE(LimeGoUser.salesMeetings,0) AS salesMeetings, ClockifyUser.isITconsultant 
FROM ClockifyUser LEFT JOIN LimeGoUser ON ClockifyUser.email = LimeGoUser.email