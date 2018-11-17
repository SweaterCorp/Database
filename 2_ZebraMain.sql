
CREATE DATABASE [Zebra];
GO

USE [Zebra];
GO

-- Countries and cities

CREATE TABLE [Country]
(
     [CountryId]   INT IDENTITY(1, 1) NOT NULL, 
     [FlagUrl]     NVARCHAR(100) NOT NULL DEFAULT(''), 
     [EnglishName] NVARCHAR(100) NOT NULL DEFAULT(''), 
     [RussianName] NVARCHAR(100) NOT NULL DEFAULT(''), 
     CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED([CountryId] ASC)
);
GO

CREATE TABLE [City]
(
     [CityId]      INT IDENTITY(1, 1) NOT NULL, 
     [CountryId]   INT NOT NULL, 
     [EnglishName] NVARCHAR(100) NOT NULL, 
     [RussianName] NVARCHAR(100) NOT NULL, 
     CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED([CityId] ASC)
);
GO

-------------------------------------
--//////////////////////////////////
------------------------------------
-- User Profile

CREATE TABLE [User]
(
     [UserId]           INT NOT NULL, 
     [FirstName]        NVARCHAR(50) NOT NULL, 
     [LastName]         NVARCHAR(50) NOT NULL, 
     [SexId]        INT NOT NULL DEFAULT(0), 
     [HumanColorId] INT NOT NULL DEFAULT(0), 
     [ShapeId]      INT NOT NULL DEFAULT(0), 
     [BirthDate]        DATETIME2 NOT NULL DEFAULT(GETDATE()), 
     [CityID]           INT NOT NULL DEFAULT(0)
	 CONSTRAINT [PK_User] PRIMARY KEY ([UserId] ASC)
);
GO

CREATE TABLE [UserPhoto]
(
     [UserPhotoId] INT IDENTITY(1, 1) NOT NULL, 
     [UserId]      INT NOT NULL, 
     [PhotoUrl]    NVARCHAR(100) NOT NULL, 
     CONSTRAINT [PK_UserPhoto] PRIMARY KEY CLUSTERED([UserPhotoId] ASC)
);
GO

CREATE TABLE [dbo].[SexTypeId]
(
     [SexTypeId]   INT NOT NULL, 
     [EnglishName] NVARCHAR(100) NOT NULL, 
     [RussianName] NVARCHAR(100) NOT NULL, 
     CONSTRAINT [PK_Social] PRIMARY KEY CLUSTERED([SexTypeId] ASC)
);
GO

CREATE TABLE [dbo].[ShapeType]
(
     [ShapeTypeId] INT NOT NULL, 
     [EnglishName] NVARCHAR(100) NOT NULL, 
     [RussianName] NVARCHAR(100) NOT NULL, 
     CONSTRAINT [PK_ShapeType] PRIMARY KEY CLUSTERED([ShapeTypeId] ASC)
);
GO

CREATE TABLE [dbo].[HumanColorType]
(
     [HumanColorTypeId] INT NOT NULL, 
     [Hex]				VARCHAR(6) NULL,
     [EnglishName]      NVARCHAR(100) NOT NULL, 
     [RussianName]      NVARCHAR(100) NOT NULL, 
     CONSTRAINT [PK_HumanColorType] PRIMARY KEY CLUSTERED([HumanColorTypeId] ASC)
);
GO

-------------------------------------
--//////////////////////////////////
------------------------------------
-- Product

CREATE TABLE [SizeType]
(
     [SizeTypeId]  INT IDENTITY(1, 1) NOT NULL, 
     [Russian] NVARCHAR(10) NOT NULL, 
	 [International] NVARCHAR(10) NOT NULL, 
     [Europa]  NVARCHAR(10) NOT NULL, 
     [China]   NVARCHAR(10) NOT NULL, 
     [USA]     NVARCHAR(10) NOT NULL, 
     CONSTRAINT [PK_SizeType] PRIMARY KEY CLUSTERED([SizeTypeId] ASC)
);
GO

CREATE TABLE [Brand]
(
     [BrandId] INT IDENTITY(1, 1) NOT NULL, 
     [Name]    NVARCHAR(50) NOT NULL, 
     [Site]    NVARCHAR(100) NOT NULL, 
     [LogoUrl] NVARCHAR(100) NOT NULL, 
     CONSTRAINT [PK_Brand] PRIMARY KEY CLUSTERED([BrandId] ASC)
);
GO

CREATE TABLE [dbo].[Category]
(
     [CategoryId]       INT IDENTITY(1, 1) NOT NULL, 
     [CategoryPhotoUrl] NVARCHAR(100) NOT NULL, 
     [EnglishName]      NVARCHAR(100) NOT NULL, 
     [RussianName]      NVARCHAR(100) NOT NULL, 
     CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED([CategoryId] ASC)
);
GO

CREATE TABLE [dbo].[ColorType]
(
     [ColorTypeId] INT IDENTITY(1, 1) NOT NULL, 
	 [R] TINYINT NULL,
	 [G] TINYINT NULL,
	 [B] TINYINT NULL,
     [EnglishName] NVARCHAR(100) NOT NULL, 
     [RussianName] NVARCHAR(100) NOT NULL, 
     CONSTRAINT [PK_ColorType] PRIMARY KEY CLUSTERED([ColorTypeId] ASC)
);
GO

CREATE TABLE [dbo].[StyleType]
(
     [StyleTypeId] INT IDENTITY(1, 1) NOT NULL, 
     [EnglishName] NVARCHAR(100) NOT NULL, 
     [RussianName] NVARCHAR(100) NOT NULL, 
     CONSTRAINT [PK_StyleType] PRIMARY KEY CLUSTERED([StyleTypeId] ASC)
);
GO

CREATE TABLE [Product]
(
     [ProductId]       INT IDENTITY(1, 1) NOT NULL, 
     [BrandId]         INT NOT NULL, 
     [VendorCode]      NVARCHAR(30) NOT NULL, 
     [CategoryId]      INT NOT NULL, 
     [StyleId]     INT NOT NULL, 
     [Price]           INT NOT NULL, 
     [Description]     NVARCHAR(400) NOT NULL, 
     [Link]            NVARCHAR(100) NOT NULL, 
     [MadeInCountryId] INT NOT NULL, 
     [PhotoPreviewUrl] NVARCHAR(100) NOT NULL, 
     [CreatedDate]     DATETIME2 NOT NULL DEFAULT(GETDATE()), 
     [IsDeleted]       BIT NOT NULL
                           DEFAULT(0), 
     CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED([ProductId] ASC)
);
GO

CREATE TABLE [ProductPhoto]
(
     [ProductPhotoId] INT IDENTITY(1, 1) NOT NULL, 
     [ProductId]      INT NOT NULL, 
     [PhotoUrl]       NVARCHAR(100) NOT NULL, 
     CONSTRAINT [PK_ProductPhoto] PRIMARY KEY CLUSTERED([ProductPhotoId] ASC)
);
GO

CREATE TABLE [ProductSize]
(
     [ProductId]     INT NOT NULL, 
     [SizeId]        INT NOT NULL, 
     [ColorId]   INT NOT NULL, 
     [Count]         INT NOT NULL DEFAULT(0), 
     [UpdatedDate]   DATETIME2 NOT NULL DEFAULT(GETDATE()), 
     CONSTRAINT [PK_ProductSize] PRIMARY KEY CLUSTERED([ProductId], [SizeId])
);
GO