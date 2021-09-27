
IF EXISTS(
	SELECT *
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_SCHEMA = N'dbo'
	AND SPECIFIC_NAME = N'spGetAllPurchaseDetails'
)

	DROP PROCEDURE dbo.spGetAllPurchaseDetails

GO

CREATE PROCEDURE dbo.spGetAllPurchaseDetails
AS 
	select PD.* ,I.ItemId, I.ItemName 
	from PurchaseDetails PD 
	inner join Purchase P on PD.PurchaseId = P.PurchaseId 
	inner join Item I on P.ItemId = I.ItemId;

GO