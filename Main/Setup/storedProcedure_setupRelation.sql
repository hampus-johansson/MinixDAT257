-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
use Konsulttrappan

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE RelationRun 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    TRUNCATE TABLE Relation

	INSERT INTO Relation(email, workedHours, salesMeetings, isITconsultant) 
	SELECT ClockifyUser.email, COALESCE(ClockifyUser.workedHours, 0) AS workedHours, COALESCE(LimeGoUser.salesMeetings,0) AS salesMeetings, ClockifyUser.isITconsultant 
	FROM ClockifyUser LEFT JOIN LimeGoUser ON ClockifyUser.email = LimeGoUser.email

END
GO
