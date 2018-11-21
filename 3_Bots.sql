USE [Zebra];
GO

--SET IDENTITY_INSERT [dbo].[Questions] ON

--SET IDENTITY_INSERT [dbo].[Questions] OFF

CREATE PROCEDURE [dbo].[uspAddProductBot]
( 
				@vendorCode nvarchar(50), @brandName nvarchar(50),  @categoryName nvarchar(50), @colorName nvarchar(50), @printName nvarchar(50), @price decimal(8, 2), @madeInCountry nvarchar(50), @link nvarchar(100), @previewPhotoUrl nvarchar(50)
)
AS
BEGIN

	DECLARE @productId int

	SELECT @productId = ProductID
	FROM dbo.Product
	WHERE VendorCode = @vendorCode;

	IF @productId IS NOT NULL
	BEGIN
		RETURN @productId;
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

		SET @brandId = @@IDENTITY;
	END;

	-- category
	DECLARE @categoryId int;

	SELECT @categoryId = CategoryID
	FROM dbo.Category
	WHERE RussianName = @categoryName;

	IF @categoryId IS NULL
	BEGIN
		INSERT INTO [dbo].Category( RussianName )
		VALUES( @categoryName );

		SET @categoryId = @@IDENTITY;
	END;

	-- color
	DECLARE @colorId int;

	SELECT @colorId = ColorTypeID
	FROM dbo.ColorType
	WHERE RussianName = @colorName;

	IF @colorId IS NULL
	BEGIN
		INSERT INTO [dbo].ColorType( RussianName )
		VALUES( @colorName );

		SET @colorId = @@IDENTITY;
	END;

	-- print
	DECLARE @printId int;

	SELECT @printId = PrintTypeID
	FROM dbo.PrintType
	WHERE [RussianName] = @printName;

	IF @printId IS NULL
	BEGIN
		INSERT INTO [dbo].PrintType( RussianName )
		VALUES( @printName );

		SET @printId = @@IDENTITY;
	END;

	-- country
	DECLARE @countryId int;

	SELECT @countryId = CountryID
	FROM dbo.Country
	WHERE [RussianName] = @madeInCountry;

	IF @countryId IS NULL
	BEGIN
		INSERT INTO [dbo].Country( RussianName )
		VALUES( @madeInCountry );

		SET @countryId = @@IDENTITY;
	END;

	-- product

	INSERT INTO [dbo].[Product]( [BrandID], [VendorCode], [CategoryID], [PrintTypeID], [Price], [Description], [Link], [MadeInCountryID], [PreviewPhotoUrl], [CreatedDate], [IsDeleted] )
	VALUES( @brandId, @vendorCode, @categoryId, @printId, @price, '', @link, @countryId, @previewPhotoUrl, GETDATE(), 0 );

	
	SELECT @productId = @@IDENTITY;

	-- colorType

	IF NOT EXISTS
	(
		SELECT *
		FROM ProductColorType
		WHERE ProductID = @productId AND 
			  ColorTypeID = @colorId
	)
	BEGIN
		INSERT INTO [dbo].ProductColorType( ProductID, ColorTypeID )
		VALUES( @productId, @colorId );
	END;

	RETURN @productId
END;

GO

CREATE PROCEDURE uspAddProductSizeTypeBot
( 
				@vendorCode nvarchar(50), @isAvailable bit, @russianSize nvarchar(50), @otherCountrySize nvarchar(50), @otherCountrySizeType nvarchar(50)
)
AS
BEGIN

	DECLARE @productId int
	SELECT @productId = ProductID
	FROM Product
	WHERE VendorCode = @vendorCode;

	IF @productId IS NULL
	BEGIN
		RETURN;
	END;

	---- sizeType 

	DECLARE @sizeTypeId int
	SELECT TOP (1) @sizeTypeId = SizeTypeID
	FROM dbo.SizeType
	WHERE Russian = @russianSize AND 
		  OtherCountrySize = @otherCountrySize AND 
		  CountryType = @otherCountrySizeType;

	IF @sizeTypeId IS NULL
	BEGIN
		INSERT INTO [dbo].SizeType( Russian, IsAvailable, OtherCountrySize, CountryType )
		VALUES( @russianSize, @isAvailable, @otherCountrySize, @otherCountrySizeType );

		SET @sizeTypeId = @@IDENTITY;
	END;

	-- product sizeType

	IF NOT EXISTS
	(
		SELECT *
		FROM ProductSizeType
		WHERE ProductID = @productId AND 
			  SizeTypeID = @sizeTypeId
	)
	BEGIN
		INSERT INTO [dbo].ProductSizeType( ProductID, SizeTypeID, IsAvailable, UpdatedDate )
		VALUES( @productId, @sizeTypeId, @isAvailable, GETDATE() );

	END;
	
	RETURN @sizeTypeId

END;

GO

CREATE PROCEDURE uspAddProductColorTypeBot
( 
				@vendorCode nvarchar(50), @russianColorName nvarchar(50)
)
AS
BEGIN

	DECLARE  @productId int
	SELECT @productId = ProductID
	FROM Product
	WHERE VendorCode = @vendorCode;

	IF @productId IS NULL
	BEGIN
		RETURN;
	END;

	---- color 

	DECLARE @colorTypeId int 
	SELECT @colorTypeId = SizeTypeID
	FROM dbo.SizeType
	WHERE Russian = @russianColorName;

	IF @colorTypeId IS NULL
	BEGIN
		INSERT INTO [dbo].SizeType( Russian )
		VALUES( @russianColorName );

		SET @colorTypeId = @@IDENTITY;
	END;

	-- product sizeType

	IF NOT EXISTS
	(
		SELECT *
		FROM ProductColorType
		WHERE ProductID = @productId AND 
			  ColorTypeID = @colorTypeId
	)
	BEGIN
		INSERT INTO [dbo].ProductColorType( ProductID, ColorTypeID )
		VALUES( @productId, @colorTypeId );
	END;

	RETURN @colorTypeId

END;

GO

CREATE PROCEDURE uspAddProductPhotoBot
( 
				@vendorCode nvarchar(50), @photoUrl nvarchar(100)
)
AS
BEGIN

	DECLARE  @productId int
	SELECT @productId = ProductID
	FROM Product
	WHERE VendorCode = @vendorCode;

	IF @productId IS NULL
	BEGIN
		RETURN;
	END;

	---- color 

	DECLARE @productPhotoID int 
	SELECT @productPhotoID = ProductPhotoID
	FROM dbo.ProductPhoto
	WHERE ProductID = @productId AND PhotoUrl = @photoUrl;

	IF @productPhotoID IS NULL
	BEGIN
		INSERT INTO [dbo].ProductPhoto( ProductID, PhotoUrl )
		VALUES( @productId, @photoUrl );

		SET @productPhotoID = @@IDENTITY;
	END;

	

	RETURN @productPhotoID

END;