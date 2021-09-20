-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteDepartment' 
)
   DROP PROCEDURE dbo.spDeleteDepartment
GO

CREATE PROCEDURE dbo.spDeleteDepartment
	@DepartmentId bigint
AS
	DELETE FROM Department 
	WHERE	DepartmentId = @DepartmentId
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteItem' 
)
   DROP PROCEDURE dbo.spDeleteItem
GO

CREATE PROCEDURE dbo.spDeleteItem
	@ItemId bigint
AS
	DELETE FROM Item WHERE ItemId = @ItemId

GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteLocation' 
)
   DROP PROCEDURE dbo.spDeleteLocation
GO

CREATE PROCEDURE dbo.spDeleteLocation
	@LocationId bigint
AS
	DELETE FROM Location WHERE LocationId = @LocationId
GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteMovement' 
)
   DROP PROCEDURE dbo.spDeleteMovement
GO

CREATE PROCEDURE dbo.spDeleteMovement
	@MovementId bigint
AS
	DELETE FROM Movement
	 WHERE MovementId = @MovementId

GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeletePerson' 
)
   DROP PROCEDURE dbo.spDeletePerson
GO

CREATE PROCEDURE dbo.spDeletePerson
	@PersonId bigint
AS
	DELETE FROM Person WHERE PersonId = @PersonId
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeletePurchase' 
)
   DROP PROCEDURE dbo.spDeletePurchase
GO

CREATE PROCEDURE dbo.spDeletePurchase
	 @PurchaseId bigint,
	 @TransTypeId bigint
AS
	IF NOT EXISTS(SELECT 1 FROM Movement WHERE PurchaseId = @PurchaseId and TransTypeId <> @TransTypeId)
	BEGIN
		BEGIN TRAN
		DELETE FROM Movement WHERE PurchaseId = @PurchaseId and TransTypeId = @TransTypeId
		DELETE FROM Purchase WHERE PurchaseId = @PurchaseId
		COMMIT
	END
	ELSE
	BEGIN
		RAISERROR('The purchase cannot be deleted as item arleady issued.',16,1)
	END
	
GO

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


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spEditPerson' 
)
   DROP PROCEDURE dbo.spEditPerson
GO

CREATE PROCEDURE dbo.spEditPerson
	@PersonId bigint,
	@DepartmentId bigint = NULL,
	@Name nvarchar(200),
	@Ext nvarchar(100) = NULL,
	@Contact nvarchar(100) = NULL,
	@IsActive bit = 1
AS
	UPDATE Person 
	SET		DepartmentId = @DepartmentId,
			Name  = @Name,
			Ext = @Ext,
			Contact = @Contact,
			IsActive = @IsActive
	WHERE	PersonId = @PersonId
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllDepartment' 
)
   DROP PROCEDURE dbo.spGetAllDepartment
GO

CREATE PROCEDURE dbo.spGetAllDepartment
AS
	SELECT * FROM Department 
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllItem' 
)
   DROP PROCEDURE dbo.spGetAllItem
GO

CREATE PROCEDURE dbo.spGetAllItem
AS
	SELECT * FROM Item

GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllLocation' 
)
   DROP PROCEDURE dbo.spGetAllLocation
GO

CREATE PROCEDURE dbo.spGetAllLocation
AS
	SELECT * FROM Location
GO

-- =============================================
-- Example to execute the stored procedure
-- =============================================
--EXECUTE dbo.spGetAllLocation 
--GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllPerson' 
)
   DROP PROCEDURE dbo.spGetAllPerson
GO

CREATE PROCEDURE dbo.spGetAllPerson
AS
	SELECT P.* , D.DepartmentName
	FROM Person P LEFT JOIN Department D ON P.DepartmentId = D.DepartmentId
GO


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
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertDepartment' 
)
   DROP PROCEDURE dbo.spInsertDepartment
GO

CREATE PROCEDURE dbo.spInsertDepartment
	@DepartmentName nvarchar(200)
AS
	Insert Into Department (DepartmentName) VALUES(@DepartmentName)
	SELECT SCOPE_IDENTITY()
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertItem' 
)
   DROP PROCEDURE dbo.spInsertItem
GO

CREATE PROCEDURE dbo.spInsertItem
	@ItemName nvarchar(200),
	@ItemDescription nvarchar(1000) = NULL
AS
	INSERT INTO Item (ItemName, Description)
		VALUES (@ItemName, @ItemDescription)

	SELECT SCOPE_IDENTITY()
GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertLocation' 
)
   DROP PROCEDURE dbo.spInsertLocation
GO

CREATE PROCEDURE dbo.spInsertLocation
	@LocationName nvarchar(200)
AS
	INSERT INTO Location (LocationName) VALUES(@LocationName)
	SELECT SCOPE_IDENTITY()
GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertMovement' 
)
   DROP PROCEDURE dbo.spInsertMovement
GO

CREATE PROCEDURE dbo.spInsertMovement
	@TransTypeId bigint ,
	@PersonId bigint = NULL,
	@LocationId bigint = NULL,
	@PurchaseId bigint = NULL,
	@MovDate date ,
	@IsActive bit ,
	@ParentMovement bigint = NULL
AS

	INSERT INTO Movement (TransTypeId, PersonId, LocationId, PurchaseId,
					MovDate, IsActive, ParentMovement)
		VALUES (@TransTypeId, @PersonId, @LocationId, @PurchaseId,
				@MovDate, @IsActive, @ParentMovement)

GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertPerson' 
)
   DROP PROCEDURE dbo.spInsertPerson
GO

CREATE PROCEDURE dbo.spInsertPerson
	@DepartmentId bigint = NULL,
	@Name nvarchar(200),
	@Ext nvarchar(100) = NULL,
	@Contact nvarchar(100) = NULL,
	@IsActive bit = 1
AS
	Insert Into Person (DepartmentId, Name, Ext, Contact, IsActive)
		VALUES (@DepartmentId, @Name, @Ext, @Contact, @IsActive)

	SELECT SCOPE_IDENTITY()
GO


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
						PONumber, InvoiceNumber, Description, TagNo, CurrentTransType)
					VALUES (@ItemId, @VendorId, @PurchaseDate, @StartDate, @EndDate,
							@PONumber, @InvoiceNumber, @Description, @TagNo, @TransTypeId)
	SET @PurchaseId = SCOPE_IDENTITY()

	INSERT INTO		Movement (TransTypeId, PurchaseId, MovDate, IsActive)
					VALUES (@TransTypeId, @PurchaseId, @PurchaseDate, 0)

	COMMIT

					
