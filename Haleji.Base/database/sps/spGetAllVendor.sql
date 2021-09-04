-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllVendor' 
)
   DROP PROCEDURE dbo.spGetAllVendor
GO

CREATE PROCEDURE dbo.spGetAllVendor
AS
	SELECT	* 
	FROM	Vendor

GO
