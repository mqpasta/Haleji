-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertItemDetails' 
)
   DROP PROCEDURE dbo.spInsertItemDetails
GO

CREATE PROCEDURE dbo.spInsertItemDetails
	 @ItemId bigint ,
	 @Specifications nvarchar(500) = NULL
AS
	DECLARE @ItemDetailsId bigint

	BEGIN TRAN
	INSERT INTO		ItemDetails(
						ItemId,Specifications)
					VALUES (@ItemId, @Specifications)
	SET @ItemDetailsId = SCOPE_IDENTITY()

	COMMIT

					
GO