GO

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


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchDepartment' 
)
   DROP PROCEDURE dbo.spSearchDepartment
GO

CREATE PROCEDURE dbo.spSearchDepartment
	@DepartmentId bigint = NULL,
	@DepartmentName nvarchar(200) = NULL
AS
	SELECT * FROM Department 
	WHERE (@DepartmentId IS NULL OR DepartmentId = @DepartmentId)
	AND (@DepartmentName IS NULL OR DepartmentName LIKE '%'+@DepartmentName+'%')

GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchItem' 
)
   DROP PROCEDURE dbo.spSearchItem
GO

CREATE PROCEDURE dbo.spSearchItem
	@ItemId bigint = NULL,
	@ItemName nvarchar(200) = NULL,
	@ItemDescription nvarchar(1000) = NULL
AS
	SELECT * FROM Item
	WHERE (@ItemId IS NULL OR ItemId = @ItemId)
	AND (@ItemName IS NULL OR ItemName LIKE '%'+@ItemName+'%')
	AND (@ItemDescription IS NULL OR Description LIKE '%'+@ItemDescription+'%')

GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchLocation' 
)
   DROP PROCEDURE dbo.spSearchLocation
GO

CREATE PROCEDURE dbo.spSearchLocation
	@LocationId bigint  = NULL, 
	@LocationName nvarchar(200) = NULL
AS
	SELECT	* 
	FROM	Location
	WHERE (@LocationId IS NULL OR LocationId = @LocationId) 
	AND (@LocationName IS NULL OR LocationName = @LocationName)
GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchMovement' 
)
   DROP PROCEDURE dbo.spSearchMovement
GO

CREATE PROCEDURE dbo.spSearchMovement
	@MovementId bigint = NULL,
	@TransTypeId bigint = NULL,
	@PersonId bigint = NULL,
	@LocationId bigint = NULL,
	@PurchaseId bigint = NULL,
	@MovDate date = NULL,
	@IsActive bit = NULL,
	@ParentMovement bigint = NULL
AS
	;with cteItems(PurchaseId, ItemName) 
	AS (
		SElECT P.PurchaseId, I.ItemName + '(' + P.TagNo + ')' AS ItemName
		FROM Item I Inner Join Purchase P ON I.ItemId = P.ItemId
	)
	SELECT	M.*, I.ItemName, L.LocationName, P.Name
	FROM Movement M  Left Join cteItems I ON M.PurchaseId = I.PurchaseId
		LEFT JOIN Location L ON L.LocationId = M.LocationId
		Left Join Person P ON P.PersonId = M.PersonId		
	WHERE (@MovementId IS NULL OR MovementId = @MovementId)
	AND (@TransTypeId IS NULL OR TransTypeId = @TransTypeId)
	AND (@PersonId IS NULL OR M.PersonId = @PersonId)
	AND (@LocationId IS NULL OR M.LocationId = @LocationId)
	AND (@PurchaseId IS NULL OR M.PurchaseId = @PurchaseId)
	AND (@MovDate IS NULL OR MovDate = @MovDate)
	AND (@IsActive IS NULL OR M.IsActive = @IsActive)
	AND (@ParentMovement IS NULL OR ParentMovement = @ParentMovement)
GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchPerson' 
)
   DROP PROCEDURE dbo.spSearchPerson
GO

CREATE PROCEDURE dbo.spSearchPerson
	@PersonId bigint = NULL,
	@DepartmentId bigint = NULL,
	@Name nvarchar(200) = NULL,
	@Ext nvarchar(100) = NULL,
	@Contact nvarchar(100) = NULL,
	@IsActive bit = NULL
AS
	SELECT	P.*, D.DepartmentName
	FROM	Person P Left JOIN Department D ON P.DepartmentId = D.DepartmentId
	WHERE	(@PersonId IS NULL OR PersonId=@PersonId)
		AND	(@DepartmentId IS NULL OR P.DepartmentId = @DepartmentId)
		AND (@Name IS NULL OR Name LIKE '%'+@Name+'%')
		AND (@Ext IS NULL OR Ext LIKE '%'+@Ext+'%')
		AND (@Contact IS NULL OR Contact LIKE '%'+@Contact+'%')
		AND (@IsActive IS NULL OR IsActive = @IsActive)
GO


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


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateDepartment' 
)
   DROP PROCEDURE dbo.spUpdateDepartment
GO

CREATE PROCEDURE dbo.spUpdateDepartment
	@DepartmentId bigint,
	@DepartmentName nvarchar(200)
AS
	UPDATE Department SET DepartmentName = @DepartmentName 
	WHERE	DepartmentId = @DepartmentId
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateItem' 
)
   DROP PROCEDURE dbo.spUpdateItem
GO

CREATE PROCEDURE dbo.spUpdateItem
	@ItemId bigint,
	@ItemName nvarchar(200),
	@ItemDescription nvarchar(1000) = NULL
AS
	UPDATE Item 
		SET ItemName = @ItemName, Description = @ItemDescription
	WHERE ItemId = @ItemId

GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateLocation' 
)
   DROP PROCEDURE dbo.spUpdateLocation
GO

CREATE PROCEDURE dbo.spUpdateLocation
	@LocationId bigint, 
	@LocationName nvarchar(200)
AS
	UPDATE Location
	SET LocationName = @LocationName
	WHERE LocationId = @LocationId
GO

-- =============================================
-- Example to execute the stored procedure
-- =============================================
--EXECUTE dbo.spUpdateLocation 1, 2
--GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateMovement' 
)
   DROP PROCEDURE dbo.spUpdateMovement
GO

CREATE PROCEDURE dbo.spUpdateMovement
	@MovementId bigint,
	@TransTypeId bigint ,
	@PersonId bigint = NULL,
	@LocationId bigint = NULL,
	@PurchaseId bigint = NULL,
	@MovDate date ,
	@IsActive bit ,
	@ParentMovement bigint = NULL
AS
	UPDATE [dbo].[Movement]
	   SET [TransTypeId] = @TransTypeId
		  ,[PersonId] = @PersonId
		  ,[LocationId] = @LocationId
		  ,[PurchaseId] = @PurchaseId
		  ,[MovDate] = @MovDate
		  ,[IsActive] = @IsActive
		  ,[ParentMovement] = @ParentMovement
	 WHERE MovementId = @MovementId

GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdatePerson' 
)
   DROP PROCEDURE dbo.spUpdatePerson
GO

