CREATE DATABASE [ZebraAccount];
GO

USE [ZebraAccount];
GO

CREATE TABLE [dbo].[User]
(
     [UserId]                 INT IDENTITY(1, 1) NOT NULL, 
     [RoleTypeId]             BIT NOT NULL DEFAULT(0), 
     [Email]                  NVARCHAR(256) NULL, 
     [IsEmailConfirmed]       BIT NOT NULL, 
     [PasswordHash]           NVARCHAR(256) NULL, 
     [PhoneNumber]            NVARCHAR(256) NULL, 
     [IsPhoneNumberConfirmed] BIT NOT NULL DEFAULT(0), 
     [IsTwoFactorEnabled]     BIT NOT NULL, 
     [AccessFailedCount]      INT NOT NULL DEFAULT(0), 
     [RegistrationDate]       DATETIME2(7) NOT NULL DEFAULT(GETDATE()), 
     [IsDeleted]              BIT NOT NULL DEFAULT 0, 
     CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED([UserId] ASC)
);
GO

CREATE TABLE [dbo].[Token]
(
     [TokenId]      BIGINT IDENTITY(1, 1) NOT NULL, 
     [UserId]       INT NOT NULL, 
     [ExpiresIn]    BIGINT NOT NULL, 
     [RefreshToken] NVARCHAR(500) NOT NULL, 
     CONSTRAINT [PK_Token] PRIMARY KEY CLUSTERED([TokenId] ASC)
);
GO

CREATE TABLE [dbo].[Social]
(
     [SocialId]      INT IDENTITY(1, 1) NOT NULL, 
     [SocialTypeId]  INT NOT NULL, 
     [InternalId]    INT NOT NULL, 
     [ExternalId]    BIGINT NOT NULL, 
     [Email]         NVARCHAR(256) NULL, 
     [PhoneNumber]   NVARCHAR(256) NULL, 
     [ExternalToken] NVARCHAR(256) NULL, 
     [ExpiresIn]     BIGINT NOT NULL, 
     [IsDeleted]     BIT NOT NULL DEFAULT 0, 
     CONSTRAINT [PK_Social] PRIMARY KEY CLUSTERED([SocialId] ASC)
);
GO

CREATE TABLE [dbo].[SocialType]
(
     [SocialTypeId] INT IDENTITY(1, 1) NOT NULL, 
     [EnglishName]  NVARCHAR(256) NOT NULL, 
     [RussianName]  NVARCHAR(256) NOT NULL
	CONSTRAINT [PK_SocialType] PRIMARY KEY CLUSTERED ([SocialTypeId] ASC)
);
GO

CREATE TABLE [dbo].[RoleType]
(
     [RoleTypeId]  INT IDENTITY(1, 1) NOT NULL, 
     [EnglishName] NVARCHAR(256) NOT NULL, 
     [RussianName] NVARCHAR(256) NOT NULL
	 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED ([RoleTypeId] ASC)
);
GO

CREATE PROC [dbo].[uprAddUser] 
     @email                            NVARCHAR(256), 
     @isEmailConfirmed                 BIT, 
     @passwordHash                     NVARCHAR(256), 
     @phoneNumber                      NVARCHAR(256), 
     @isPhoneNumberConfirmed           BIT, 
     @isTwoFactorEnabled BIT, 
     @registrationDate                 DATETIME2, 
     @userId                           INT = NULL OUTPUT
AS
     BEGIN
         INSERT INTO [dbo].[User]
         VALUES
                (
                0, @email, @isEmailConfirmed, @passwordHash, @phoneNumber, @isPhoneNumberConfirmed, @isTwoFactorEnabled, @registrationDate, 0
                );
         SELECT @userId = @@IDENTITY;
     END;
         RETURN @userId;
GO

CREATE PROC [dbo].[uorAddUserWithId] 
     @userId                           INT, 
     @email                            NVARCHAR(256), 
     @isEmailConfirmed                 BIT, 
     @passwordHash                     NVARCHAR(256), 
     @phoneNumber                      NVARCHAR(256), 
     @isPhoneNumberConfirmed           BIT, 
     @isTwoFactorEnabled BIT, 
     @registrationDate                 DATETIME2
AS
     BEGIN
         SET IDENTITY_INSERT [dbo].[User] ON;
         INSERT INTO [dbo].[User]
         (UserId, 
          AccessFailedCount, 
          Email, 
          IsEmailConfirmed, 
          PasswordHash, 
          PhoneNumber, 
          IsPhoneNumberConfirmed, 
          IsTwoFactorEnabled, 
          RegistrationDate, 
          IsDeleted
         )
         VALUES
                (
                @userId, 0, @email, @isEmailConfirmed, @passwordHash, @phoneNumber, @isPhoneNumberConfirmed, @isTwoFactorEnabled, @registrationDate, 0
                );
         SET IDENTITY_INSERT [dbo].[User] OFF;
     END;
         RETURN @userId;
GO