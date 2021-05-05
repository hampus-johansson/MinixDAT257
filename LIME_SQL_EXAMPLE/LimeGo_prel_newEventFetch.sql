INSERT INTO LimeGoUser
SELECT 
 email,
 COUNT(*) AS meetings
FROM LimeGoEvents
--WHERE eventType = 'MeetingBooked'
GROUP BY email