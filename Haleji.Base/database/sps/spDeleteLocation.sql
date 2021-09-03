-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteLocation' 
)
   DROP PROCEDURE dbo.spDeleteLocation
GO

CREATE PROCEDURE dbo.spDeleteLocation
	@LocationId bigint
AS
	DELETE FROM Location WHERE LocationId = @LocationId
GO
