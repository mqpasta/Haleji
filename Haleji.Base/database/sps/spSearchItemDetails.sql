-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchItemDetails' 
)
   DROP PROCEDURE dbo.spSearchItemDetails
GO

CREATE PROCEDURE dbo.spSearchItemDetails
	 @ItemDetailsId bigint = NULL,
	 @ItemId bigint = NULL,
	 @Specifications nvarchar(50) = NULL
AS
	SELECT ID.*,I.ItemName
	FROM ItemDetails ID inner join Item I on ID.ItemId = I.ItemId

	WHERE (@ItemDetailsId IS NULL OR ID.ItemDetailsId = @ItemDetailsId)
		AND (@ItemId IS NULL OR I.ItemId = @ItemId)
		AND (@Specifications IS NULL OR ID.Specifications LIKE '%'+@Specifications+'%')
GO



