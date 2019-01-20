USE Sweater;

GO

CREATE FUNCTION [dbo].[ufnGetCategorySizes]
( 
				@categoryId int
)
RETURNS @Size TABLE
( 
					sizeTypeID int, russianSize nvarchar(10), otherCountry nvarchar(10), countryCode nvarchar(10)
)
BEGIN
	INSERT INTO @Size
		   SELECT SizeTypeID, RussianSize, OtherCountry, CountryCode
		   FROM SizeType
		   WHERE SizeTypeID IN
		   (
			   SELECT SizeTypeID
			   FROM ProductSizeType
			   WHERE ProductID IN
			   (
				   SELECT ProductID
				   FROM Product
				   WHERE CategoryID = @categoryId
			   )
		   );
	RETURN;
END;

GO

CREATE FUNCTION [dbo].[ufnGetCategoryBrands]
( 
				@categoryId int
)
RETURNS @Brand TABLE
( 
					 [BrandID] int, [Name] nvarchar(50), [Site] nvarchar(100), [LogoUrl] nvarchar(100)
)
BEGIN
	INSERT INTO @Brand
		   SELECT BrandID, [Name], [Site], LogoUrl
		   FROM Brand
		   WHERE BrandID IN
		   (
			   SELECT BrandID
			   FROM Product
			   WHERE CategoryID = @categoryId
		   );
	RETURN;
END;

GO

--CREATE FUNCTION [dbo].[ufnGetCategoryColors]
--( 
--				@categoryId int
--)
--RETURNS @Color TABLE
--( 
--					 [ColorTypeID] int, [Hex] nvarchar(6), [EnglishName] nvarchar(50), [RussianName] nvarchar(50)
---- [ColorTypeID] int NOT NULL, [Hex] nvarchar(6) NOT NULL DEFAULT(''), [EnglishName] nvarchar(50) NOT NULL DEFAULT(''), [RussianName] nvarchar(50) NOT NULL DEFAULT('')
--)
--BEGIN
--	INSERT INTO @Color
--		   SELECT ColorTypeID, Hex, [EnglishName], [RussianName]
--		   FROM ColorType
--		   WHERE ColorTypeID IN
--		   (
--			   SELECT ColorTypeID
--			   FROM ProductColorType
--			   WHERE ColorTypeID IN
--			   (
--				   SELECT ProductID
--				   FROM Product
--				   WHERE CategoryID = @categoryId
--			   )
--		   );
--	RETURN;
--END;

--GO