CREATE PROCEDURE dbo.spUpdatePerson
	@PersonId bigint,
	@DepartmentId bigint = NULL,
	@Name nvarchar(200),
	@Ext nvarchar(100) = NULL,
	@Contact nvarchar(100) = NULL,
	@IsActive bit = 1
AS
	UPDATE	Person
		SET	Name = @Name,
			DepartmentId = @DepartmentId,
			Ext = @Ext,
			Contact = @Contact,
			IsActive = @IsActive
	WHERE	PersonId = @PersonId

GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdatePurchase' 
)
   DROP PROCEDURE dbo.spUpdatePurchase
GO

CREATE PROCEDURE dbo.spUpdatePurchase
	 @PurchaseId bigint,
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

	BEGIN TRAN

	UPDATE	Purchase
	SET		ItemId = @ItemId, 
			VendorId = @VendorId, 
			PurchaseDate = @PurchaseDate, 
			StartDate = @StartDate, 
			EndDate= @EndDate,
			PONumber = @PONumber, 
			InvoiceNumber = @InvoiceNumber, 
			Description = @Description, 
			TagNo = @TagNo
	WHERE	PurchaseId = @PurchaseId

	UPDATE	Movement
	SET		MovDate = @PurchaseDate
	WHERE	PurchaseId = @PurchaseId

	COMMIT
					
GO

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


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteDepartment' 
)
   DROP PROCEDURE dbo.spDeleteDepartment
GO

CREATE PROCEDURE dbo.spDeleteDepartment
	@DepartmentId bigint
AS
	DELETE FROM Department 
	WHERE	DepartmentId = @DepartmentId
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteItem' 
)
   DROP PROCEDURE dbo.spDeleteItem
GO

CREATE PROCEDURE dbo.spDeleteItem
	@ItemId bigint
AS
	DELETE FROM Item WHERE ItemId = @ItemId

GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteLocation' 
)
   DROP PROCEDURE dbo.spDeleteLocation
GO

CREATE PROCEDURE dbo.spDeleteLocation
	@LocationId bigint
AS
	DELETE FROM Location WHERE LocationId = @LocationId
GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteMovement' 
)
   DROP PROCEDURE dbo.spDeleteMovement
GO

CREATE PROCEDURE dbo.spDeleteMovement
	@MovementId bigint
AS
	DELETE FROM Movement
	 WHERE MovementId = @MovementId

GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeletePerson' 
)
   DROP PROCEDURE dbo.spDeletePerson
GO

CREATE PROCEDURE dbo.spDeletePerson
	@PersonId bigint
AS
	DELETE FROM Person WHERE PersonId = @PersonId
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeletePurchase' 
)
   DROP PROCEDURE dbo.spDeletePurchase
GO

CREATE PROCEDURE dbo.spDeletePurchase
	 @PurchaseId bigint,
	 @TransTypeId bigint
AS
	IF NOT EXISTS(SELECT 1 FROM Movement WHERE PurchaseId = @PurchaseId and TransTypeId <> @TransTypeId)
	BEGIN
		BEGIN TRAN
		DELETE FROM Movement WHERE PurchaseId = @PurchaseId and TransTypeId = @TransTypeId
		DELETE FROM Purchase WHERE PurchaseId = @PurchaseId
		COMMIT
	END
	ELSE
	BEGIN
		RAISERROR('The purchase cannot be deleted as item arleady issued.',16,1)
	END
	
GO

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


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spEditPerson' 
)
   DROP PROCEDURE dbo.spEditPerson
GO

CREATE PROCEDURE dbo.spEditPerson
	@PersonId bigint,
	@DepartmentId bigint = NULL,
	@Name nvarchar(200),
	@Ext nvarchar(100) = NULL,
	@Contact nvarchar(100) = NULL,
	@IsActive bit = 1
AS
	UPDATE Person 
	SET		DepartmentId = @DepartmentId,
			Name  = @Name,
			Ext = @Ext,
			Contact = @Contact,
			IsActive = @IsActive
	WHERE	PersonId = @PersonId
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllDepartment' 
)
   DROP PROCEDURE dbo.spGetAllDepartment
GO

CREATE PROCEDURE dbo.spGetAllDepartment
AS
	SELECT * FROM Department 
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllItem' 
)
   DROP PROCEDURE dbo.spGetAllItem
GO

CREATE PROCEDURE dbo.spGetAllItem
AS
	SELECT * FROM Item

GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllLocation' 
)
   DROP PROCEDURE dbo.spGetAllLocation
GO

CREATE PROCEDURE dbo.spGetAllLocation
AS
	SELECT * FROM Location
GO

-- =============================================
-- Example to execute the stored procedure
-- =============================================
--EXECUTE dbo.spGetAllLocation 
--GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllPerson' 
)
   DROP PROCEDURE dbo.spGetAllPerson
GO

CREATE PROCEDURE dbo.spGetAllPerson
AS
	SELECT P.* , D.DepartmentName
	FROM Person P LEFT JOIN Department D ON P.DepartmentId = D.DepartmentId
GO


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
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetStockSummary' 
)
   DROP PROCEDURE dbo.spGetStockSummary
GO

CREATE PROCEDURE dbo.spGetStockSummary
AS
	

;with cte_avilable AS (
	SELECT I.ItemId, P.CurrentTransType, COUNT(1) AS [QTY] 
	FROM Purchase P 
			INNER JOIN Item I ON I.ItemId = P.ItemId
			INNER JOIN TransType T ON T.TransTypeId = P.CurrentTransType
	WHERE P.CurrentTransType = 1 
	GROUP BY I.ItemId, P.CurrentTransType
), cte_Issued AS (
	SELECT I.ItemId, P.CurrentTransType, COUNT(1) AS [QTY] 
	FROM Purchase P 
			INNER JOIN Item I ON I.ItemId = P.ItemId
			INNER JOIN TransType T ON T.TransTypeId = P.CurrentTransType
	WHERE P.CurrentTransType = 2
	GROUP BY I.ItemId, P.CurrentTransType
), cte_scrap AS (
	SELECT I.ItemId, P.CurrentTransType, COUNT(1) AS [QTY] 
	FROM Purchase P 
			INNER JOIN Item I ON I.ItemId = P.ItemId
			INNER JOIN TransType T ON T.TransTypeId = P.CurrentTransType
	WHERE P.CurrentTransType = 3
	GROUP BY I.ItemId, P.CurrentTransType
), cte_OutOfStock AS (
	SELECT I.ItemId, P.CurrentTransType, COUNT(1) AS [QTY] 
	FROM Purchase P 
			INNER JOIN Item I ON I.ItemId = P.ItemId
			INNER JOIN TransType T ON T.TransTypeId = P.CurrentTransType
	WHERE P.CurrentTransType = 4
	GROUP BY I.ItemId, P.CurrentTransType
)
select	Item.*,
		ISNULL(A.QTY,0) as AvailableQty,
		ISNULL(I.QTY,0) as IssuedQty,
		ISNULL(O.QTY,0) as OutQty,
		ISNULL(S.QTY,0) as ScrappedQty
