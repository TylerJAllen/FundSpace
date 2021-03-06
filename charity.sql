USE [master]
GO
/****** Object:  Database [charity]    Script Date: 6/22/2017 2:08:05 PM ******/
CREATE DATABASE [charity]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'charity', FILENAME = N'C:\Users\epicodus\charity.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'charity_log', FILENAME = N'C:\Users\epicodus\charity_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [charity] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [charity].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [charity] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [charity] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [charity] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [charity] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [charity] SET ARITHABORT OFF 
GO
ALTER DATABASE [charity] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [charity] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [charity] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [charity] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [charity] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [charity] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [charity] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [charity] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [charity] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [charity] SET  ENABLE_BROKER 
GO
ALTER DATABASE [charity] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [charity] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [charity] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [charity] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [charity] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [charity] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [charity] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [charity] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [charity] SET  MULTI_USER 
GO
ALTER DATABASE [charity] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [charity] SET DB_CHAINING OFF 
GO
ALTER DATABASE [charity] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [charity] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [charity] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [charity] SET QUERY_STORE = OFF
GO
USE [charity]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [charity]
GO
/****** Object:  Table [dbo].[campaigns]    Script Date: 6/22/2017 2:08:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[campaigns](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NULL,
	[description] [varchar](max) NULL,
	[goal_amt] [int] NULL,
	[current_amt] [int] NULL,
	[start_date] [datetime] NULL,
	[end_date] [datetime] NULL,
	[category_id] [int] NULL,
	[owner_id] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[categories]    Script Date: 6/22/2017 2:08:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[donations]    Script Date: 6/22/2017 2:08:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[donations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[campaign_id] [int] NULL,
	[donation_amount] [int] NULL,
	[donation_date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[roles]    Script Date: 6/22/2017 2:08:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role] [varchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users]    Script Date: 6/22/2017 2:08:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NULL,
	[name] [varchar](255) NULL,
	[login] [varchar](255) NULL,
	[password] [varchar](100) NULL,
	[address] [varchar](255) NULL,
	[phone_number] [varchar](50) NULL,
	[email] [varchar](50) NULL
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[campaigns] ON 

INSERT [dbo].[campaigns] ([id], [name], [description], [goal_amt], [current_amt], [start_date], [end_date], [category_id], [owner_id]) VALUES (13, N'Save Purnell', N'Just before Mother’s Day, our smiley, gentle Purnell was diagnosed with a rare and fatal genetic disease called Niemann-Pick Type A (think baby Alzheimer''s). There is currently no available treatment and if nothing is done, it is unlikely Nell will make it to his 3rd birthday. 

There is gene therapy treatment on the horizon that is within reach and the sole roadblock is funding. Time is of the utmost essence and we urgently need your help raising the funds by June 30 to give Nell the best chance to live.

We are calling on the generosity of family, friends, neighbors and strangers to help us #SavePurnell 
', 100000, 45020, CAST(N'2017-01-12T00:00:00.000' AS DateTime), CAST(N'2017-06-22T00:00:00.000' AS DateTime), 1, 16)
INSERT [dbo].[campaigns] ([id], [name], [description], [goal_amt], [current_amt], [start_date], [end_date], [category_id], [owner_id]) VALUES (14, N'Karl''s Dog fund', N'As Robbie Rotten on LazyTown,  has given laughter to children around the world. He created a foundation to help stop bullying.  He is a tireless advocate for special needs children. 

And now Stefan Karl needs our help. 

Stefan has been diagnosed with pancreatic cancer. The operation he has had will prevent him from working for up to a year.
', 150000, 1020, CAST(N'2017-01-12T00:00:00.000' AS DateTime), CAST(N'2017-06-22T00:00:00.000' AS DateTime), 3, 16)
INSERT [dbo].[campaigns] ([id], [name], [description], [goal_amt], [current_amt], [start_date], [end_date], [category_id], [owner_id]) VALUES (15, N'Charlie''s Medical Bills
', N'You won''t meet a nicer pup than our 2-year-old Golden Retriever German Shepherd mix, Charlie. We''d like to take credit for it, but the truth is, he’s just a guy who was born with a big heart. And that’s exactly where his problem lies: Charlie has a congenital heart disorder called aortic stenosis that makes the passageway through his aorta around 50% smaller than a regular pup. This means that his heart has to work twice as hard to get blood to the rest of his body. 
', 2000, 40, CAST(N'2017-01-12T00:00:00.000' AS DateTime), CAST(N'2017-06-22T00:00:00.000' AS DateTime), 2, 17)
INSERT [dbo].[campaigns] ([id], [name], [description], [goal_amt], [current_amt], [start_date], [end_date], [category_id], [owner_id]) VALUES (16, N'Save Jimmy', N'AT A GLANCE
On Monday, June 5th at around 12:30am, Shariq Jumani, was struck by a fast-moving car as he crossed the street at the intersection of Riverside drive and 115th street. The car, whose driver possessed a 3-time suspended license, barreled into him and fled the scene. Shariq was immediately rushed to nearby St. Luke’s hospital where it was discovered that he had severe brain trauma, fractured both bones in both his legs, and had internal bleeding in his abdomen. Shariq is 19 years old. Since then, he underwent open-brain surgery, abdominal surgery, orthopedic surgery for his legs, and still has a number of surgeries to go.

', 10000, 110, CAST(N'2017-01-12T00:00:00.000' AS DateTime), CAST(N'2017-06-22T00:00:00.000' AS DateTime), 1, 17)
INSERT [dbo].[campaigns] ([id], [name], [description], [goal_amt], [current_amt], [start_date], [end_date], [category_id], [owner_id]) VALUES (17, N'Educate Johnny', N'Just before Mother’s Day, our smiley, gentle Purnell was diagnosed with a rare and fatal genetic disease called Niemann-Pick Type A (think baby Alzheimer''s). There is currently no available treatment and if nothing is done, it is unlikely Nell will make it to his 3rd birthday. ', 10000, 1522, CAST(N'2017-01-12T00:00:00.000' AS DateTime), CAST(N'2017-06-22T00:00:00.000' AS DateTime), 2, 17)
INSERT [dbo].[campaigns] ([id], [name], [description], [goal_amt], [current_amt], [start_date], [end_date], [category_id], [owner_id]) VALUES (26, N'Karl''s Fish  fund', N'You won''t meet a nicer pup than our 2-year-old Golden Retriever German Shepherd mix, Charlie. We''d like to take credit for it, but the truth is, he’s just a guy who was born with a big heart. And that’s exactly where his problem lies: Charlie has a congenital heart disorder called aortic stenosis that makes the passageway through his aorta around 50% smaller than a regular pup. This means that his heart has to work twice as hard to get blood to the rest of his body. 
', 400000, 120, CAST(N'2017-01-12T00:00:00.000' AS DateTime), CAST(N'2017-06-22T00:00:00.000' AS DateTime), 3, 16)
INSERT [dbo].[campaigns] ([id], [name], [description], [goal_amt], [current_amt], [start_date], [end_date], [category_id], [owner_id]) VALUES (27, N'Mary''s Health', N'
I am writing this for my girlfriend Mary because she won''t ask for help. Charlie is the best – the kind of dog that doesn’t even eat the cat food when we leave it out! If you’ve had the pleasure of meeting him, you know just how special he is. We love Charlie so much and need help to afford the upcoming examinations and procedures. The costs are more than expected and outside of what we can afford on such short notice. 
', 120000, 7929, CAST(N'2017-01-12T00:00:00.000' AS DateTime), CAST(N'2017-06-22T00:00:00.000' AS DateTime), 1, 18)
INSERT [dbo].[campaigns] ([id], [name], [description], [goal_amt], [current_amt], [start_date], [end_date], [category_id], [owner_id]) VALUES (28, N'My Dog', N'Even more disconcerting is a large soft tissue mass near his heart and lungs. Charlie will need to get some tissue samples taken from the mass which will tell us if we''re dealing with a cancer (likely lymphoma) or possibly a swelling in his liver caused by a birth defect or a previous trauma. Both of these will be very costly to care for.', 1000, 30, CAST(N'2017-01-12T00:00:00.000' AS DateTime), CAST(N'2017-06-22T00:00:00.000' AS DateTime), 3, 18)
INSERT [dbo].[campaigns] ([id], [name], [description], [goal_amt], [current_amt], [start_date], [end_date], [category_id], [owner_id]) VALUES (29, N'Save the Guns', N'Black Guns Matter educates people in urban communities on their 2nd amendment rights and responsibilities through firearms training and education. 

We are fundraising for a 50 state tour to continue informing urban communities--especially youth--about safe and legal firearms knowledge, conflict resolution, and the 2nd amendment. ', 100000, 12365, CAST(N'2017-01-12T00:00:00.000' AS DateTime), CAST(N'2017-06-22T00:00:00.000' AS DateTime), 2, 18)
INSERT [dbo].[campaigns] ([id], [name], [description], [goal_amt], [current_amt], [start_date], [end_date], [category_id], [owner_id]) VALUES (30, N'ArchDuke Love Fund', N'We are ArchDuke. Two men that have dedicated our entire lives to awakening the sovereign spirit within all people. With absolutely NO capital and NO promotional team, we have managed to get our message of truth, love, and benevolence viewed over 4 MILLION times by amazing people all over the world. Our first educational video ever was viewed more than 1 MILLION times in the first week and our inspirational song "Ama Be Happy" created a craze of "speaking your life into existence" that reverberated through the internet into people''s hearts.', 8000, 920, CAST(N'2017-01-12T00:00:00.000' AS DateTime), CAST(N'2017-06-22T00:00:00.000' AS DateTime), 1, 19)
INSERT [dbo].[campaigns] ([id], [name], [description], [goal_amt], [current_amt], [start_date], [end_date], [category_id], [owner_id]) VALUES (31, N'Tri Met Heroes', N'Two men were killed today because they stood up for two Muslim women who were being harassed on Tri-Met by a racist. Another was injured.  

They are heroes, yet their families are not only going to be faced with the pain of losing people they love, but with financial hardships from their passings.
', 30000, 19209, CAST(N'2017-01-12T00:00:00.000' AS DateTime), CAST(N'2017-06-22T00:00:00.000' AS DateTime), 1, 19)
INSERT [dbo].[campaigns] ([id], [name], [description], [goal_amt], [current_amt], [start_date], [end_date], [category_id], [owner_id]) VALUES (32, N'Puppies', N'Five cute hound puppies that are located in a foster  home in East Tennessee of Halos Second Chance Animal Rescue were bit by a very poisonous Copperhead Snake last night on the foster''s porch. The puppies bodies began to swell immediately and they where whining in pain of the horrible  venom. We had no choice but to rush them to the emergency vet.', 10000, 10020, CAST(N'2017-01-12T00:00:00.000' AS DateTime), CAST(N'2017-06-22T00:00:00.000' AS DateTime), 3, 19)
SET IDENTITY_INSERT [dbo].[campaigns] OFF
SET IDENTITY_INSERT [dbo].[categories] ON 

INSERT [dbo].[categories] ([id], [name]) VALUES (1, N'medical')
INSERT [dbo].[categories] ([id], [name]) VALUES (2, N'education')
INSERT [dbo].[categories] ([id], [name]) VALUES (3, N'animals')
INSERT [dbo].[categories] ([id], [name]) VALUES (4, N'emergencies')
INSERT [dbo].[categories] ([id], [name]) VALUES (5, N'art')
INSERT [dbo].[categories] ([id], [name]) VALUES (6, N'charity')
SET IDENTITY_INSERT [dbo].[categories] OFF
SET IDENTITY_INSERT [dbo].[donations] ON 

INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (1, 1, 1, 50, CAST(N'2017-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (2, 2, 1, 123, CAST(N'2017-06-20T16:24:32.477' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (3, 2, 1, 134142, CAST(N'2017-06-20T17:09:03.907' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (4, 2, 1, 100, CAST(N'2017-06-20T17:13:22.773' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (17, 9, 6, 12312, CAST(N'2017-06-21T17:11:54.940' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (5, 2, 1, 1, CAST(N'2017-06-20T17:20:29.163' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (19, 9, 6, 123123, CAST(N'2017-06-21T17:12:15.553' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (8, 13, 1, 1, CAST(N'2017-06-21T08:34:18.247' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (9, 9, 2, 100, CAST(N'2017-06-21T10:32:24.103' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (10, 9, 2, 1, CAST(N'2017-06-21T10:33:43.167' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (11, 14, 9, 1234124, CAST(N'2017-06-21T10:50:23.770' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (12, 9, 1, 500, CAST(N'2017-06-21T13:07:51.603' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (13, 9, 1, 45, CAST(N'2017-06-21T13:08:16.670' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (18, 9, 6, 1232, CAST(N'2017-06-21T17:12:03.073' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (20, 9, 2, 2, CAST(N'2017-06-21T17:25:42.543' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (21, 9, 13, 1, CAST(N'2017-06-22T11:38:21.837' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (22, 16, 14, 10, CAST(N'2017-06-22T12:55:47.020' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (23, 16, 15, 10, CAST(N'2017-06-22T12:56:02.840' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (24, 16, 13, 10, CAST(N'2017-06-22T12:56:11.250' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (26, 16, 17, 12, CAST(N'2017-06-22T12:56:30.393' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (28, 16, 27, 10, CAST(N'2017-06-22T12:56:54.520' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (30, 17, 14, 10, CAST(N'2017-06-22T12:57:57.313' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (31, 17, 15, 10, CAST(N'2017-06-22T12:58:02.857' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (32, 17, 16, 10, CAST(N'2017-06-22T12:58:09.097' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (33, 17, 17, 10, CAST(N'2017-06-22T12:58:16.160' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (34, 17, 26, 10, CAST(N'2017-06-22T12:58:26.577' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (35, 18, 27, 10, CAST(N'2017-06-22T12:58:51.247' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (38, 18, 30, 10, CAST(N'2017-06-22T12:59:12.897' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (40, 18, 32, 10, CAST(N'2017-06-22T12:59:27.673' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (42, 19, 28, 10, CAST(N'2017-06-22T12:59:57.343' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (43, 19, 29, 10, CAST(N'2017-06-22T13:00:04.823' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (46, 19, 32, 10, CAST(N'2017-06-22T13:00:35.407' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (25, 16, 16, 10, CAST(N'2017-06-22T12:56:22.433' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (27, 16, 26, 10, CAST(N'2017-06-22T12:56:44.633' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (29, 17, 13, 10, CAST(N'2017-06-22T12:57:50.457' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (36, 18, 28, 10, CAST(N'2017-06-22T12:58:59.583' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (39, 18, 31, 10, CAST(N'2017-06-22T12:59:19.800' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (41, 19, 27, 10, CAST(N'2017-06-22T12:59:49.640' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (44, 19, 30, 10, CAST(N'2017-06-22T13:00:14.863' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (45, 19, 31, 100, CAST(N'2017-06-22T13:00:24.657' AS DateTime))
INSERT [dbo].[donations] ([id], [user_id], [campaign_id], [donation_amount], [donation_date]) VALUES (37, 18, 29, 10, CAST(N'2017-06-22T12:59:05.960' AS DateTime))
SET IDENTITY_INSERT [dbo].[donations] OFF
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [role_id], [name], [login], [password], [address], [phone_number], [email]) VALUES (16, 1, N'Lena', N'lena123', N'password', N'123 Main Street', N'555-555-5555', N'email@email.com')
INSERT [dbo].[users] ([id], [role_id], [name], [login], [password], [address], [phone_number], [email]) VALUES (17, 1, N'Jun', N'jun123', N'password', N'123 Main Street', N'555-555-5555', N'email@email.com')
INSERT [dbo].[users] ([id], [role_id], [name], [login], [password], [address], [phone_number], [email]) VALUES (18, 1, N'Tyler', N'tyler123', N'password', N'123 Main Street', N'555-555-5555', N'email@email.com')
INSERT [dbo].[users] ([id], [role_id], [name], [login], [password], [address], [phone_number], [email]) VALUES (19, 1, N'Daniela', N'dani123', N'password', N'123 Main Street', N'555-555-5555', N'email@email.com')
INSERT [dbo].[users] ([id], [role_id], [name], [login], [password], [address], [phone_number], [email]) VALUES (26, 1, N'Kim', N'kim123', N'password', N'123 Main Street', N'555-555-5555', N'email@gmail.com')
SET IDENTITY_INSERT [dbo].[users] OFF
USE [master]
GO
ALTER DATABASE [charity] SET  READ_WRITE 
GO
