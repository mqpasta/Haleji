-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchItem' 
)
   DROP PROCEDURE dbo.spSearchItem
GO

CREATE PROCEDURE dbo.spSearchItem
	@ItemId bigint = NULL,
	@ItemName nvarchar(200) = NULL,
	@ItemDescription nvarchar(1000) = NULL
AS
	SELECT * FROM Item
	WHERE (@ItemId IS NULL OR ItemId = @ItemId)
	AND (@ItemName IS NULL OR ItemName LIKE '%'+@ItemName+'%')
	AND (@ItemDescription IS NULL OR Description LIKE '%'+@ItemDescription+'%')

GO