from	Item 
			LEFT JOIN cte_avilable A ON A.ItemId = Item.ItemId
			LEFT JOIN cte_Issued I ON I.ItemId = A.ItemId
			LEFT JOIN cte_OutOfStock O ON O.ItemId = A.ItemId
			LEFT JOIN cte_scrap S ON S.ItemId = A.ItemId

GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertDepartment' 
)
   DROP PROCEDURE dbo.spInsertDepartment
GO

CREATE PROCEDURE dbo.spInsertDepartment
	@DepartmentName nvarchar(200)
AS
	Insert Into Department (DepartmentName) VALUES(@DepartmentName)
	SELECT SCOPE_IDENTITY()
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertItem' 
)
   DROP PROCEDURE dbo.spInsertItem
GO

CREATE PROCEDURE dbo.spInsertItem
	@ItemName nvarchar(200),
	@ItemDescription nvarchar(1000) = NULL
AS
	INSERT INTO Item (ItemName, Description)
		VALUES (@ItemName, @ItemDescription)

	SELECT SCOPE_IDENTITY()
GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertLocation' 
)
   DROP PROCEDURE dbo.spInsertLocation
GO

CREATE PROCEDURE dbo.spInsertLocation
	@LocationName nvarchar(200)
AS
	INSERT INTO Location (LocationName) VALUES(@LocationName)
	SELECT SCOPE_IDENTITY()
GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertMovement' 
)
   DROP PROCEDURE dbo.spInsertMovement
GO

CREATE PROCEDURE dbo.spInsertMovement
	@TransTypeId bigint ,
	@PersonId bigint = NULL,
	@LocationId bigint = NULL,
	@PurchaseId bigint = NULL,
	@MovDate date ,
	@IsActive bit ,
	@ParentMovement bigint = NULL
AS

	INSERT INTO Movement (TransTypeId, PersonId, LocationId, PurchaseId,
					MovDate, IsActive, ParentMovement)
		VALUES (@TransTypeId, @PersonId, @LocationId, @PurchaseId,
				@MovDate, @IsActive, @ParentMovement)

GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertPerson' 
)
   DROP PROCEDURE dbo.spInsertPerson
GO

CREATE PROCEDURE dbo.spInsertPerson
	@DepartmentId bigint = NULL,
	@Name nvarchar(200),
	@Ext nvarchar(100) = NULL,
	@Contact nvarchar(100) = NULL,
	@IsActive bit = 1
AS
	Insert Into Person (DepartmentId, Name, Ext, Contact, IsActive)
		VALUES (@DepartmentId, @Name, @Ext, @Contact, @IsActive)

	SELECT SCOPE_IDENTITY()
GO


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
						PONumber, InvoiceNumber, Description, TagNo, CurrentTransType)
					VALUES (@ItemId, @VendorId, @PurchaseDate, @StartDate, @EndDate,
							@PONumber, @InvoiceNumber, @Description, @TagNo, @TransTypeId)
	SET @PurchaseId = SCOPE_IDENTITY()

	INSERT INTO		Movement (TransTypeId, PurchaseId, MovDate, IsActive)
					VALUES (@TransTypeId, @PurchaseId, @PurchaseDate, 0)

	COMMIT

					
GO

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


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spMovementLedger' 
)
   DROP PROCEDURE dbo.spMovementLedger
GO

CREATE PROCEDURE dbo.spMovementLedger
	@TransTypeId bigint = NULL,
	@PersonId bigint = NULL,
	@LocationId bigint = NULL,
	@DepartmentId bigint = NULL,
	@PurchaseId bigint = NULL,
	@ItemId bigint = NULL,
	@StartDate date = NULL,
	@EndDate date = NULL
AS
	select  M.MovementId, M.MovDate, M.TransTypeId, T.TransTypeName,
		P.TagNo, I.ItemName,
		CASE WHEN PE.Name IS NULL THEN '' ELSE PE.Name END AS [Name],  
		CASE WHEN D.DepartmentName IS NULL THEN '' ELSE D.DepartmentName END AS DepartmentName, 
		CASE WHEN L.LocationName IS NULL THEN '' ELSE L.LocationName END AS LocationName
	from Movement M 
		Left Join Person PE ON PE.PersonId = M.PersonId
		Left Join Location L ON L.LocationId = M.LocationId
		Inner Join Purchase P ON P.PurchaseId = M.PurchaseId
		Inner Join Item I ON I.ItemId = P.ItemId
		Left Join Department D ON PE.DepartmentId = D.DepartmentId
		Inner Join TransType T ON T.TransTypeId = M.TransTypeId			
	WHERE 1 = 1
		AND (@TransTypeId IS NULL OR M.TransTypeId = @TransTypeId)
		AND (@PersonId IS NULL OR M.PersonId = @PersonId)
		AND (@LocationId IS NULL OR M.LocationId = @LocationId)
		AND (@PurchaseId IS NULL OR M.PurchaseId = @PurchaseId)
		AND (@ItemId IS NULL OR I.ItemId = @ItemId)
		AND (@DepartmentId IS NULL OR D.DepartmentId = @DepartmentId)
		AND (@StartDate IS NULL OR MovDate >= @StartDate)
		AND (@EndDate IS NULL OR MovDate <= @EndDate)
	ORDER BY m.MovDate 

GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchDepartment' 
)
   DROP PROCEDURE dbo.spSearchDepartment
GO

CREATE PROCEDURE dbo.spSearchDepartment
	@DepartmentId bigint = NULL,
	@DepartmentName nvarchar(200) = NULL
AS
	SELECT * FROM Department 
	WHERE (@DepartmentId IS NULL OR DepartmentId = @DepartmentId)
	AND (@DepartmentName IS NULL OR DepartmentName LIKE '%'+@DepartmentName+'%')

GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchItem' 
)
   DROP PROCEDURE dbo.spSearchItem
GO

CREATE PROCEDURE dbo.spSearchItem
	@ItemId bigint = NULL,
	@ItemName nvarchar(200) = NULL,
	@ItemDescription nvarchar(1000) = NULL
