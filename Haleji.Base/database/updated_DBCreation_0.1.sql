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
