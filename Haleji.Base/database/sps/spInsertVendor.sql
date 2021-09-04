-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertVendor' 
)
   DROP PROCEDURE dbo.spInsertVendor
GO

CREATE PROCEDURE dbo.spInsertVendor
	@VendorName nvarchar(100),
	@Address nvarchar(250) = NULL,
	@ContactPerson nvarchar(100) = NULL,
	@Contact nvarchar(50) = NULL,
	@Note nvarchar(max) = NULL
AS
	Insert Into Vendor (VendorName, Address, ContactPerson, Contact, Note)
		VALUES (@VendorName, @Address, @ContactPerson, @Contact, @Note)

	SELECT SCOPE_IDENTITY()
GO