AS
	SELECT * FROM Item
	WHERE (@ItemId IS NULL OR ItemId = @ItemId)
	AND (@ItemName IS NULL OR ItemName LIKE '%'+@ItemName+'%')
	AND (@ItemDescription IS NULL OR Description LIKE '%'+@ItemDescription+'%')

GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchLocation' 
)
   DROP PROCEDURE dbo.spSearchLocation
GO

CREATE PROCEDURE dbo.spSearchLocation
	@LocationId bigint  = NULL, 
	@LocationName nvarchar(200) = NULL
AS
	SELECT	* 
	FROM	Location
	WHERE (@LocationId IS NULL OR LocationId = @LocationId) 
	AND (@LocationName IS NULL OR LocationName = @LocationName)
GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchMovement' 
)
   DROP PROCEDURE dbo.spSearchMovement
GO

CREATE PROCEDURE dbo.spSearchMovement
	@MovementId bigint = NULL,
	@TransTypeId bigint = NULL,
	@PersonId bigint = NULL,
	@LocationId bigint = NULL,
	@PurchaseId bigint = NULL,
	@StartDate date = NULL,
	@EndDate date = NULL,
	@IsActive bit = NULL,
	@ParentMovement bigint = NULL
AS
	;with cteItems(PurchaseId, ItemName) 
	AS (
		SElECT P.PurchaseId, I.ItemName + '(' + P.TagNo + ')' AS ItemName
		FROM Item I Inner Join Purchase P ON I.ItemId = P.ItemId
	)
	SELECT	M.*, I.ItemName, L.LocationName, P.Name
	FROM Movement M  Left Join cteItems I ON M.PurchaseId = I.PurchaseId
		LEFT JOIN Location L ON L.LocationId = M.LocationId
		Left Join Person P ON P.PersonId = M.PersonId		
	WHERE (@MovementId IS NULL OR MovementId = @MovementId)
		AND (@TransTypeId IS NULL OR TransTypeId = @TransTypeId)
		AND (@PersonId IS NULL OR M.PersonId = @PersonId)
		AND (@LocationId IS NULL OR M.LocationId = @LocationId)
		AND (@PurchaseId IS NULL OR M.PurchaseId = @PurchaseId)
		AND (@StartDate IS NULL OR MovDate >= @StartDate)
		AND (@EndDate IS NULL OR MovDate <= @EndDate)
		AND (@IsActive IS NULL OR M.IsActive = @IsActive)
		AND (@ParentMovement IS NULL OR ParentMovement = @ParentMovement)
	ORDER BY m.MovDate 

GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchPerson' 
)
   DROP PROCEDURE dbo.spSearchPerson
GO

CREATE PROCEDURE dbo.spSearchPerson
	@PersonId bigint = NULL,
	@DepartmentId bigint = NULL,
	@Name nvarchar(200) = NULL,
	@Ext nvarchar(100) = NULL,
	@Contact nvarchar(100) = NULL,
	@IsActive bit = NULL
AS
	SELECT	P.*, D.DepartmentName
	FROM	Person P Left JOIN Department D ON P.DepartmentId = D.DepartmentId
	WHERE	(@PersonId IS NULL OR PersonId=@PersonId)
		AND	(@DepartmentId IS NULL OR P.DepartmentId = @DepartmentId)
		AND (@Name IS NULL OR Name LIKE '%'+@Name+'%')
		AND (@Ext IS NULL OR Ext LIKE '%'+@Ext+'%')
		AND (@Contact IS NULL OR Contact LIKE '%'+@Contact+'%')
		AND (@IsActive IS NULL OR IsActive = @IsActive)
GO


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


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateDepartment' 
)
   DROP PROCEDURE dbo.spUpdateDepartment
GO

CREATE PROCEDURE dbo.spUpdateDepartment
	@DepartmentId bigint,
	@DepartmentName nvarchar(200)
AS
	UPDATE Department SET DepartmentName = @DepartmentName 
	WHERE	DepartmentId = @DepartmentId
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateItem' 
)
   DROP PROCEDURE dbo.spUpdateItem
GO

CREATE PROCEDURE dbo.spUpdateItem
	@ItemId bigint,
	@ItemName nvarchar(200),
	@ItemDescription nvarchar(1000) = NULL
AS
	UPDATE Item 
		SET ItemName = @ItemName, Description = @ItemDescription
	WHERE ItemId = @ItemId

GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateLocation' 
)
   DROP PROCEDURE dbo.spUpdateLocation
GO

CREATE PROCEDURE dbo.spUpdateLocation
	@LocationId bigint, 
	@LocationName nvarchar(200)
AS
	UPDATE Location
	SET LocationName = @LocationName
	WHERE LocationId = @LocationId
GO

-- =============================================
-- Example to execute the stored procedure
-- =============================================
--EXECUTE dbo.spUpdateLocation 1, 2
--GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateMovement' 
)
   DROP PROCEDURE dbo.spUpdateMovement
GO

CREATE PROCEDURE dbo.spUpdateMovement
	@MovementId bigint,
	@TransTypeId bigint ,
	@PersonId bigint = NULL,
	@LocationId bigint = NULL,
	@PurchaseId bigint = NULL,
	@MovDate date ,
	@IsActive bit ,
	@ParentMovement bigint = NULL
AS
	UPDATE [dbo].[Movement]
	   SET [TransTypeId] = @TransTypeId
		  ,[PersonId] = @PersonId
		  ,[LocationId] = @LocationId
		  ,[PurchaseId] = @PurchaseId
		  ,[MovDate] = @MovDate
		  ,[IsActive] = @IsActive
		  ,[ParentMovement] = @ParentMovement
	 WHERE MovementId = @MovementId

GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdatePerson' 
)
   DROP PROCEDURE dbo.spUpdatePerson
GO

CREATE PROCEDURE dbo.spUpdatePerson
	@PersonId bigint,
	@DepartmentId bigint = NULL,
	@Name nvarchar(200),
	@Ext nvarchar(100) = NULL,
	@Contact nvarchar(100) = NULL,
	@IsActive bit = 1
AS
	UPDATE	Person
		SET	Name = @Name,
			DepartmentId = @DepartmentId,
			Ext = @Ext,
			Contact = @Contact,
			IsActive = @IsActive
	WHERE	PersonId = @PersonId

GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdatePurchase' 
)
   DROP PROCEDURE dbo.spUpdatePurchase
GO

