-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllItem' 
)
   DROP PROCEDURE dbo.spGetAllItem
GO

CREATE PROCEDURE dbo.spGetAllItem
AS
	SELECT * FROM Item

GO
