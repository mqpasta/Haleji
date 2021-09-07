-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertPurchase' 
)
   DROP PROCEDURE dbo.spInsertPurchase
GO

CREATE PROCEDURE dbo.spInsertPurchase
	 @ItemId bigint ,
	 @VendorId bigint ,
	 @PurchaseDate date ,
	 @StartDate date = NULL,
	 @EndDate date = NULL,
	 @PONumber nvarchar(50) = NULL,
	 @InvoiceNumber nvarchar(50) = NULL,
	 @Description nvarchar(500) = NULL,
	 @TagNo nvarchar(50), 
	 @TransTypeId bigint
AS
	DECLARE @PurchaseId bigint

	BEGIN TRAN
	INSERT INTO		Purchase (
						ItemId, VendorId, PurchaseDate, StartDate, EndDate,
						PONumber, InvoiceNumber, Description, TagNo)
					VALUES (@ItemId, @VendorId, @PurchaseDate, @StartDate, @EndDate,
							@PONumber, @InvoiceNumber, @Description, @TagNo)
	SET @PurchaseId = SCOPE_IDENTITY()

	INSERT INTO		Movement (TransTypeId, PurchaseId, MovDate, IsActive)
					VALUES (@TransTypeId, @PurchaseId, @PurchaseDate, 1)

	COMMIT

					
GO