CREATE PROCEDURE dbo.spUpdatePurchase
	 @PurchaseId bigint,
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

	BEGIN TRAN

	UPDATE	Purchase
	SET		ItemId = @ItemId, 
			VendorId = @VendorId, 
			PurchaseDate = @PurchaseDate, 
			StartDate = @StartDate, 
			EndDate= @EndDate,
			PONumber = @PONumber, 
			InvoiceNumber = @InvoiceNumber, 
			Description = @Description, 
			TagNo = @TagNo
	WHERE	PurchaseId = @PurchaseId

	UPDATE	Movement
	SET		MovDate = @PurchaseDate
	WHERE	PurchaseId = @PurchaseId

	COMMIT
					
GO

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


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteDepartment' 
)
   DROP PROCEDURE dbo.spDeleteDepartment
GO

CREATE PROCEDURE dbo.spDeleteDepartment
	@DepartmentId bigint
AS
	DELETE FROM Department 
	WHERE	DepartmentId = @DepartmentId
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteItem' 
)
   DROP PROCEDURE dbo.spDeleteItem
GO

CREATE PROCEDURE dbo.spDeleteItem
	@ItemId bigint
AS
	DELETE FROM Item WHERE ItemId = @ItemId

GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteLocation' 
)
   DROP PROCEDURE dbo.spDeleteLocation
GO

CREATE PROCEDURE dbo.spDeleteLocation
	@LocationId bigint
AS
	DELETE FROM Location WHERE LocationId = @LocationId
GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeleteMovement' 
)
   DROP PROCEDURE dbo.spDeleteMovement
GO

CREATE PROCEDURE dbo.spDeleteMovement
	@MovementId bigint
AS
	DELETE FROM Movement
	 WHERE MovementId = @MovementId

GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeletePerson' 
)
   DROP PROCEDURE dbo.spDeletePerson
GO

CREATE PROCEDURE dbo.spDeletePerson
	@PersonId bigint
AS
	DELETE FROM Person WHERE PersonId = @PersonId
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spDeletePurchase' 
)
   DROP PROCEDURE dbo.spDeletePurchase
GO

CREATE PROCEDURE dbo.spDeletePurchase
	 @PurchaseId bigint,
	 @TransTypeId bigint
AS
	IF NOT EXISTS(SELECT 1 FROM Movement WHERE PurchaseId = @PurchaseId and TransTypeId <> @TransTypeId)
	BEGIN
		BEGIN TRAN
		DELETE FROM Movement WHERE PurchaseId = @PurchaseId and TransTypeId = @TransTypeId
		DELETE FROM Purchase WHERE PurchaseId = @PurchaseId
		COMMIT
	END
	ELSE
	BEGIN
		RAISERROR('The purchase cannot be deleted as item arleady issued.',16,1)
	END
	
GO

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


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spEditPerson' 
)
   DROP PROCEDURE dbo.spEditPerson
GO

CREATE PROCEDURE dbo.spEditPerson
	@PersonId bigint,
	@DepartmentId bigint = NULL,
	@Name nvarchar(200),
	@Ext nvarchar(100) = NULL,
	@Contact nvarchar(100) = NULL,
	@IsActive bit = 1
AS
	UPDATE Person 
	SET		DepartmentId = @DepartmentId,
			Name  = @Name,
			Ext = @Ext,
			Contact = @Contact,
			IsActive = @IsActive
	WHERE	PersonId = @PersonId
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllDepartment' 
)
   DROP PROCEDURE dbo.spGetAllDepartment
GO

CREATE PROCEDURE dbo.spGetAllDepartment
AS
	SELECT * FROM Department 
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllItem' 
)
   DROP PROCEDURE dbo.spGetAllItem
GO

CREATE PROCEDURE dbo.spGetAllItem
AS
	SELECT * FROM Item

GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllLocation' 
)
   DROP PROCEDURE dbo.spGetAllLocation
GO

CREATE PROCEDURE dbo.spGetAllLocation
AS
	SELECT * FROM Location
GO

-- =============================================
-- Example to execute the stored procedure
-- =============================================
--EXECUTE dbo.spGetAllLocation 
--GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetAllPerson' 
)
   DROP PROCEDURE dbo.spGetAllPerson
GO

CREATE PROCEDURE dbo.spGetAllPerson
AS
	SELECT P.* , D.DepartmentName
	FROM Person P LEFT JOIN Department D ON P.DepartmentId = D.DepartmentId
GO


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
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spGetStockSummary' 
)
   DROP PROCEDURE dbo.spGetStockSummary
GO

CREATE PROCEDURE dbo.spGetStockSummary
AS
	

;with cte_avilable AS (
	SELECT I.ItemId, P.CurrentTransType, COUNT(1) AS [QTY] 
	FROM Purchase P 
			INNER JOIN Item I ON I.ItemId = P.ItemId
			INNER JOIN TransType T ON T.TransTypeId = P.CurrentTransType
	WHERE P.CurrentTransType = 1 
	GROUP BY I.ItemId, P.CurrentTransType
), cte_Issued AS (
	SELECT I.ItemId, P.CurrentTransType, COUNT(1) AS [QTY] 
	FROM Purchase P 
			INNER JOIN Item I ON I.ItemId = P.ItemId
			INNER JOIN TransType T ON T.TransTypeId = P.CurrentTransType
	WHERE P.CurrentTransType = 2
	GROUP BY I.ItemId, P.CurrentTransType
), cte_scrap AS (
	SELECT I.ItemId, P.CurrentTransType, COUNT(1) AS [QTY] 
	FROM Purchase P 
			INNER JOIN Item I ON I.ItemId = P.ItemId
			INNER JOIN TransType T ON T.TransTypeId = P.CurrentTransType
	WHERE P.CurrentTransType = 3
	GROUP BY I.ItemId, P.CurrentTransType
), cte_OutOfStock AS (
	SELECT I.ItemId, P.CurrentTransType, COUNT(1) AS [QTY] 
	FROM Purchase P 
			INNER JOIN Item I ON I.ItemId = P.ItemId
			INNER JOIN TransType T ON T.TransTypeId = P.CurrentTransType
	WHERE P.CurrentTransType = 4
	GROUP BY I.ItemId, P.CurrentTransType
)
select	Item.*,
		ISNULL(A.QTY,0) as AvailableQty,
		ISNULL(I.QTY,0) as IssuedQty,
		ISNULL(O.QTY,0) as OutQty,
		ISNULL(S.QTY,0) as ScrappedQty
