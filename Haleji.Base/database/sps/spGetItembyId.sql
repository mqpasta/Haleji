
IF EXISTS(
	SELECT *
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_SCHEMA = N'dbo'
	AND SPECIFIC_NAME = N'spGetItembyId'
)
	DROP PROCEDURE dbo.spGetItembyId

GO

CREATE PROCEDURE dbo.spGetItembyId
	@PurchaseId bigint

AS
	
	select PD.*, ID.Specifications, I.ItemName
	from PurchaseDetails PD 
	Inner Join ItemDetails ID ON PD.ItemDetailsId = ID.ItemDetailsId inner join Item I 
	on I.ItemId = ID.ItemId
	Where PurchaseId = @PurchaseId;

GO


