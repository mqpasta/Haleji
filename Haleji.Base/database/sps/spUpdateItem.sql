-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateItem' 
)
   DROP PROCEDURE dbo.spUpdateItem
GO

CREATE PROCEDURE dbo.spUpdateItem
	@ItemId bigint,
	@ItemName nvarchar(200),
	@ItemDescription nvarchar(1000) = NULL
AS
	UPDATE Item 
		SET ItemName = @ItemName, Description = @ItemDescription
	WHERE ItemId = @ItemId

GO
