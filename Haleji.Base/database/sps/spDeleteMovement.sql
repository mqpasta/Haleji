-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteMovement' 
)
   DROP PROCEDURE dbo.spDeleteMovement
GO

CREATE PROCEDURE dbo.spDeleteMovement
	@MovementId bigint
AS
	DELETE FROM Movement
	 WHERE MovementId = @MovementId

GO

