

IF EXISTS(
	SELECT *
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_SCHEMA = N'dbo'
	AND SPECIFIC_NAME = N'spGetAllPurchaseDetailsId'
)

	DROP PROCEDURE dbo.spGetAllPurchaseDetailsId

GO

CREATE PROCEDURE dbo.spGetAllPurchaseDetailsId
	@PurchaseId bigint
AS 
	select * from PurchaseDetails where PurchaseId=@PurchaseId;

GO