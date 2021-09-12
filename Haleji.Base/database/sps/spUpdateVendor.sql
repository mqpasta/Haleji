-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateVendor' 
)
   DROP PROCEDURE dbo.spUpdateVendor
GO

CREATE PROCEDURE dbo.spUpdateVendor
	@VendorId bigint,
	@VendorName nvarchar(100),
	@Address nvarchar(250) = NULL,
	@ContactPerson nvarchar(100) = NULL,
	@Contact nvarchar(50) = NULL,
	@Note nvarchar(max) = NULL
AS
	UPDATE	Vendor 
	SET		VendorName = @VendorName,
			Address = @Address,
			ContactPerson = @ContactPerson,
			Contact = @Contact,
			Note = @Note
	WHERE	VendorId = @VendorId
GO


