
CREATE DATABASE [Zebra];
GO

USE [Zebra];
GO

-------------------------------------
--//////////////////////////////////
------------------------------------
-- Countries and cities

CREATE TABLE [Country]
(
     [CountryID]   INT IDENTITY(1, 1) NOT NULL, 
     [FlagUrl]     NVARCHAR(100) NOT NULL DEFAULT(''), 
     [EnglishName] NVARCHAR(50) NOT NULL DEFAULT(''), 
     [RussianName] NVARCHAR(50) NOT NULL DEFAULT(''), 
     CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED([CountryID] ASC)
);
GO

CREATE TABLE [City]
(
     [CityID]      INT IDENTITY(1, 1) NOT NULL, 
     [CountryID]   INT NOT NULL, 
     [EnglishName] NVARCHAR(50) NOT NULL, 
     [RussianName] NVARCHAR(50) NOT NULL, 
     CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED([CityID] ASC)
);
GO

-------------------------------------
--//////////////////////////////////
------------------------------------
-- User Profile

CREATE TABLE [User]
(
     [UserID]           INT NOT NULL, 
     [FirstName]        NVARCHAR(50) NOT NULL, 
     [LastName]         NVARCHAR(50) NOT NULL, 
     [SexID]        INT NOT NULL DEFAULT(0), 
     [HumanColorID] INT NOT NULL DEFAULT(0), 
     [ShapeID]      INT NOT NULL DEFAULT(0), 
     [BirthDate]        DATETIME2 NOT NULL DEFAULT(GETDATE()), 
     [CityID]           INT NOT NULL DEFAULT(0)
	 CONSTRAINT [PK_User] PRIMARY KEY ([UserID] ASC)
);
GO

CREATE TABLE [UserPhoto]
(
     [UserPhotoID] INT IDENTITY(1, 1) NOT NULL, 
     [UserID]      INT NOT NULL, 
     [PhotoUrl]    NVARCHAR(100) NOT NULL, 
     CONSTRAINT [PK_UserPhoto] PRIMARY KEY CLUSTERED([UserPhotoID] ASC)
);
GO

CREATE TABLE [dbo].[SexTypeID]
(
     [SexTypeID]   INT NOT NULL, 
     [EnglishName] NVARCHAR(50) NOT NULL, 
     [RussianName] NVARCHAR(50) NOT NULL, 
     CONSTRAINT [PK_Social] PRIMARY KEY CLUSTERED([SexTypeID] ASC)
);
GO

CREATE TABLE [dbo].[ShapeType]
(
     [ShapeTypeID] INT NOT NULL, 
     [EnglishName] NVARCHAR(50) NOT NULL, 
     [RussianName] NVARCHAR(50) NOT NULL, 
     CONSTRAINT [PK_ShapeType] PRIMARY KEY CLUSTERED([ShapeTypeID] ASC)
);
GO

CREATE TABLE [dbo].[HumanColorType]
(
     [HumanColorTypeID] INT NOT NULL, 
     [Hex]				VARCHAR(6) NULL,
     [EnglishName]      NVARCHAR(50) NOT NULL, 
     [RussianName]      NVARCHAR(50) NOT NULL, 
     CONSTRAINT [PK_HumanColorType] PRIMARY KEY CLUSTERED([HumanColorTypeID] ASC)
);
GO

-------------------------------------
--//////////////////////////////////
------------------------------------
-- Product

CREATE TABLE [SizeType]
(
     [SizeTypeID]	    INT IDENTITY(1, 1) NOT NULL, 
	 [IsAvailable]	    BIT NOT NULL DEFAULT(1), 
     [Russian]          NVARCHAR(10) NOT NULL, 
	 [OtherCountrySize] NVARCHAR(10) NOT NULL, 
     [CountyType]       NVARCHAR(10) NOT NULL, 
     CONSTRAINT [PK_SizeType] PRIMARY KEY CLUSTERED([SizeTypeID] ASC)
);
GO

CREATE TABLE [Brand]
(
     [BrandID] INT IDENTITY(1, 1) NOT NULL, 
     [Name]    NVARCHAR(50) NOT NULL, 
     [Site]    NVARCHAR(100) NOT NULL DEFAULT(''), 
     [LogoUrl] NVARCHAR(100) NOT NULL DEFAULT(''), 
     CONSTRAINT [PK_Brand] PRIMARY KEY CLUSTERED([BrandID] ASC)
);
GO

