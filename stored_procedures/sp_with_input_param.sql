SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Emir Lejlic
-- Create date: 07.11.18
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_restore_log_CDC_NO]
	-- Input parameters
	@FILENAME NVARCHAR(200)
AS
BEGIN
	SET NOCOUNT ON;
	
	-- Create the full filepath
	DECLARE @FULLPATH NVARCHAR(500)
	SET @FULLPATH = CONCAT(N'D:\SQLData\MSSQL13.MSSQLSERVER\MSSQL\Backup\', @FILENAME)
	
	
	RESTORE LOG CDC_NO FROM DISK = @FULLPATH
	WITH STANDBY = N'D:\SQLData\MSSQL13.MSSQLSERVER\MSSQL\Backup\ROLLBACK_UNDO_CDC_NO.BAK'
END
GO


-- EXAMPLE ON HOW TO USE IT
EXEC [dbo].[sp_restore_log_CDC_NO] @FILENAME = N'logfilename.txt'