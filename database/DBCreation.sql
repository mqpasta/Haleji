USE [master]
GO
/****** Object:  Database [Haleji_Test]    Script Date: 8/25/2021 9:07:46 AM ******/
CREATE DATABASE [Haleji_Test]
 CONTAINMENT = NONE
GO
ALTER DATABASE [Haleji_Test] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Haleji_Test].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Haleji_Test] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Haleji_Test] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Haleji_Test] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Haleji_Test] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Haleji_Test] SET ARITHABORT OFF 
GO
ALTER DATABASE [Haleji_Test] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Haleji_Test] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Haleji_Test] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Haleji_Test] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Haleji_Test] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Haleji_Test] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Haleji_Test] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Haleji_Test] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Haleji_Test] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Haleji_Test] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Haleji_Test] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Haleji_Test] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Haleji_Test] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Haleji_Test] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Haleji_Test] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Haleji_Test] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Haleji_Test] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Haleji_Test] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Haleji_Test] SET  MULTI_USER 
GO
ALTER DATABASE [Haleji_Test] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Haleji_Test] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Haleji_Test] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Haleji_Test] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Haleji_Test] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Haleji_Test] SET QUERY_STORE = OFF
GO
USE [Haleji_Test]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 8/25/2021 9:07:46 AM ******/
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
/****** Object:  Table [dbo].[Item]    Script Date: 8/25/2021 9:07:46 AM ******/
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
/****** Object:  Table [dbo].[Location]    Script Date: 8/25/2021 9:07:46 AM ******/
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
/****** Object:  Table [dbo].[Movement]    Script Date: 8/25/2021 9:07:46 AM ******/
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
/****** Object:  Table [dbo].[Person]    Script Date: 8/25/2021 9:07:46 AM ******/
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
/****** Object:  Table [dbo].[Purchase]    Script Date: 8/25/2021 9:07:46 AM ******/
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
 CONSTRAINT [PK_Purchase] PRIMARY KEY CLUSTERED 
(
	[PurchaseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockStatus]    Script Date: 8/25/2021 9:07:46 AM ******/
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
/****** Object:  Table [dbo].[TransType]    Script Date: 8/25/2021 9:07:46 AM ******/
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
/****** Object:  Table [dbo].[Vendor]    Script Date: 8/25/2021 9:07:46 AM ******/
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
USE [master]
GO
ALTER DATABASE [Haleji_Test] SET  READ_WRITE 
GO
