-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertItem' 
)
   DROP PROCEDURE dbo.spInsertItem
GO

CREATE PROCEDURE dbo.spInsertItem
	@ItemName nvarchar(200),
	@ItemDescription nvarchar(1000) = NULL
AS
	INSERT INTO Item (ItemName, Description)
		VALUES (@ItemName, @ItemDescription)

	SELECT SCOPE_IDENTITY()
GO