CREATE TABLE [dbo].[Category]
(
     [CategoryID]       INT IDENTITY(1, 1) NOT NULL, 
     [CategoryPhotoUrl] NVARCHAR(100) NOT NULL DEFAULT(''), 
     [EnglishName]      NVARCHAR(50) NOT NULL DEFAULT(''), 
     [RussianName]      NVARCHAR(50) NOT NULL DEFAULT(''), 
     CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED([CategoryID] ASC)
);
GO

CREATE TABLE [dbo].[ColorType]
(
     [ColorTypeID] INT IDENTITY(1, 1) NOT NULL, 
	 [Hex] NVARCHAR(6) NOT NULL DEFAULT(''),
     [EnglishName] NVARCHAR(50) NOT NULL DEFAULT(''), 
     [RussianName] NVARCHAR(50) NOT NULL DEFAULT(''), 
     CONSTRAINT [PK_ColorType] PRIMARY KEY CLUSTERED([ColorTypeID] ASC)
);
GO

CREATE TABLE [dbo].[PrintType]
(
     [PrintTypeID] INT IDENTITY(1, 1) NOT NULL, 
     [EnglishName] NVARCHAR(50) NOT NULL DEFAULT(''), 
     [RussianName] NVARCHAR(50) NOT NULL DEFAULT(''), 
     CONSTRAINT [PK_PrintType] PRIMARY KEY CLUSTERED([PrintTypeID] ASC)
);
GO

CREATE TABLE [dbo].[StyleType]
(
     [StyleTypeID] INT IDENTITY(1, 1) NOT NULL, 
     [EnglishName] NVARCHAR(50) NOT NULL DEFAULT(''), 
     [RussianName] NVARCHAR(50) NOT NULL DEFAULT(''), 
     CONSTRAINT [PK_StyleType] PRIMARY KEY CLUSTERED([StyleTypeID] ASC)
);
GO

CREATE TABLE [Product]
(
     [ProductID]       INT IDENTITY(1, 1) NOT NULL, 
     [BrandID]         INT NOT NULL, 
     [VendorCode]      NVARCHAR(30) NOT NULL, 
	 [IsAvailable]	   BIT NOT NULL DEFAULT(1), 
     [CategoryID]      INT NOT NULL, 
     [StyleTypeID]     INT NOT NULL, 
	 [PrintTypeID]     INT NOT NULL, 
     [Price]           DECIMAL(6,2) NOT NULL, 
     [Description]     NVARCHAR(400) NOT NULL, 
     [Link]            NVARCHAR(100) NOT NULL, 
     [MadeInCountryID] INT NOT NULL, 
     [PhotoPreviewUrl] NVARCHAR(100) NOT NULL, 
     [CreatedDate]     DATETIME2 NOT NULL DEFAULT(GETDATE()), 
     [IsDeleted]       BIT NOT NULL DEFAULT(0), 
     CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED([ProductID] ASC)
);
GO

CREATE TABLE [ProductPhoto]
(
     [ProductPhotoID] INT IDENTITY(1, 1) NOT NULL, 
     [ProductID]      INT NOT NULL, 
     [PhotoUrl]       NVARCHAR(100) NOT NULL, 
     CONSTRAINT [PK_ProductPhoto] PRIMARY KEY CLUSTERED([ProductPhotoID] ASC)
);
GO

CREATE TABLE [ProductSizeType]
(
     [ProductID]     INT NOT NULL, 
     [SizeTypeID]    INT NOT NULL, 
	 [IsAvailable]   BIT NOT NULL DEFAULT(1), 
     [UpdatedDate]   DATETIME2 NOT NULL DEFAULT(GETDATE()), 
     CONSTRAINT [PK_ProductSizeType] PRIMARY KEY CLUSTERED([ProductID], [SizeTypeID])
);
GO

CREATE TABLE [ProductColorType]
(
     [ProductID]     INT NOT NULL, 
     [ColorTypeID]   INT NOT NULL, 
     [UpdatedDate]   DATETIME2 NOT NULL DEFAULT(GETDATE()), 
     CONSTRAINT [PK_ProductColorType] PRIMARY KEY CLUSTERED([ProductID], [ColorTypeID])
);
GO