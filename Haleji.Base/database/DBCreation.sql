USE [master]
GO
/****** Object:  Database [Haleji]    Script Date: 19/09/2021 4:35:43 pm ******/
CREATE DATABASE [Haleji]
 CONTAINMENT = NONE
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Haleji] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Haleji].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Haleji] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Haleji] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Haleji] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Haleji] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Haleji] SET ARITHABORT OFF 
GO
ALTER DATABASE [Haleji] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Haleji] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Haleji] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Haleji] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Haleji] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Haleji] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Haleji] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Haleji] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Haleji] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Haleji] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Haleji] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Haleji] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Haleji] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Haleji] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Haleji] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Haleji] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Haleji] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Haleji] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Haleji] SET  MULTI_USER 
GO
ALTER DATABASE [Haleji] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Haleji] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Haleji] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Haleji] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Haleji] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Haleji] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Haleji] SET QUERY_STORE = OFF
GO
USE [Haleji]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentId] [bigint] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Item]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item](
	[ItemId] [bigint] IDENTITY(1,1) NOT NULL,
	[ItemName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [Unique_Item] UNIQUE NONCLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Location]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[LocationId] [bigint] IDENTITY(1,1) NOT NULL,
	[LocationName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [Unique_Location] UNIQUE NONCLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movement]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movement](
	[MovementId] [bigint] IDENTITY(1,1) NOT NULL,
	[TransTypeId] [bigint] NOT NULL,
	[PersonId] [bigint] NULL,
	[LocationId] [bigint] NULL,
	[PurchaseId] [bigint] NULL,
	[MovDate] [date] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ParentMovement] [bigint] NULL,
 CONSTRAINT [PK_Movement] PRIMARY KEY CLUSTERED 
