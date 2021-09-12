-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchPurchase' 
)
   DROP PROCEDURE dbo.spSearchPurchase
GO

CREATE PROCEDURE dbo.spSearchPurchase
	 @PurchaseId bigint = NULL,
	 @ItemId bigint = NULL,
	 @VendorId bigint = NULL,
	 @PurchaseDate date = NULL,
	 @StartDate date = NULL,
	 @EndDate date = NULL,
	 @PONumber nvarchar(50) = NULL,
	 @InvoiceNumber nvarchar(50) = NULL,
	 @Description nvarchar(500) = NULL,
	 @TagNo nvarchar(50) = NULL,
	 @TransTypeId bigint = NULL
AS
	SELECT	P.*, I.ItemName, V.VendorName
	FROM	Purchase P Inner Join Item I ON P.ItemId = I.ItemId
			Inner Join Vendor V ON P.VendorId = V.VendorId
	WHERE (@PurchaseId IS NULL OR P.PurchaseId = @PurchaseId)
		AND (@ItemId IS NULL OR P.ItemId = @ItemId)
		AND (@VendorId IS NULL OR P.VendorId = @VendorId)
		AND (@PurchaseDate IS NULL OR PurchaseDate = DATEADD(dd, DATEDIFF(dd, 0, @PurchaseDate), 0))
		AND (@StartDate IS NULL OR StartDate = DATEADD(dd, DATEDIFF(dd, 0, @PurchaseDate), 0))
		AND (@EndDate IS NULL OR StartDate = DATEADD(dd, DATEDIFF(dd, 0, @EndDate), 0))
		AND (@PONumber IS NULL OR PONumber Like '%'+@PONumber+'%')
		AND (@InvoiceNumber IS NULL OR @InvoiceNumber Like '%'+@InvoiceNumber +'%')
		AND (@Description IS NULL OR P.Description LIKE '%'+@Description+'%')
		AND (@TagNo IS NULL OR P.TagNo LIKE '%'+@TagNo+'%')
		AND (@TransTypeId IS NULL OR P.CurrentTransType = @TransTypeId)
GO

