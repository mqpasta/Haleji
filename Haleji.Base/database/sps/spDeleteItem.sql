-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteItem' 
)
   DROP PROCEDURE dbo.spDeleteItem
GO

CREATE PROCEDURE dbo.spDeleteItem
	@ItemId bigint
AS
	DELETE FROM Item WHERE ItemId = @ItemId

GO
