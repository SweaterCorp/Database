
USE [Zebra];
GO

--SET IDENTITY_INSERT [dbo].[Questions] ON

--SET IDENTITY_INSERT [dbo].[Questions] OFF

CREATE PROCEDURE uspAddProductBot
( 
				 @vendorCode nvarchar(50), @brandName nvarchar(50), @categoryName nvarchar(50), @colorName nvarchar(50), @printName nvarchar(50), @styleName nvarchar(50), @price decimal(6, 2), @madeInCountry nvarchar(50), @link nvarchar(100)
)
AS
BEGIN
	IF EXISTS
	(
		SELECT *
		FROM Product
		WHERE VendorCode = @vendorCode
	)
	BEGIN
		RETURN;
	END;

	---- brand 
	DECLARE @brandId int;

	SELECT @brandId = BrandID
	FROM dbo.Brand
	WHERE [Name] = @brandName;

	IF @brandId IS NULL
	BEGIN
		INSERT INTO [dbo].[Brand]( [Name], [Site], [LogoUrl] )
		VALUES( @brandName, '', '' );
	END;

	SELECT @brandId = @@IDENTITY;

	-- category
	DECLARE @categoryId int;

	SELECT @categoryId = CategoryID
	FROM dbo.Category
	WHERE RussianName = @categoryName;

	IF @categoryId IS NULL
	BEGIN
		INSERT INTO [dbo].Category( RussianName )
		VALUES( @categoryName );
	END;

	SELECT @categoryId = @@IDENTITY;

	-- color
	DECLARE @colorId int;

	SELECT @colorId = ColorTypeID
	FROM dbo.ColorType
	WHERE RussianName = @colorName;

	IF @colorId IS NULL
	BEGIN
		INSERT INTO [dbo].ColorType( RussianName )
		VALUES( @colorName );
	END;

	SELECT @colorId = @@IDENTITY;

	-- print
	DECLARE @printId int;

	SELECT @printId = PrintTypeID
	FROM dbo.PrintType
	WHERE [RussianName] = @printName;

	IF @printId IS NULL
	BEGIN
		INSERT INTO [dbo].PrintType( RussianName )
		VALUES( @printName );
	END;

	SELECT @printId = @@IDENTITY;

	-- style
	DECLARE @styleId int;

	SELECT @styleId = StyleTypeID
	FROM dbo.StyleType
	WHERE [RussianName] = @styleName;

	IF @styleId IS NULL
	BEGIN
		INSERT INTO [dbo].StyleType( RussianName )
		VALUES( @styleName );
	END;

	SELECT @styleId = @@IDENTITY;

	-- country
	DECLARE @countryId int;

	SELECT @countryId = CountryID
	FROM dbo.Country
	WHERE [RussianName] = @madeInCountry;

	IF @countryId IS NULL
	BEGIN
		INSERT INTO [dbo].Country( RussianName )
		VALUES( @madeInCountry );
	END;

	SELECT @countryId = @@IDENTITY;

	-- product

	INSERT INTO [dbo].[Product]( [BrandID], [VendorCode], [CategoryID], [StyleTypeID], [PrintTypeID], [Price], [Description], [Link], [MadeInCountryID], [PhotoPreviewUrl], [CreatedDate], [IsDeleted] )
	VALUES( @brandId, @vendorCode, @categoryId, @styleId, @printId, @price, '', @link, @countryId, '', GETDATE(), 0 );

END;

GO



CREATE PROCEDURE uspAddProductSizeTypeBot
( 
				 @vendorCode nvarchar(50), @russianSize nvarchar(50), @isAvailable bit, @otherCountrySize nvarchar(50), @otherCountrySizeType nvarchar(50)
)
AS
BEGIN

	DECLARE @productId int;

	SELECT @productId = ProductID
	FROM Product
	WHERE VendorCode = @vendorCode;

	IF @productId IS NULL
	BEGIN
		RETURN;
	END;

	---- brand 
	DECLARE @sizeTypeId int;

	SELECT @sizeTypeId = SizeTypeID
	FROM dbo.SizeType
	WHERE Russian = @russianSize;

	IF @sizeTypeId IS NULL
	BEGIN
		INSERT INTO [dbo].SizeType( Russian, IsAvailable, OtherCountrySize, CountyType )
		VALUES( @russianSize, @isAvailable, @otherCountrySize, @otherCountrySizeType );
	END;

	SELECT @sizeTypeId = @@IDENTITY;

	-- product sizeType

	INSERT INTO [dbo].ProductSizeType( ProductID, SizeTypeID, IsAvailable, UpdatedDate )
	VALUES( @productId, @sizeTypeId, @isAvailable, GETDATE() );

END;

GO

CREATE PROCEDURE uspAddProductColorTypeBot
( 
				 @vendorCode nvarchar(50), @russianColorName nvarchar(50)
)
AS
BEGIN

	DECLARE @productId int;

	SELECT @productId = ProductID
	FROM Product
	WHERE VendorCode = @vendorCode;

	IF @productId IS NULL
	BEGIN
		RETURN;
	END;

	---- color 
	DECLARE @colorTypeId int;

	SELECT @colorTypeId = SizeTypeID
	FROM dbo.SizeType
	WHERE Russian = @russianColorName;

	IF @colorTypeId IS NULL
	BEGIN
		INSERT INTO [dbo].SizeType( Russian )
		VALUES( @russianColorName );
	END;

	SELECT @colorTypeId = @@IDENTITY;

	-- product sizeType

	INSERT INTO [dbo].ProductColorType( ProductID, ColorTypeID )
	VALUES( @productId, @colorTypeId );

END;