from	Item 
			LEFT JOIN cte_avilable A ON A.ItemId = Item.ItemId
			LEFT JOIN cte_Issued I ON I.ItemId = A.ItemId
			LEFT JOIN cte_OutOfStock O ON O.ItemId = A.ItemId
			LEFT JOIN cte_scrap S ON S.ItemId = A.ItemId

GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertDepartment' 
)
   DROP PROCEDURE dbo.spInsertDepartment
GO

CREATE PROCEDURE dbo.spInsertDepartment
	@DepartmentName nvarchar(200)
AS
	Insert Into Department (DepartmentName) VALUES(@DepartmentName)
	SELECT SCOPE_IDENTITY()
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertItem' 
)
   DROP PROCEDURE dbo.spInsertItem
GO

CREATE PROCEDURE dbo.spInsertItem
	@ItemName nvarchar(200),
	@ItemDescription nvarchar(1000) = NULL
AS
	INSERT INTO Item (ItemName, Description)
		VALUES (@ItemName, @ItemDescription)

	SELECT SCOPE_IDENTITY()
GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertLocation' 
)
   DROP PROCEDURE dbo.spInsertLocation
GO

CREATE PROCEDURE dbo.spInsertLocation
	@LocationName nvarchar(200)
AS
	INSERT INTO Location (LocationName) VALUES(@LocationName)
	SELECT SCOPE_IDENTITY()
GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertMovement' 
)
   DROP PROCEDURE dbo.spInsertMovement
GO

CREATE PROCEDURE dbo.spInsertMovement
	@TransTypeId bigint ,
	@PersonId bigint = NULL,
	@LocationId bigint = NULL,
	@PurchaseId bigint = NULL,
	@MovDate date ,
	@IsActive bit ,
	@ParentMovement bigint = NULL
AS

	INSERT INTO Movement (TransTypeId, PersonId, LocationId, PurchaseId,
					MovDate, IsActive, ParentMovement)
		VALUES (@TransTypeId, @PersonId, @LocationId, @PurchaseId,
				@MovDate, @IsActive, @ParentMovement)

GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spInsertPerson' 
)
   DROP PROCEDURE dbo.spInsertPerson
GO

CREATE PROCEDURE dbo.spInsertPerson
	@DepartmentId bigint = NULL,
	@Name nvarchar(200),
	@Ext nvarchar(100) = NULL,
	@Contact nvarchar(100) = NULL,
	@IsActive bit = 1
AS
	Insert Into Person (DepartmentId, Name, Ext, Contact, IsActive)
		VALUES (@DepartmentId, @Name, @Ext, @Contact, @IsActive)

	SELECT SCOPE_IDENTITY()
GO


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
						PONumber, InvoiceNumber, Description, TagNo, CurrentTransType)
					VALUES (@ItemId, @VendorId, @PurchaseDate, @StartDate, @EndDate,
							@PONumber, @InvoiceNumber, @Description, @TagNo, @TransTypeId)
	SET @PurchaseId = SCOPE_IDENTITY()

	INSERT INTO		Movement (TransTypeId, PurchaseId, MovDate, IsActive)
					VALUES (@TransTypeId, @PurchaseId, @PurchaseDate, 0)

	COMMIT

					
GO

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


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spMovementLedger' 
)
   DROP PROCEDURE dbo.spMovementLedger
GO

CREATE PROCEDURE dbo.spMovementLedger
	@TransTypeId bigint = NULL,
	@PersonId bigint = NULL,
	@LocationId bigint = NULL,
	@DepartmentId bigint = NULL,
	@PurchaseId bigint = NULL,
	@ItemId bigint = NULL,
	@StartDate date = NULL,
	@EndDate date = NULL
AS
	select  M.MovementId, M.MovDate, M.TransTypeId, T.TransTypeName,
		P.TagNo, I.ItemName,
		CASE WHEN PE.Name IS NULL THEN '' ELSE PE.Name END AS [Name],  
		CASE WHEN D.DepartmentName IS NULL THEN '' ELSE D.DepartmentName END AS DepartmentName, 
		CASE WHEN L.LocationName IS NULL THEN '' ELSE L.LocationName END AS LocationName
	from Movement M 
		Left Join Person PE ON PE.PersonId = M.PersonId
		Left Join Location L ON L.LocationId = M.LocationId
		Inner Join Purchase P ON P.PurchaseId = M.PurchaseId
		Inner Join Item I ON I.ItemId = P.ItemId
		Left Join Department D ON PE.DepartmentId = D.DepartmentId
		Inner Join TransType T ON T.TransTypeId = M.TransTypeId			
	WHERE 1 = 1
		AND (@TransTypeId IS NULL OR M.TransTypeId = @TransTypeId)
		AND (@PersonId IS NULL OR M.PersonId = @PersonId)
		AND (@LocationId IS NULL OR M.LocationId = @LocationId)
		AND (@PurchaseId IS NULL OR M.PurchaseId = @PurchaseId)
		AND (@ItemId IS NULL OR I.ItemId = @ItemId)
		AND (@DepartmentId IS NULL OR D.DepartmentId = @DepartmentId)
		AND (@StartDate IS NULL OR MovDate >= @StartDate)
		AND (@EndDate IS NULL OR MovDate <= @EndDate)
	ORDER BY m.MovDate 

GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchDepartment' 
)
   DROP PROCEDURE dbo.spSearchDepartment
GO

CREATE PROCEDURE dbo.spSearchDepartment
	@DepartmentId bigint = NULL,
	@DepartmentName nvarchar(200) = NULL
AS
	SELECT * FROM Department 
	WHERE (@DepartmentId IS NULL OR DepartmentId = @DepartmentId)
	AND (@DepartmentName IS NULL OR DepartmentName LIKE '%'+@DepartmentName+'%')

GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchItem' 
)
   DROP PROCEDURE dbo.spSearchItem
GO

CREATE PROCEDURE dbo.spSearchItem
	@ItemId bigint = NULL,
	@ItemName nvarchar(200) = NULL,
	@ItemDescription nvarchar(1000) = NULL
AS
	SELECT * FROM Item
	WHERE (@ItemId IS NULL OR ItemId = @ItemId)
	AND (@ItemName IS NULL OR ItemName LIKE '%'+@ItemName+'%')
	AND (@ItemDescription IS NULL OR Description LIKE '%'+@ItemDescription+'%')

GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchLocation' 
)
   DROP PROCEDURE dbo.spSearchLocation
GO

CREATE PROCEDURE dbo.spSearchLocation
	@LocationId bigint  = NULL, 
	@LocationName nvarchar(200) = NULL
