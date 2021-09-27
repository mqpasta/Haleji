-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchPurchaseDetails' 
)
   DROP PROCEDURE dbo.spSearchPurchaseDetails
GO

CREATE PROCEDURE dbo.spSearchPurchaseDetails
	 @PurchaseDetailsId bigint = NULL,
	 @PurchaseId bigint = NULL,
	 @ItemDetailsId bigint = NULL,
	 @Description nvarchar(50) = NULL
AS
	SELECT * FROM PurchaseDetails

	WHERE (@PurchaseDetailsId IS NULL OR PurchaseDetails.PurchaseDetailsId = @PurchaseDetailsId)
		AND (@PurchaseId IS NULL OR PurchaseDetails.PurchaseId = @PurchaseId)
		AND (@ItemDetailsId IS NULL OR PurchaseDetails.ItemDetailsId = @ItemDetailsId)
		AND (@Description IS NULL OR PurchaseDetails.Description LIKE '%'+@Description+'%')
GO




