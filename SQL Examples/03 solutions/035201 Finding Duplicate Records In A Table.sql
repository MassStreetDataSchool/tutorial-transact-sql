USE demo

--Create our product table
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimProducts]') AND type in (N'U'))
ALTER TABLE [dbo].[DimProducts] DROP CONSTRAINT IF EXISTS [FK_Products_Products]
GO

/****** Object:  Table [dbo].[DimProducts]    Script Date: 10/14/2017 5:05:59 PM ******/
DROP TABLE IF EXISTS [dbo].[DimProducts]
GO

/****** Object:  Table [dbo].[DimProducts]    Script Date: 10/14/2017 5:05:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimProducts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DimProducts](
[ProductID] [bigint] IDENTITY(1,1) NOT NULL,
[ProductName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Products_Products]') AND parent_object_id = OBJECT_ID(N'[dbo].[DimProducts]'))
ALTER TABLE [dbo].[DimProducts]  WITH CHECK ADD  CONSTRAINT [FK_Products_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[DimProducts] ([ProductID])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Products_Products]') AND parent_object_id = OBJECT_ID(N'[dbo].[DimProducts]'))
ALTER TABLE [dbo].[DimProducts] CHECK CONSTRAINT [FK_Products_Products]
GO


--Create our product sales table
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FactProductSales]') AND type in (N'U'))
ALTER TABLE [dbo].[FactProductSales] DROP CONSTRAINT IF EXISTS [FK_ProductSales_Products]
GO

/****** Object:  Table [dbo].[FactProductSales]    Script Date: 10/14/2017 5:20:15 PM ******/
DROP TABLE IF EXISTS [dbo].[FactProductSales]
GO

/****** Object:  Table [dbo].[FactProductSales]    Script Date: 10/14/2017 5:20:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FactProductSales]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FactProductSales](
[InvoiceID] [bigint] IDENTITY(1,1) NOT NULL,
[ProductID] [bigint] NOT NULL,
[Price] [money] NOT NULL,
[ItemCount] [int] NOT NULL,
[InvoiceTotal]  AS ([Price]*[ItemCount]),
 CONSTRAINT [PK_ProductSales] PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductSales_Products]') AND parent_object_id = OBJECT_ID(N'[dbo].[FactProductSales]'))
ALTER TABLE [dbo].[FactProductSales]  WITH CHECK ADD  CONSTRAINT [FK_ProductSales_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[DimProducts] ([ProductID])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductSales_Products]') AND parent_object_id = OBJECT_ID(N'[dbo].[FactProductSales]'))
ALTER TABLE [dbo].[FactProductSales] CHECK CONSTRAINT [FK_ProductSales_Products]
GO