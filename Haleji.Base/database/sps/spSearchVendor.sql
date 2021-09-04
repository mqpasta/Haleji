-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchVendor' 
)
   DROP PROCEDURE dbo.spSearchVendor
GO

CREATE PROCEDURE dbo.spSearchVendor
	@VendorId bigint = NULL,
	@VendorName nvarchar(100) = NULL,
	@Address nvarchar(250) = NULL,
	@ContactPerson nvarchar(100) = NULL,
	@Contact nvarchar(50) = NULL,
	@Note nvarchar(max) = NULL
AS
	SELECT	* 
	FROM	Vendor
	WHERE	1 = 1
		AND (@VendorId IS NULL OR VendorId = @VendorId)
		AND (@VendorName IS NULL OR VendorName LIKE '%'+@VendorName+'%')
		AND (@Address IS NULL OR Address LIKE '%'+@Address+'%')
		AND (@ContactPerson IS NULL OR ContactPerson LIKE '%'+@ContactPerson+'%')
		AND (@Contact IS NULL OR Contact LIKE '%'+@Contact+'%')
		AND (@Note IS NULL OR Note LIKE '%'+@Note+'%')
GO


