USE [msdb]
GO
SET TEXTSIZE -1
EXEC msdb.dbo.sp_update_job @job_id=N'6b2f0522-1a83-4bbe-9bf1-023221df8d2b', 
		@notify_level_email=2, 
		@notify_level_page=2
GO