(
	[MovementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[PersonId] [bigint] IDENTITY(1,1) NOT NULL,
	[DepartmentId] [bigint] NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Ext] [nvarchar](50) NULL,
	[Contact] [nvarchar](50) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Purchase]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Purchase](
	[PurchaseId] [bigint] IDENTITY(1,1) NOT NULL,
	[ItemId] [bigint] NOT NULL,
	[VendorId] [bigint] NOT NULL,
	[PurchaseDate] [date] NOT NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[PONumber] [nvarchar](50) NULL,
	[InvoiceNumber] [nvarchar](50) NULL,
	[Description] [nvarchar](500) NULL,
	[TagNo] [nvarchar](50) NOT NULL,
	[CurrentTransType] [bigint] NOT NULL,
 CONSTRAINT [PK_Purchase] PRIMARY KEY CLUSTERED 
(
	[PurchaseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[PurchaseDetails]    Script Date: 9/25/2021 11:47:50 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PurchaseDetails](
	[PurchaseDetailsId] [bigint] IDENTITY(1,1) NOT NULL,
	[PurchaseId] [bigint] NOT NULL,
	[ItemDetailsId] [bigint] NOT NULL,
	[Description] [nvarchar](100) NULL,
 CONSTRAINT [PK_PurchaseDetails] PRIMARY KEY CLUSTERED 
(
	[PurchaseDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PurchaseDetails]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseDetails_ItemDetails] FOREIGN KEY([ItemDetailsId])
REFERENCES [dbo].[ItemDetails] ([ItemDetailsId])
GO

ALTER TABLE [dbo].[PurchaseDetails] CHECK CONSTRAINT [FK_PurchaseDetails_ItemDetails]
GO

ALTER TABLE [dbo].[PurchaseDetails]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseDetails_Purchase] FOREIGN KEY([PurchaseId])
REFERENCES [dbo].[Purchase] ([PurchaseId])
GO

ALTER TABLE [dbo].[PurchaseDetails] CHECK CONSTRAINT [FK_PurchaseDetails_Purchase]
GO

/****** Object:  Table [dbo].[ItemDetails]    Script Date: 9/25/2021 11:49:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ItemDetails](
	[ItemDetailsId] [bigint] IDENTITY(1,1) NOT NULL,
	[ItemId] [bigint] NOT NULL,
	[Specifications] [nvarchar](500) NULL,
 CONSTRAINT [PK_ItemDetails] PRIMARY KEY CLUSTERED 
(
	[ItemDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ItemDetails]  WITH CHECK ADD  CONSTRAINT [FK_ItemDetails_Item] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Item] ([ItemId])
GO

ALTER TABLE [dbo].[ItemDetails] CHECK CONSTRAINT [FK_ItemDetails_Item]
GO


/****** Object:  Table [dbo].[StockStatus]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockStatus](
	[ItemId] [bigint] NOT NULL,
	[TransTypeId] [bigint] NOT NULL,
	[Count] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransType]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransType](
	[TransTypeId] [bigint] NOT NULL,
	[TransTypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TransType] PRIMARY KEY CLUSTERED 
(
	[TransTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vendor]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendor](
	[VendorId] [bigint] IDENTITY(1,1) NOT NULL,
	[VendorName] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](250) NULL,
	[ContactPerson] [nvarchar](100) NULL,
	[Contact] [nvarchar](50) NULL,
	[Note] [nvarchar](max) NULL,
 CONSTRAINT [PK_Vendor] PRIMARY KEY CLUSTERED 
(
	[VendorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [Unique_Vendor] UNIQUE NONCLUSTERED 
(
	[VendorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Movement] ADD  CONSTRAINT [DF_Movement_MovDate]  DEFAULT (getdate()) FOR [MovDate]
GO
ALTER TABLE [dbo].[Movement] ADD  CONSTRAINT [DF_Movement_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Purchase] ADD  CONSTRAINT [DF_Purchase_PurchaseDate]  DEFAULT (getdate()) FOR [PurchaseDate]
GO
ALTER TABLE [dbo].[StockStatus] ADD  CONSTRAINT [DF_StockStatus_Count]  DEFAULT ((0)) FOR [Count]
GO
ALTER TABLE [dbo].[Movement]  WITH CHECK ADD  CONSTRAINT [FK_Movement_Location] FOREIGN KEY([LocationId])
REFERENCES [dbo].[Location] ([LocationId])
GO
ALTER TABLE [dbo].[Movement] CHECK CONSTRAINT [FK_Movement_Location]
GO
ALTER TABLE [dbo].[Movement]  WITH CHECK ADD  CONSTRAINT [FK_Movement_Movement] FOREIGN KEY([ParentMovement])
REFERENCES [dbo].[Movement] ([MovementId])
GO
ALTER TABLE [dbo].[Movement] CHECK CONSTRAINT [FK_Movement_Movement]
GO
ALTER TABLE [dbo].[Movement]  WITH CHECK ADD  CONSTRAINT [FK_Movement_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([PersonId])
GO
ALTER TABLE [dbo].[Movement] CHECK CONSTRAINT [FK_Movement_Person]
GO
ALTER TABLE [dbo].[Movement]  WITH CHECK ADD  CONSTRAINT [FK_Movement_Purchase] FOREIGN KEY([PurchaseId])
REFERENCES [dbo].[Purchase] ([PurchaseId])
GO
ALTER TABLE [dbo].[Movement] CHECK CONSTRAINT [FK_Movement_Purchase]
GO
ALTER TABLE [dbo].[Movement]  WITH CHECK ADD  CONSTRAINT [FK_Movement_TransType] FOREIGN KEY([TransTypeId])
REFERENCES [dbo].[TransType] ([TransTypeId])
GO
ALTER TABLE [dbo].[Movement] CHECK CONSTRAINT [FK_Movement_TransType]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_Department] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Department] ([DepartmentId])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Department]
GO
ALTER TABLE [dbo].[Purchase]  WITH CHECK ADD  CONSTRAINT [FK_Purchase_Item] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Item] ([ItemId])
GO
ALTER TABLE [dbo].[Purchase] CHECK CONSTRAINT [FK_Purchase_Item]
GO
ALTER TABLE [dbo].[Purchase]  WITH CHECK ADD  CONSTRAINT [FK_Purchase_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([VendorId])
GO
ALTER TABLE [dbo].[Purchase] CHECK CONSTRAINT [FK_Purchase_Vendor]
GO
ALTER TABLE [dbo].[StockStatus]  WITH CHECK ADD  CONSTRAINT [FK_StockStatus_Item] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Item] ([ItemId])
GO
ALTER TABLE [dbo].[StockStatus] CHECK CONSTRAINT [FK_StockStatus_Item]
GO
ALTER TABLE [dbo].[StockStatus]  WITH CHECK ADD  CONSTRAINT [FK_StockStatus_TransType] FOREIGN KEY([TransTypeId])
REFERENCES [dbo].[TransType] ([TransTypeId])
GO
ALTER TABLE [dbo].[StockStatus] CHECK CONSTRAINT [FK_StockStatus_TransType]
GO
/****** Object:  StoredProcedure [dbo].[spDeleteDepartment]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spDeleteDepartment]
	@DepartmentId bigint
AS
	DELETE FROM Department 
	WHERE	DepartmentId = @DepartmentId
GO
/****** Object:  StoredProcedure [dbo].[spDeleteItem]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spDeleteItem]
	@ItemId bigint
AS
	DELETE FROM Item WHERE ItemId = @ItemId

GO
/****** Object:  StoredProcedure [dbo].[spDeleteLocation]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spDeleteLocation]
	@LocationId bigint
AS
	DELETE FROM Location WHERE LocationId = @LocationId
GO
/****** Object:  StoredProcedure [dbo].[spDeleteMovement]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spDeleteMovement]
	@MovementId bigint
AS
	DELETE FROM Movement
	 WHERE MovementId = @MovementId

GO
/****** Object:  StoredProcedure [dbo].[spDeletePerson]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spDeletePerson]
	@PersonId bigint
AS
	DELETE FROM Person WHERE PersonId = @PersonId
GO
/****** Object:  StoredProcedure [dbo].[spDeletePurchase]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spDeletePurchase]
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
/****** Object:  StoredProcedure [dbo].[spDeleteVendor]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spDeleteVendor]
	@VendorId bigint = NULL
AS
	DELETE FROM Vendor WHERE VendorId = @VendorId
GO
/****** Object:  StoredProcedure [dbo].[spEditPerson]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spEditPerson]
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
/****** Object:  StoredProcedure [dbo].[spGetAllDepartment]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetAllDepartment]
AS
	SELECT * FROM Department 
GO
/****** Object:  StoredProcedure [dbo].[spGetAllItem]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetAllItem]
AS
	SELECT * FROM Item

GO
/****** Object:  StoredProcedure [dbo].[spGetAllLocation]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetAllLocation]
AS
	SELECT * FROM Location
GO
/****** Object:  StoredProcedure [dbo].[spGetAllPerson]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetAllPerson]
AS
	SELECT P.* , D.DepartmentName
	FROM Person P LEFT JOIN Department D ON P.DepartmentId = D.DepartmentId
GO
/****** Object:  StoredProcedure [dbo].[spGetAllPurchase]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetAllPurchase]
AS
	SELECT	P.*, I.ItemName, V.VendorName
	FROM	Purchase P Inner Join Item I ON P.ItemId = I.ItemId
			Inner Join Vendor V ON P.VendorId = V.VendorId
GO
/****** Object:  StoredProcedure [dbo].[spGetAllVendor]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetAllVendor]
AS
	SELECT	* 
	FROM	Vendor

GO
/****** Object:  StoredProcedure [dbo].[spGetStockSummary]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetStockSummary]
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
/****** Object:  StoredProcedure [dbo].[spInsertDepartment]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spInsertDepartment]
	@DepartmentName nvarchar(200)
AS
	Insert Into Department (DepartmentName) VALUES(@DepartmentName)
	SELECT SCOPE_IDENTITY()
GO
/****** Object:  StoredProcedure [dbo].[spInsertItem]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spInsertItem]
	@ItemName nvarchar(200),
	@ItemDescription nvarchar(1000) = NULL
AS
	INSERT INTO Item (ItemName, Description)
		VALUES (@ItemName, @ItemDescription)

	SELECT SCOPE_IDENTITY()
GO
/****** Object:  StoredProcedure [dbo].[spInsertLocation]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spInsertLocation]
	@LocationName nvarchar(200)
AS
	INSERT INTO Location (LocationName) VALUES(@LocationName)
	SELECT SCOPE_IDENTITY()
GO
/****** Object:  StoredProcedure [dbo].[spInsertMovement]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spInsertMovement]
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
/****** Object:  StoredProcedure [dbo].[spInsertPerson]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spInsertPerson]
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
/****** Object:  StoredProcedure [dbo].[spInsertPurchase]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spInsertPurchase]
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
					VALUES (@TransTypeId, @PurchaseId, @PurchaseDate, 1)

	COMMIT

					
GO
/****** Object:  StoredProcedure [dbo].[spInsertVendor]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spInsertVendor]
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
/****** Object:  StoredProcedure [dbo].[spMovementLedger]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spMovementLedger]
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
/****** Object:  StoredProcedure [dbo].[spSearchDepartment]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spSearchDepartment]
	@DepartmentId bigint = NULL,
	@DepartmentName nvarchar(200) = NULL
AS
	SELECT * FROM Department 
	WHERE (@DepartmentId IS NULL OR DepartmentId = @DepartmentId)
	AND (@DepartmentName IS NULL OR DepartmentName LIKE '%'+@DepartmentName+'%')

GO
/****** Object:  StoredProcedure [dbo].[spSearchItem]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spSearchItem]
	@ItemId bigint = NULL,
	@ItemName nvarchar(200) = NULL,
	@ItemDescription nvarchar(1000) = NULL
AS
	SELECT * FROM Item
	WHERE (@ItemId IS NULL OR ItemId = @ItemId)
	AND (@ItemName IS NULL OR ItemName LIKE '%'+@ItemName+'%')
	AND (@ItemDescription IS NULL OR Description LIKE '%'+@ItemDescription+'%')

GO
/****** Object:  StoredProcedure [dbo].[spSearchLocation]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spSearchLocation]
	@LocationId bigint  = NULL, 
	@LocationName nvarchar(200) = NULL
AS
	SELECT	* 
	FROM	Location
	WHERE (@LocationId IS NULL OR LocationId = @LocationId) 
	AND (@LocationName IS NULL OR LocationName = @LocationName)
GO
/****** Object:  StoredProcedure [dbo].[spSearchMovement]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spSearchMovement]
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
/****** Object:  StoredProcedure [dbo].[spSearchPerson]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spSearchPerson]
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
/****** Object:  StoredProcedure [dbo].[spSearchPurchase]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spSearchPurchase]
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
/****** Object:  StoredProcedure [dbo].[spSearchVendor]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spSearchVendor]
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
/****** Object:  StoredProcedure [dbo].[spUpdateDepartment]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spUpdateDepartment]
	@DepartmentId bigint,
	@DepartmentName nvarchar(200)
AS
	UPDATE Department SET DepartmentName = @DepartmentName 
	WHERE	DepartmentId = @DepartmentId
GO
/****** Object:  StoredProcedure [dbo].[spUpdateItem]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spUpdateItem]
	@ItemId bigint,
	@ItemName nvarchar(200),
	@ItemDescription nvarchar(1000) = NULL
AS
	UPDATE Item 
		SET ItemName = @ItemName, Description = @ItemDescription
	WHERE ItemId = @ItemId

GO
/****** Object:  StoredProcedure [dbo].[spUpdateLocation]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spUpdateLocation]
	@LocationId bigint, 
	@LocationName nvarchar(200)
AS
	UPDATE Location
	SET LocationName = @LocationName
	WHERE LocationId = @LocationId
GO
/****** Object:  StoredProcedure [dbo].[spUpdateMovement]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spUpdateMovement]
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
/****** Object:  StoredProcedure [dbo].[spUpdatePerson]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spUpdatePerson]
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
/****** Object:  StoredProcedure [dbo].[spUpdatePurchase]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spUpdatePurchase]
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
			TagNo = @TagNo,
			CurrentTransType = @TransTypeId
	WHERE	PurchaseId = @PurchaseId

	UPDATE	Movement
	SET		MovDate = @PurchaseDate
	WHERE	PurchaseId = @PurchaseId

	COMMIT
					
GO
/****** Object:  StoredProcedure [dbo].[spUpdateVendor]    Script Date: 19/09/2021 4:35:43 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spUpdateVendor]
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
USE [master]
GO
ALTER DATABASE [Haleji] SET  READ_WRITE 
GO
