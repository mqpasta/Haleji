
IF EXISTS(
	SELECT * 
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_SCHEMA = N'dbo'
	AND SPECIFIC_NAME = N'spUpdateItemDetails'
)

	DROP PROCEDURE dbo.spUpdateItemDetails
GO

CREATE PROCEDURE dbo.spUpdateItemDetails
	@ItemDetailsId bigint,
	@ItemId bigint,
	@Specifications nvarchar(500) = NULL

AS

	BEGIN TRAN

	UPDATE ItemDetails
	SET		Specifications = @Specifications

	WHERE ItemDetailsId = @ItemDetailsId and ItemId = @ItemId

	COMMIT

GO

select * from ItemDetails;
select * from Purchasedetails;