
CREATE DATABASE [Sweater];
GO

USE [Sweater];
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

-------------------------------------
--//////////////////////////////////
------------------------------------
-- Product

CREATE TABLE [SizeType]
(
     [SizeTypeID]	    INT IDENTITY(1, 1) NOT NULL, 
	 [IsAvailable]	    BIT NOT NULL DEFAULT(1), 
     [RussianSize]      NVARCHAR(10) NOT NULL, 
	 [OtherCountry]     NVARCHAR(10) NOT NULL, 
     [CountryCode]      NVARCHAR(10) NOT NULL, 
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
	 [CategoryTypeID]   INT NOT NULL DEFAULT(0),
	 [ClicksCount]      INT NOT NULL DEFAULT(0),
     [CategoryPhotoUrl] NVARCHAR(100) NOT NULL DEFAULT(''), 
     CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED([CategoryID] ASC)
);
GO

CREATE TABLE [Product]
(
     [ProductID]             INT IDENTITY(1, 1) NOT NULL, 
	 [ClicksCount]           INT NOT NULL DEFAULT(0),
     [BrandID]               INT NOT NULL, 
     [VendorCode]            NVARCHAR(30) NOT NULL, 
	 [IsAvailable]	         BIT NOT NULL DEFAULT(1), 
     [CategoryID]            INT NOT NULL, 
	 [ShopColorId]           INT NOT NULL, 
	 [ShopTypeId]            INT NOT NULL, 
	 [Color1Id]              INT NOT NULL DEFAULT(-1),  
	 [Color2Id]              INT NOT NULL DEFAULT(-1), 
	 [Color3Id]              INT NOT NULL DEFAULT(-1), 
	 [Color4Id]              INT NOT NULL DEFAULT(-1), 
	 [Color5Id]              INT NOT NULL DEFAULT(-1), 
	 [Color6Id]              INT NOT NULL DEFAULT(-1), 
	 [Color7Id]              INT NOT NULL DEFAULT(-1), 
	 [PrintTypeID]           INT NOT NULL DEFAULT(0), 
	 [ExtraPrintTypeID]      INT NOT NULL DEFAULT(0), 
     [Price]                 DECIMAL(9,2) NOT NULL, 
     [Description]           NVARCHAR(400) NOT NULL, 
     [Link]                  NVARCHAR(100) NOT NULL, 
     [MadeInCountryID]       INT NOT NULL, 
     [PreviewPhotoID]        INT NOT NULL, 
     [CreatedDate]	         DATETIME2 NOT NULL DEFAULT(GETDATE()), 
     [IsDeleted]             BIT NOT NULL DEFAULT(0), 
     CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED([ProductID] ASC)
);
GO

CREATE TABLE [ProductPhoto]
(
     [ProductPhotoID]  INT IDENTITY(1, 1) NOT NULL, 
     [ProductID]       INT NOT NULL, 
     [PhotoUrl]        NVARCHAR(100) NOT NULL, 
	 [CreatedDate]     DATETIME2 NOT NULL DEFAULT(GETDATE()), 
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

-------------------------------------
--//////////////////////////////////
------------------------------------
-- Color's Data

CREATE TABLE [ColorMatching]
(
	 [ColorMatchingID]       INT IDENTITY(1, 1) NOT NULL,
     [ColorID]               INT NOT NULL, 
	 [PersonalColorTypeID]   INT NOT NULL, 
	 [RedPink]               REAL NOT NULL, 
	 [OrangeYellow]          REAL NOT NULL, 
	 [Green]                 REAL NOT NULL, 
	 [Blue]                  REAL NOT NULL, 
	 [Purple]                REAL NOT NULL, 
	 [BrownBeige]            REAL NOT NULL, 
	 [GrayBlackWhite]        REAL NOT NULL, 
     [CreatedDate]           DATETIME2 NOT NULL DEFAULT(GETDATE()), 
     CONSTRAINT [PK_ColorMatching] PRIMARY KEY CLUSTERED([ColorMatchingID])
);
GO
CREATE UNIQUE INDEX ix_colorid_colorgroup
    ON [ColorMatching] (ColorId, [PersonalColorTypeID])
    WITH FILLFACTOR= 80;
GO