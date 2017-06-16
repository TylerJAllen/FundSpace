USE [master]
GO
/****** Object:  Database [charity]    Script Date: 6/15/2017 12:31:13 PM ******/
CREATE DATABASE [charity]

GO
USE [charity]
GO
/****** Object:  Table [dbo].[campaigns]    Script Date: 6/15/2017 12:31:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[campaigns](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[description] [varchar](255) NULL,
	[goal_amt] [int] NULL,
	[current_amt] [int] NULL,
	[start_date] [datetime] NULL,
	[end_date] [datetime] NULL,
	[category_id] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[categories]    Script Date: 6/15/2017 12:31:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users]    Script Date: 6/15/2017 12:31:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NULL,
	[role_id] [int] NULL,
	[contact_id] [int] NULL,
	[email_login] [varchar](255) NULL,
	[password] [varchar](100) NULL,
	[donate_amt] [int] NULL,
	[address] [varchar](255) NULL,
	[phone_number] [varchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users_donator_campaigns]    Script Date: 6/15/2017 12:31:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users_donator_campaigns](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campaign_id] [int] NULL,
	[user_id] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users_roles]    Script Date: 6/15/2017 12:31:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users_roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[role_id] [int] NULL
) ON [PRIMARY]

GO