AS
	SELECT	* 
	FROM	Location
	WHERE (@LocationId IS NULL OR LocationId = @LocationId) 
	AND (@LocationName IS NULL OR LocationName = @LocationName)
GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchMovement' 
)
   DROP PROCEDURE dbo.spSearchMovement
GO

CREATE PROCEDURE dbo.spSearchMovement
	@MovementId bigint = NULL,
	@TransTypeId bigint = NULL,
	@PersonId bigint = NULL,
	@LocationId bigint = NULL,
	@PurchaseId bigint = NULL,
	@StartDate date = NULL,
	@EndDate date = NULL,
	@IsActive bit = NULL,
	@ParentMovement bigint = NULL
AS
	;with cteItems(PurchaseId, ItemName) 
	AS (
		SElECT P.PurchaseId, I.ItemName + '(' + P.TagNo + ')' AS ItemName
		FROM Item I Inner Join Purchase P ON I.ItemId = P.ItemId
	)
	SELECT	M.*, I.ItemName, L.LocationName, P.Name
	FROM Movement M  Left Join cteItems I ON M.PurchaseId = I.PurchaseId
		LEFT JOIN Location L ON L.LocationId = M.LocationId
		Left Join Person P ON P.PersonId = M.PersonId		
	WHERE (@MovementId IS NULL OR MovementId = @MovementId)
		AND (@TransTypeId IS NULL OR TransTypeId = @TransTypeId)
		AND (@PersonId IS NULL OR M.PersonId = @PersonId)
		AND (@LocationId IS NULL OR M.LocationId = @LocationId)
		AND (@PurchaseId IS NULL OR M.PurchaseId = @PurchaseId)
		AND (@StartDate IS NULL OR MovDate >= @StartDate)
		AND (@EndDate IS NULL OR MovDate <= @EndDate)
		AND (@IsActive IS NULL OR M.IsActive = @IsActive)
		AND (@ParentMovement IS NULL OR ParentMovement = @ParentMovement)
	ORDER BY m.MovDate 

GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spSearchPerson' 
)
   DROP PROCEDURE dbo.spSearchPerson
GO

CREATE PROCEDURE dbo.spSearchPerson
	@PersonId bigint = NULL,
	@DepartmentId bigint = NULL,
	@Name nvarchar(200) = NULL,
	@Ext nvarchar(100) = NULL,
	@Contact nvarchar(100) = NULL,
	@IsActive bit = NULL
AS
	SELECT	P.*, D.DepartmentName
	FROM	Person P Left JOIN Department D ON P.DepartmentId = D.DepartmentId
	WHERE	(@PersonId IS NULL OR PersonId=@PersonId)
		AND	(@DepartmentId IS NULL OR P.DepartmentId = @DepartmentId)
		AND (@Name IS NULL OR Name LIKE '%'+@Name+'%')
		AND (@Ext IS NULL OR Ext LIKE '%'+@Ext+'%')
		AND (@Contact IS NULL OR Contact LIKE '%'+@Contact+'%')
		AND (@IsActive IS NULL OR IsActive = @IsActive)
GO


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


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateDepartment' 
)
   DROP PROCEDURE dbo.spUpdateDepartment
GO

CREATE PROCEDURE dbo.spUpdateDepartment
	@DepartmentId bigint,
	@DepartmentName nvarchar(200)
AS
	UPDATE Department SET DepartmentName = @DepartmentName 
	WHERE	DepartmentId = @DepartmentId
GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateItem' 
)
   DROP PROCEDURE dbo.spUpdateItem
GO

CREATE PROCEDURE dbo.spUpdateItem
	@ItemId bigint,
	@ItemName nvarchar(200),
	@ItemDescription nvarchar(1000) = NULL
AS
	UPDATE Item 
		SET ItemName = @ItemName, Description = @ItemDescription
	WHERE ItemId = @ItemId

GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateLocation' 
)
   DROP PROCEDURE dbo.spUpdateLocation
GO

CREATE PROCEDURE dbo.spUpdateLocation
	@LocationId bigint, 
	@LocationName nvarchar(200)
AS
	UPDATE Location
	SET LocationName = @LocationName
	WHERE LocationId = @LocationId
GO

-- =============================================
-- Example to execute the stored procedure
-- =============================================
--EXECUTE dbo.spUpdateLocation 1, 2
--GO
-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdateMovement' 
)
   DROP PROCEDURE dbo.spUpdateMovement
GO

CREATE PROCEDURE dbo.spUpdateMovement
	@MovementId bigint,
	@TransTypeId bigint ,
	@PersonId bigint = NULL,
	@LocationId bigint = NULL,
	@PurchaseId bigint = NULL,
	@MovDate date ,
	@IsActive bit ,
	@ParentMovement bigint = NULL
AS
	UPDATE [dbo].[Movement]
	   SET [TransTypeId] = @TransTypeId
		  ,[PersonId] = @PersonId
		  ,[LocationId] = @LocationId
		  ,[PurchaseId] = @PurchaseId
		  ,[MovDate] = @MovDate
		  ,[IsActive] = @IsActive
		  ,[ParentMovement] = @ParentMovement
	 WHERE MovementId = @MovementId

GO

-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdatePerson' 
)
   DROP PROCEDURE dbo.spUpdatePerson
GO

CREATE PROCEDURE dbo.spUpdatePerson
	@PersonId bigint,
	@DepartmentId bigint = NULL,
	@Name nvarchar(200),
	@Ext nvarchar(100) = NULL,
	@Contact nvarchar(100) = NULL,
	@IsActive bit = 1
AS
	UPDATE	Person
		SET	Name = @Name,
			DepartmentId = @DepartmentId,
			Ext = @Ext,
			Contact = @Contact,
			IsActive = @IsActive
	WHERE	PersonId = @PersonId

GO


-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spUpdatePurchase' 
)
   DROP PROCEDURE dbo.spUpdatePurchase
GO

CREATE PROCEDURE dbo.spUpdatePurchase
	 @PurchaseId bigint,
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

	BEGIN TRAN

	UPDATE	Purchase
	SET		ItemId = @ItemId, 
			VendorId = @VendorId, 
			PurchaseDate = @PurchaseDate, 
			StartDate = @StartDate, 
			EndDate= @EndDate,
			PONumber = @PONumber, 
			InvoiceNumber = @InvoiceNumber, 
			Description = @Description, 
			TagNo = @TagNo
	WHERE	PurchaseId = @PurchaseId

	UPDATE	Movement
	SET		MovDate = @PurchaseDate
	WHERE	PurchaseId = @PurchaseId

	COMMIT
					
GO

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


