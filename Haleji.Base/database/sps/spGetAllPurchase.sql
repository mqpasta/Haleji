-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllPurchase' 
)
   DROP PROCEDURE dbo.spGetAllPurchase
GO

CREATE PROCEDURE dbo.spGetAllPurchase
AS
	SELECT	P.*, I.ItemName, V.VendorName
	FROM	Purchase P Inner Join Item I ON P.ItemId = I.ItemId
			Inner Join Vendor V ON P.VendorId = V.VendorId
GO

