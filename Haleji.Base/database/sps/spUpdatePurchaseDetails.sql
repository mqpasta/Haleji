

IF EXISTS(
	SELECT * 
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_SCHEMA = N'dbo'
	AND SPECIFIC_NAME = N'spUpdatePurchaseDetails'
)

	DROP PROCEDURE dbo.spUpdatePurchaseDetails
GO

CREATE PROCEDURE dbo.spUpdatePurchaseDetails
	@PurchaseDetailsId bigint,
    @PurchaseId bigint,
	@ItemDetailsId bigint,
	@Description nvarchar(500) = NULL

AS

	BEGIN TRAN

	UPDATE PurchaseDetails
	SET		Description = @Description

	WHERE PurchaseDetailsId = @PurchaseDetailsId
    and PurchaseId = @PurchaseId and ItemDetailsId = @ItemDetailsId

	COMMIT

GO
