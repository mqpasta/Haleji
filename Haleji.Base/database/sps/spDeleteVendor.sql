-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteVendor' 
)
   DROP PROCEDURE dbo.spDeleteVendor
GO

CREATE PROCEDURE dbo.spDeleteVendor
	@VendorId bigint = NULL
AS
	DELETE FROM Vendor WHERE VendorId = @VendorId
GO


