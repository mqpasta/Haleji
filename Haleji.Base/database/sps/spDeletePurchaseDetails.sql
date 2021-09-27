IF EXISTS(
	SELECT *
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_SCHEMA = N'dbo'
	AND SPECIFIC_NAME = N'spDeletePurchaseDetails'

)
	DROP PROCEDURE dbo.spDeletePurchaseDetails

GO

CREATE PROCEDURE dbo.spDeletePurchaseDetails
	@PurchaseId bigint

AS 
	delete PurchaseDetails from PurchaseDetails 
	inner join ItemDetails on ItemDetails.ItemDetailsId = PurchaseDetails.ItemDetailsId 
	inner join Purchase on Purchase.ItemId = ItemDetails.ItemId 
	where PurchaseDetails.PurchaseId=@PurchaseId;

GO




