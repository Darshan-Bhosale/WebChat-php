USE [master]
GO
/****** Object:  Database [ashwanisri_]    Script Date: 10-May-18 12:11:19 PM ******/
CREATE DATABASE [ashwanisri_]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ashwanisri_', FILENAME = N'E:\MSSQL.MSSQLSERVER\DATA\ashwanisri_.mdf' , SIZE = 4096KB , MAXSIZE = 204800KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ashwanisri__log', FILENAME = N'D:\MSSQL.MSSQLSERVER\DATA\ashwanisri__log.ldf' , SIZE = 1024KB , MAXSIZE = 102400KB , FILEGROWTH = 1024KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ashwanisri_].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ashwanisri_] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ashwanisri_] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ashwanisri_] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ashwanisri_] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ashwanisri_] SET ARITHABORT OFF 
GO
ALTER DATABASE [ashwanisri_] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ashwanisri_] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ashwanisri_] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ashwanisri_] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ashwanisri_] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ashwanisri_] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ashwanisri_] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ashwanisri_] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ashwanisri_] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ashwanisri_] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ashwanisri_] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ashwanisri_] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ashwanisri_] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ashwanisri_] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ashwanisri_] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ashwanisri_] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ashwanisri_] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ashwanisri_] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ashwanisri_] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ashwanisri_] SET  MULTI_USER 
GO
ALTER DATABASE [ashwanisri_] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ashwanisri_] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ashwanisri_] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ashwanisri_] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ashwanisri_]
GO
/****** Object:  User [invent]    Script Date: 10-May-18 12:11:20 PM ******/
CREATE USER [invent] FOR LOGIN [invent] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [gd_execprocs]    Script Date: 10-May-18 12:11:20 PM ******/
CREATE ROLE [gd_execprocs]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [invent]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [invent]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [invent]
GO
ALTER ROLE [db_datareader] ADD MEMBER [invent]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [invent]
GO
/****** Object:  Schema [invent]    Script Date: 10-May-18 12:11:21 PM ******/
CREATE SCHEMA [invent]
GO
/****** Object:  StoredProcedure [dbo].[Proc_AddAdmin]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_AddAdmin]

@Username varchar(120),
@Password varchar(120),
@Name varchar(120),
@Added_Date datetime
	
AS
BEGIN
	
	SET NOCOUNT ON;

    declare @data varchar(120);

	select @data=Username from User_Master where Username=@Username;
	if(@data is null)
	begin
		insert into User_Master(First_Name,Type,Username,Password,Added_By,Added_Date) values(@Name,'Admin',@Username,@Password,'Admin',@Added_Date)
		select '1';
	end
	else
	begin 
		select '0'
	end

END

GO
/****** Object:  StoredProcedure [dbo].[proc_AddComment]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_AddComment]

@Post_Id varchar(120),
@Comment varchar(max),
@Added_By varchar(120),
@Added_Date datetime
	
AS
BEGIN
	
	SET NOCOUNT ON;
	declare @id int;
    insert into Comments_Master(Post_Id,Comment,Added_By,Added_Date) 
						 values(@Post_Id,@Comment,@Added_By,@Added_Date)
	set @id=SCOPE_IDENTITY();
	Select um.First_Name,um.Last_Name,um.Image,cm.* from Comments_Master cm
	join User_Master um on um.User_Id=cm.Added_By
	 where cm.Comment_Id = @id
END

GO
/****** Object:  StoredProcedure [dbo].[proc_DeleteAll]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_DeleteAll]
@Id bigint,
@Type varchar(15)
	
AS
BEGIN
	
	SET NOCOUNT ON;

    IF(@Type = 'dept')
	   BEGIN
			delete from Department_Master where Dept_Id=@Id;
	   END
    ELSE IF(@Type = 'user')
	   BEGIN
			delete from User_Master where User_Id=@Id;
	   END
	ELSE IF(@Type = 'grp')
		BEGIN
			delete from Group_Master where Grp_Id=@Id;
		END

END


GO
/****** Object:  StoredProcedure [dbo].[proc_GetAllData]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[proc_GetAllData]

@Type varchar(120),
@User_Id varchar(120)
	
AS
BEGIN
	
	SET NOCOUNT ON;
	declare @dept varchar(50);
	declare @tcnt bigint;
	declare @cnt bigint;
	declare @ids varchar(120);
	declare @data varchar(120);
	DECLARE @sql nvarchar(max);

    IF(@Type = 'Admin')
		BEGIN
			select um.*,(select Name from Department_Master where Dept_Id=um.Dept_Id) as Dept from User_Master um where um.User_Id not in (@User_Id) order by isnull(um.Modified_Date,um.Added_Date) desc;
			select * from Group_Master;
		END
	ELSE
		BEGIN
			select um.*,(select Name from Department_Master where Dept_Id=um.Dept_Id) as Dept from User_Master um
			where --Dept_Id = (select Dept_Id from User_Master where User_Id=@User_Id) 
			um.User_Id not in (@User_Id) 
			and um.Type = 'User'
			order by isnull(um.Modified_Date,um.Added_Date) desc;
			
			select ROW_NUMBER() OVER(ORDER BY Grp_Id ASC) AS Row,* into #temp from Group_Master 
			select @cnt=COUNT(*) from Group_Master
			set @tcnt=1;
			set @ids='';
			WHILE (@tcnt <= @cnt)
				BEGIN
					IF(@User_Id in (SELECT * FROM dbo.SplitString((select User_Id from #temp where Row=@tcnt ), ',')))
						BEGIN
							select @data=Grp_Id from #temp where Row=@tcnt;
							print @data;
							set @ids += @data + ',';
							print @ids;
						END
						SET @tcnt = @tcnt + 1;
				END
				if(@ids <> '')
				begin
					set @ids=SUBSTRING(@ids,1,LEN(@ids)-1);
				end
				else
				begin
					set @ids='0';
				end
					SELECT @sql = 'select * from Group_Master where Convert(varchar,Grp_Id) in ('+@ids+')';
					EXEC sp_executesql @sql;
				
				drop table #temp			
		END
END


GO
/****** Object:  StoredProcedure [dbo].[Proc_GetAllGrpMessages]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_GetAllGrpMessages]
	@Grp_Id varchar(120)
	
AS
BEGIN
	
	SET NOCOUNT ON;

    --select top 10 (select (First_Name+' '+Last_Name) from User_Master where User_Id=chg.Sender_Id)as Name,
	--(select Image from User_Master where  User_Id = chg.Sender_Id) as User_Pic,* 
	--from Chat_Master_Group chg
	--where chg.Grp_Id in (@Grp_Id)
	--order by chg.Added_Date asc

	select * from (select top 10 (select (First_Name+' '+Last_Name) from User_Master where User_Id=chg.Sender_Id)as Name,
	(select Image from User_Master where  User_Id = chg.Sender_Id) as User_Pic,* 
	from Chat_Master_Group chg
	where chg.Grp_Id in (@Grp_Id)
	order by chg.Added_Date desc) as obj order by Added_Date asc
END


GO
/****** Object:  StoredProcedure [dbo].[Proc_GetAllMessages]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_GetAllMessages]
	@User_Id varchar(120),
	@Receiver_Id varchar(120)
	
AS
BEGIN
	
	SET NOCOUNT ON;

    select top 10 (select Image from User_Master where User_Id=@User_Id )as User_Pic,
	(select Image from User_Master where User_Id=@Receiver_Id )as Receiver_Pic,
	(select First_Name+' '+Last_Name from User_Master where User_Id=@User_Id )as User_Name,
	(select First_Name+' '+Last_Name from User_Master where User_Id=@Receiver_Id )as Receiver_Name,
	* into #temp from Chat_Master_User cmu
	   where (Added_By in (@User_Id) or Added_By in (@Receiver_Id)) and 
	  (Receiver_Id in(@User_Id) and User_Id in (@Receiver_Id)) or
	  (Receiver_Id in(@Receiver_Id) and User_Id in (@User_Id))
	  order by Added_Date desc

	  select * from #temp order by Added_Date asc

	  update Chat_Master_User set Readmsg='1' where Chat_User_Id in (select Chat_User_Id from Chat_Master_User cmu
	   where (Added_By in (@User_Id) or Added_By in (@Receiver_Id)) and 
	  (Receiver_Id in(@User_Id) and User_Id in (@Receiver_Id)) or
	  (Receiver_Id in(@Receiver_Id) and User_Id in (@User_Id)))

	  drop table #temp
END

--select * from User_Master
--select * from Chat_Master_User
GO
/****** Object:  StoredProcedure [dbo].[proc_GetGrpMsg]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_GetGrpMsg]
	@Grp_Id varchar(120),
	@Chat_Id bigint,
	@User_Id varchar(120)
AS
BEGIN
	
	SET NOCOUNT ON;

	select (select (First_Name+' '+Last_Name) from User_Master where User_Id=chg.Sender_Id)as Name,
	(select Image from User_Master where  User_Id = chg.Sender_Id) as User_Pic,* 
	from Chat_Master_Group chg
	where chg.Grp_Id in (@Grp_Id)
	and Chat_Group_Id > @Chat_Id AND Added_By not in(@User_Id)
	order by chg.Added_Date asc
END


--select * from Chat_Master_Group
GO
/****** Object:  StoredProcedure [dbo].[proc_GetGrpMsgNotify]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_GetGrpMsgNotify]

@Added_Date varchar(120),
@User_Id varchar(120) 
	
AS
BEGIN
	
	SET NOCOUNT ON;
	Declare @dat varchar(120);
	Declare @data varchar(120);
	Declare @spl varchar(120);
	declare @sql nvarchar(Max);

	DECLARE @site_value INT;
	SET @site_value = 0;
	SET @dat='';
	SET @data='';
	SET @spl='';

	SELECT @User_Id as User_Ids,ROW_NUMBER() OVER(ORDER BY Grp_Id ASC) AS Row#,* into #temp FROM Group_Master

	WHILE @site_value <= (select count(*) from Group_Master)
	BEGIN

	if(@site_value <> 0)
	   begin
		   if(@User_Id in (select Item from Splitstring((select User_Id from #temp where Row#=@site_value),',')))
			   begin
				select @dat=Grp_Id from #temp where Row#=@site_value
			   end
		   SET @data+=@dat+',';
	   end
	 SET @site_value = @site_value + 1;
	 set @dat=''
	   
	END;

	--SELECT SUBSTRING('TechOnTheNet.com', 1, 4);
	Set @sql='select (select Name from Group_Master where Grp_Id=chg.Grp_Id) as Grp_Name, '+
			'(select (First_Name) from User_Master where User_Id=chg.Sender_Id)as Name, '+
			'(select Image from User_Master where  User_Id = chg.Sender_Id) as User_Pic,* '+
			'from Chat_Master_Group chg '+
			'where chg.Grp_Id in ('+ (SELECT SUBSTRING(@data, 1, len(@data)-1))+')'+
			'AND Added_By not in('+@User_Id+') '+
			'and chg.Added_Date > Convert(datetime,'''+@Added_Date+''',103) '+
			'order by chg.Added_Date asc';
			exec sp_executesql @sql;
	drop table #temp
    
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_GetPostsAttach]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_GetPostsAttach]
@Post varchar(max),
@Added_By varchar(120),
@Added_Date datetime,
@Attach varchar(200)

AS
BEGIN
	SET NOCOUNT ON;
	declare @id int;

	insert into Post_Master (Message,Added_By,Added_Date,Attachment) 
	values(@Post,@Added_By,@Added_Date,@Attach)

	set @id=SCOPE_IDENTITY();
	select * from Post_Master where Post_Id=@id

END

GO
/****** Object:  StoredProcedure [dbo].[proc_GetUserMessages]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_GetUserMessages]
@User_Id varchar(120) 
	
AS
BEGIN
	SET NOCOUNT ON;

    
--SELECT (select First_Name+' '+Last_Name from User_Master where User_Id=sub.Added_By) as Name,
--(select Image from User_Master where User_Id=sub.Added_By) as Image,*
--  FROM(select Added_By,
--Count(*) as msgcount from Chat_Master_User 
--where Receiver_Id in (@User_Id) and Readmsg is null group by Added_By) sub

	SELECT um.Status,(select Name from Department_Master where Dept_Id=um.Dept_Id) as Dept,
	um.User_Id,um.Image,um.First_Name+' '+um.Last_Name as Name,sub.*,number = ROW_NUMBER() OVER (ORDER BY sub.msgcount) into #Temp
	FROM(select Added_By,
	Count(*) as msgcount from Chat_Master_User 
	where Receiver_Id in (@User_Id) and Readmsg is null group by Added_By) sub
	right join User_Master um on um.User_Id=sub.Added_By
	where --um.Dept_Id=(select Dept_Id from User_Master where User_Id=@User_Id)
	um.User_Id not in (@User_Id)
	and um.Type='User'
	order by sub.msgcount desc

	create table #answer
	(
	Status varchar(max),
	Dept varchar(max),
	User_Id varchar(max),
	Image varchar(max),
	Name varchar(max),
	Added_By varchar(max),
	msgcount varchar(max),
	number varchar(120),
	Added_Date datetime
	)

	declare @i int;
	declare @data datetime;
	declare @data1 varchar(120);
	declare @data2 datetime;


set @i=0;
while(@i<(select count(*) from #Temp))
	begin
		print @i;
			select  top 1 @data=Added_Date,@data1=Added_By,@data2=max(Added_Date) from Chat_Master_User 
			where  (User_Id in (@User_Id) and Receiver_Id in (select User_Id from #Temp where number=@i+1)) 
			or (User_Id in (select User_Id from #Temp where number=@i+1) and Receiver_Id in (@User_Id))
			group by Added_By,Added_Date
			order by Added_Date desc

			insert into #answer (Status,Dept,User_Id,Image,Name,Added_By,msgcount,number,Added_Date) 
			values ((select Status from #Temp where number=@i+1),(select Dept from #Temp where number=@i+1),
			(select User_Id from #Temp where number=@i+1),(select Image from #Temp where number=@i+1),
			(select Name from #Temp where number=@i+1),(select Added_By from #Temp where number=@i+1),
			(select msgcount from #Temp where number=@i+1),(select number from #Temp where number=@i+1),
			@data)

		set @i=@i+1;
	end


	select * from #answer order by Added_Date Desc
	drop table #Temp
	drop table #answer

END

GO
/****** Object:  StoredProcedure [dbo].[proc_GetUserMsg]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_GetUserMsg]
	@User_Id varchar(120),
	@Receiver_Id varchar(120),
	@Chat_Id bigint
AS
BEGIN
	SET NOCOUNT ON;

    select (select Image from User_Master where User_Id=@User_Id )as User_Pic,
	(select Image from User_Master where User_Id=@Receiver_Id )as Receiver_Pic,* from Chat_Master_User 
	   where ((Added_By in (@User_Id) or Added_By in (@Receiver_Id)) and 
	  (Receiver_Id in(@User_Id) and User_Id in (@Receiver_Id)) or
	  (Receiver_Id in(@Receiver_Id) and User_Id in (@User_Id)))
	  and Chat_User_Id > @Chat_Id AND Added_By not in(@User_Id)
	  order by Added_Date asc

	  update Chat_Master_User set Readmsg='1' where Chat_User_Id in (select Chat_User_Id from Chat_Master_User cmu
	   where (Added_By in (@User_Id) or Added_By in (@Receiver_Id)) and 
	  (Receiver_Id in(@User_Id) and User_Id in (@Receiver_Id)) or
	  (Receiver_Id in(@Receiver_Id) and User_Id in (@User_Id)) and Chat_User_Id > @Chat_Id AND Added_By not in(@User_Id))
END


GO
/****** Object:  StoredProcedure [dbo].[Proc_Likes]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Likes]
@Post_Id varchar(max),
@User_Id varchar(120)
	
AS
BEGIN
	SET NOCOUNT ON;

	declare @data varchar(max);
	declare @dat varchar(max);

	if(@User_Id in (select * from Splitstring((select Likes from Post_Master where Post_Id=@Post_Id),',')))
		begin
			select '1';
		end
	else
		begin
			select @data=Likes from Post_Master where Post_Id=@Post_Id;
			if(@data <> '')
				begin
					set @dat=@data+','+@User_Id;
					update Post_Master set Likes=@dat where Post_Id=@Post_Id
				end
			else
				begin
					update Post_Master set Likes=@User_Id where Post_Id=@Post_Id
				end
			

		end
    
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_LoadPreviuosGrpMessages]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_LoadPreviuosGrpMessages]
	@Grp_Id varchar(120),
	@Chat_User_Id varchar(120)
AS
BEGIN
	
	SET NOCOUNT ON;

    select * from (select top 10 (select (First_Name+' '+Last_Name) from User_Master where User_Id=chg.Sender_Id)as Name,
	(select Image from User_Master where  User_Id = chg.Sender_Id) as User_Pic,* 
	from Chat_Master_Group chg
	where chg.Grp_Id in (@Grp_Id)
	and Chat_Group_Id < @Chat_User_Id
	order by chg.Added_Date desc) as obj order by Added_Date asc
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_LoadPreviuosMessages]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_LoadPreviuosMessages]
	@User_Id varchar(120),
	@Receiver_Id varchar(120),
	@Chat_User_Id varchar(120)
AS
BEGIN
	
	SET NOCOUNT ON;

    select top 10  (select Image from User_Master where User_Id=@User_Id )as User_Pic,
	(select Image from User_Master where User_Id=@Receiver_Id )as Receiver_Pic,
	(select First_Name+' '+Last_Name from User_Master where User_Id=@User_Id )as User_Name,
	(select First_Name+' '+Last_Name from User_Master where User_Id=@Receiver_Id )as Receiver_Name,
	* into #temp from Chat_Master_User cmu
	   where ((Added_By in (@User_Id) or Added_By in (@Receiver_Id)) and 
	  (Receiver_Id in(@User_Id) and User_Id in (@Receiver_Id)) or
	  (Receiver_Id in(@Receiver_Id) and User_Id in (@User_Id)))
	  and cmu.Chat_User_Id < @Chat_User_Id
	  order by cmu.Added_Date desc
	  

	  select * from #temp order by Added_Date asc

	  drop table #temp
END

GO
/****** Object:  StoredProcedure [dbo].[proc_postmessage]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_postmessage]
@Added_By varchar(120),
@Added_Date datetime,
@Post varchar(max)
	
AS
BEGIN
	
	SET NOCOUNT ON;

	declare @id int;
	insert into Post_Master (Message,Added_By,Added_Date) values(@Post,@Added_By,@Added_Date) ;
	set @id=SCOPE_IDENTITY();
	select @id,* from User_Master where User_Id=@Added_By;
	select * from Post_Master where Post_Id=@id

END

GO
/****** Object:  StoredProcedure [dbo].[proc_savedept]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_savedept]
@Name varchar(120),
@Description varchar(max),
@Added_By varchar(120),
@Added_Date datetime
	
AS
BEGIN
	
	SET NOCOUNT ON;
	insert into Department_Master (Name,Description,Added_By,Added_Date) values (@Name,@Description,@Added_By,@Added_Date)
END


GO
/****** Object:  StoredProcedure [dbo].[proc_SaveGroup]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_SaveGroup]

@Name varchar(200),
@User_Id varchar(200),
@Description varchar(max),
@Added_By varchar(120),
@Added_Date datetime
	
AS
BEGIN
	
	SET NOCOUNT ON;

    insert into Group_Master (Name,User_Id,Description,Added_By,Added_Date) 
				values (@Name,@User_Id,@Description,@Added_By,@Added_Date)
END


GO
/****** Object:  StoredProcedure [dbo].[proc_SaveGroupMessage]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[proc_SaveGroupMessage]


@Attach_Id	varchar(120),
@Note_Id	varchar(120),
@Grp_Id	varchar(120),
@Sender_Id	varchar(120),
@Message	varchar(MAX),
@Type	varchar(100),
@Added_By	varchar(120),
@Added_Date	datetime,
@Attach varchar(200)
	
AS
BEGIN
	SET NOCOUNT ON;

   insert into Chat_Master_Group(Attach_Id,Note_Id,Grp_Id,Sender_Id,Message,Type,Added_By,Added_Date,Attachment)
   values(@Attach_Id,@Note_Id,@Grp_Id,@Sender_Id,@Message,@Type,@Added_By,@Added_Date,@Attach)
END


GO
/****** Object:  StoredProcedure [dbo].[proc_SaveMessage]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_SaveMessage]

	@Attach_Id	varchar(120),
	@Note_Id	varchar(120),
	@User_Id	varchar(120),
	@Receiver_Id	varchar(120),
	@Message	varchar(MAX),
	@Type	varchar(100),
	@Added_By	varchar(120),
	@Added_Date	datetime,
	@Attach varchar(200)
	
AS
BEGIN
	SET NOCOUNT ON;

    insert into Chat_Master_User(Attach_Id,Note_Id,User_Id,Receiver_Id,Message,Type,Added_By,Added_Date,Attachment)
	values(@Attach_Id,@Note_Id,@User_Id,@Receiver_Id,@Message,@Type,@Added_By,@Added_Date,@Attach)
END


GO
/****** Object:  StoredProcedure [dbo].[proc_saveuser]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_saveuser]

@Dept_Id	varchar(120),
@First_Name	varchar(120),
@Last_Name	varchar(120),
@Designation	varchar(120),
@Username	varchar(120),
@Password	varchar(120),
@Email	varchar(80),
@Added_By	varchar(120),
@Added_Date	datetime,
@Image varchar(120)
	
AS
BEGIN
	
	SET NOCOUNT ON;
	insert into User_Master (Dept_Id,First_Name,Last_Name,Designation,Username,Password,Email,Added_By,Added_Date,Image,Type,Status) 
	values (@Dept_Id,@First_Name,@Last_Name,@Designation,@Username,@Password,@Email,@Added_By,@Added_Date,@Image,'User','Offline')
END


select * from User_Master

GO
/****** Object:  StoredProcedure [dbo].[Proc_UnLike]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_UnLike]
@Post_Id varchar(max),
@User_Id varchar(120)

AS
BEGIN
	SET NOCOUNT ON;

	declare @data varchar(max);
	declare @count int;
	declare @i int;
	declare @num varchar(max)='';
	declare @numb varchar(max)='';

	set @i=1;
	select * into #temp from Splitstring((select Likes from Post_Master where Post_Id=@Post_Id),',')
	select *,number = ROW_NUMBER() OVER (ORDER BY t.item) into #temp1 from #temp t order by t.item

	while(@i<(select count(*) from #temp))
	begin
		--print @i;
		if((select item from #temp1 where number=@i) <> 5)
			begin
				set @num=@num+(select item from #temp1 where number=@i)+',';
				print @i;
			end
		
		set @i=@i+1;

	end
	if(@num <> '')
		begin
			select @numb=SUBSTRING(@num,1,(Len(@num)-1));
		end
	else
		begin
			set @numb=@num;
		end
	select @numb;

	update Post_Master set Likes=@numb 
	where Post_Id=@Post_Id

	drop table #temp,#temp1


    
END

GO
/****** Object:  StoredProcedure [dbo].[proc_updatedept]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_updatedept]

@Name varchar(120),
@Description varchar(max),
@Modified_By varchar(120),
@Modified_Date datetime,
@Dept_Id bigint
	
AS
BEGIN
	SET NOCOUNT ON;

    update Department_Master set Name=@Name,
	Description=@Description,
	Modified_By=@Modified_By,
	Modified_Date=@Modified_Date
	where Dept_Id=@Dept_Id
END


GO
/****** Object:  StoredProcedure [dbo].[proc_UpdateGroup]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_UpdateGroup]
@Grp_Id bigint,
@Name varchar(200),
@User_Id varchar(200),
@Description varchar(max),
@Modified_By varchar(120),
@Modified_Date datetime
	
AS
BEGIN
	
	SET NOCOUNT ON;

    update Group_Master set Name=@Name,
	User_Id=@User_Id,
	Description=@Description,
	Modified_By=@Modified_By,
	Modified_Date=@Modified_Date
	where Grp_Id=@Grp_Id
END


GO
/****** Object:  StoredProcedure [dbo].[proc_updateuser]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_updateuser]
@User_Id bigint,
@Dept_Id	varchar(120),
@First_Name	varchar(120),
@Last_Name	varchar(120),
@Designation	varchar(120),
@Username	varchar(120),
@Password	varchar(120),
@Email	varchar(80),
@Modified_By	varchar(120),
@Modified_Date	datetime,
@Image varchar(200),
@Description varchar(max)
	
AS
BEGIN
	
	SET NOCOUNT ON;
	declare @imgname varchar(200);
	select @imgname=Image from User_Master where User_Id=@User_Id;
	if(@imgname = @Image)
		begin
		   update User_Master set Dept_Id=@Dept_Id,
		   First_Name=@First_Name,
		   Last_Name=@Last_Name,
		   Designation=@Designation,
		   Username=@Username,
		   Password=@Password,
		   Email=@Email,
		   Modified_By=@Modified_By,
		   Modified_Date=@Modified_Date,
		   Description=@Description
		   where User_Id=@User_Id

		   select '0'
	   end 
   else
	   begin
			   update User_Master set Dept_Id=@Dept_Id,
			   First_Name=@First_Name,
			   Last_Name=@Last_Name,
			   Designation=@Designation,
			   Username=@Username,
			   Password=@Password,
			   Email=@Email,
			   Modified_By=@Modified_By,
			   Modified_Date=@Modified_Date,
			   Image=@Image,
			   Description=@Description
			   where User_Id=@User_Id
			   select '1'
	   end
END


GO
/****** Object:  StoredProcedure [dbo].[proc_UpdateUserChat]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_UpdateUserChat]
@User_Id bigint,
@First_Name	varchar(120),
@Last_Name	varchar(120),
@Email	varchar(80),
@Modified_By	varchar(120),
@Modified_Date	datetime,
@Image varchar(200),
@Description varchar(max)
	
AS
BEGIN
	
	SET NOCOUNT ON;
	declare @imgname varchar(200);
	select @imgname=Image from User_Master where User_Id=@User_Id;
	if(@imgname = @Image or @Image = '')
		begin
		   update User_Master set 
		   First_Name=@First_Name,
		   Last_Name=@Last_Name,
		   Email=@Email,
		   Modified_By=@Modified_By,
		   Modified_Date=@Modified_Date,
		   Description=@Description
		   where User_Id=@User_Id

		   select '0'
	   end 
   else
	   begin
			   update User_Master set 
			   First_Name=@First_Name,
			   Last_Name=@Last_Name,
			   Email=@Email,
			   Modified_By=@Modified_By,
			   Modified_Date=@Modified_Date,
			   Image=@Image,
			   Description=@Description
			   where User_Id=@User_Id
			   select '1'
	   end
END

GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SplitString]
(    
      @Input NVARCHAR(MAX),
      @Character CHAR(1)
)
RETURNS @Output TABLE (
      Item NVARCHAR(1000)
)
AS
BEGIN
      DECLARE @StartIndex INT, @EndIndex INT
 
      SET @StartIndex = 1
      IF SUBSTRING(@Input, LEN(@Input) - 1, LEN(@Input)) <> @Character
      BEGIN
            SET @Input = @Input + @Character
      END
 
      WHILE CHARINDEX(@Character, @Input) > 0
      BEGIN
            SET @EndIndex = CHARINDEX(@Character, @Input)
           
            INSERT INTO @Output(Item)
            SELECT SUBSTRING(@Input, @StartIndex, @EndIndex - 1)
           
            SET @Input = SUBSTRING(@Input, @EndIndex + 1, LEN(@Input))
      END
 
      RETURN
END


GO
/****** Object:  Table [dbo].[Attachment_Master]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Attachment_Master](
	[Attach_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](120) NULL,
	[Type] [varchar](50) NULL,
	[Added_By] [varchar](120) NULL,
	[Added_Date] [datetime] NULL,
 CONSTRAINT [PK_Attachment_Master] PRIMARY KEY CLUSTERED 
(
	[Attach_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Chat_Master_Group]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Chat_Master_Group](
	[Chat_Group_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Attach_Id] [varchar](120) NULL,
	[Note_Id] [varchar](120) NULL,
	[Grp_Id] [varchar](120) NULL,
	[Sender_Id] [varchar](120) NULL,
	[Message] [varchar](max) NULL,
	[Type] [varchar](100) NULL,
	[Added_By] [varchar](120) NULL,
	[Added_Date] [datetime] NULL,
	[Modified_By] [varchar](120) NULL,
	[Modified_Date] [datetime] NULL,
	[Attachment] [varchar](200) NULL,
 CONSTRAINT [PK_Chat_Master_Group] PRIMARY KEY CLUSTERED 
(
	[Chat_Group_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Chat_Master_User]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Chat_Master_User](
	[Chat_User_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Attach_Id] [varchar](120) NULL,
	[Note_Id] [varchar](120) NULL,
	[User_Id] [varchar](120) NULL,
	[Receiver_Id] [varchar](120) NULL,
	[Message] [varchar](max) NULL,
	[Type] [varchar](100) NULL,
	[Added_By] [varchar](120) NULL,
	[Added_Date] [datetime] NULL,
	[Modified_By] [varchar](120) NULL,
	[Modified_Date] [datetime] NULL,
	[Attachment] [varchar](200) NULL,
	[Readmsg] [varchar](10) NULL,
 CONSTRAINT [PK_Chat_Master_User] PRIMARY KEY CLUSTERED 
(
	[Chat_User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Comments_Master]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Comments_Master](
	[Comment_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Post_Id] [varchar](120) NULL,
	[Comment] [varchar](max) NULL,
	[Added_By] [varchar](120) NULL,
	[Added_Date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Comment_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Department_Master]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Department_Master](
	[Dept_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](120) NULL,
	[Description] [varchar](max) NULL,
	[Added_By] [varchar](120) NULL,
	[Added_Date] [datetime] NULL,
	[Modified_By] [varchar](120) NULL,
	[Modified_Date] [datetime] NULL,
 CONSTRAINT [PK_Department_Master] PRIMARY KEY CLUSTERED 
(
	[Dept_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Group_Master]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Group_Master](
	[Grp_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NULL,
	[User_Id] [varchar](200) NULL,
	[Description] [varchar](max) NULL,
	[Added_By] [varchar](120) NULL,
	[Added_Date] [datetime] NULL,
	[Modified_By] [varchar](120) NULL,
	[Modified_Date] [datetime] NULL,
 CONSTRAINT [PK_Group_Master] PRIMARY KEY CLUSTERED 
(
	[Grp_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Note_Master]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Note_Master](
	[Note_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Subject] [varchar](120) NULL,
	[Body] [varchar](max) NULL,
	[Added_By] [varchar](120) NULL,
	[Added_Date] [datetime] NULL,
 CONSTRAINT [PK_Note_Master] PRIMARY KEY CLUSTERED 
(
	[Note_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Post_Master]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Post_Master](
	[Post_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Message] [varchar](max) NULL,
	[Added_By] [varchar](120) NULL,
	[Added_Date] [datetime] NULL,
	[Attachment] [varchar](200) NULL,
	[Likes] [varchar](max) NULL,
 CONSTRAINT [PK_Post_Master] PRIMARY KEY CLUSTERED 
(
	[Post_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User_Master]    Script Date: 10-May-18 12:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User_Master](
	[User_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Dept_Id] [varchar](120) NULL,
	[First_Name] [varchar](120) NULL,
	[Last_Name] [varchar](120) NULL,
	[Type] [varchar](20) NULL,
	[Designation] [varchar](120) NULL,
	[Username] [varchar](120) NULL,
	[Password] [varchar](120) NULL,
	[Email] [varchar](80) NULL,
	[Added_By] [varchar](120) NULL,
	[Added_Date] [datetime] NULL,
	[Modified_By] [varchar](120) NULL,
	[Modified_Date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[User_Master] ADD [Image] [varchar](200) NULL
SET ANSI_PADDING ON
ALTER TABLE [dbo].[User_Master] ADD [Description] [varchar](max) NULL
ALTER TABLE [dbo].[User_Master] ADD [Status] [varchar](120) NULL
 CONSTRAINT [PK_User_Master] PRIMARY KEY CLUSTERED 
(
	[User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Chat_Master_Group] ON 

INSERT [dbo].[Chat_Master_Group] ([Chat_Group_Id], [Attach_Id], [Note_Id], [Grp_Id], [Sender_Id], [Message], [Type], [Added_By], [Added_Date], [Modified_By], [Modified_Date], [Attachment]) VALUES (1, N'0', N'0', N'1', N'2', N'hey', N'Msg', N'2', CAST(0x0000A8CE013097E0 AS DateTime), NULL, NULL, N'')
INSERT [dbo].[Chat_Master_Group] ([Chat_Group_Id], [Attach_Id], [Note_Id], [Grp_Id], [Sender_Id], [Message], [Type], [Added_By], [Added_Date], [Modified_By], [Modified_Date], [Attachment]) VALUES (2, N'0', N'0', N'1', N'9', N'hey', N'Msg', N'9', CAST(0x0000A8CE0130B73E AS DateTime), NULL, NULL, N'')
SET IDENTITY_INSERT [dbo].[Chat_Master_Group] OFF
SET IDENTITY_INSERT [dbo].[Comments_Master] ON 

INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (1, N'144', N'Lit AF', N'9', CAST(0x0000A890012CBBDD AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (2, N'144', N'No one is commenting out Here', N'9', CAST(0x0000A890012E7DB5 AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (3, N'143', N'comment on this', N'9', CAST(0x0000A8900067EEB2 AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (4, N'140', N'qwerty', N'9', CAST(0x0000A89100D1D8D3 AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (5, N'147', N'good thought', N'9', CAST(0x0000A89100D4B03C AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (6, N'147', N'ok', N'9', CAST(0x0000A89100D57564 AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (7, N'147', N'It was really tough to pick a gift for you because you are so choosy and picky, just like me. We are so meant to be best friends! Happy birthday. ', N'9', CAST(0x0000A89100D58B92 AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (8, N'147', N'hell yeah', N'5', CAST(0x0000A89100D8FAB0 AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (9, N'143', N'asdasdas', N'9', CAST(0x0000A891000B5D59 AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (10, N'140', N'asdas', N'9', CAST(0x0000A891000B671C AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (11, N'138', N'qwerty', N'5', CAST(0x0000A89101148BE3 AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (12, N'138', N'qweqweqwqw', N'5', CAST(0x0000A89101148F86 AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (13, N'138', N'qweqwe qeqwe q qwe qwe qw qw eqw eqw eqw eqwe qwe qwe qwe', N'5', CAST(0x0000A8910114956F AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (14, N'149', N'Comments going correct', N'5', CAST(0x0000A8910057B968 AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (15, N'149', N'yes', N'9', CAST(0x0000A8910057D86C AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (16, N'150', N'its good', N'9', CAST(0x0000A891005C1CE9 AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (17, N'152', N'dsfdfdd', N'9', CAST(0x0000A8930169A91C AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (18, N'151', N'cool', N'9', CAST(0x0000A89900124536 AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (19, N'148', N'hi', N'9', CAST(0x0000A89D005FE72C AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (20, N'123', N'1223', N'9', CAST(0x0000A8A4005A3096 AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (21, N'152', N'asdasd', N'9', CAST(0x0000A8A500FC8C1A AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (22, N'151', N'wohh', N'9', CAST(0x0000A8A500FC9BA2 AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (23, N'170', N'wer', N'9', CAST(0x0000A8B200E1000B AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (24, N'154', N'bhn', N'9', CAST(0x0000A8B40131FF2A AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (25, N'175', N'dfdff', N'16', CAST(0x0000A8C100119E5E AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (26, N'193', N'nakil aurat', N'9', CAST(0x0000A8C1001358DA AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (27, N'193', N' ffbcg nlifgyyyyyyyyyyy5o7l8xjd8', N'2', CAST(0x0000A8C100138EF6 AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (28, N'193', N'esko koi to padho', N'9', CAST(0x0000A8C10013AF92 AS DateTime))
INSERT [dbo].[Comments_Master] ([Comment_Id], [Post_Id], [Comment], [Added_By], [Added_Date]) VALUES (29, N'193', N'veda veda ', N'2', CAST(0x0000A8C10013D005 AS DateTime))
SET IDENTITY_INSERT [dbo].[Comments_Master] OFF
SET IDENTITY_INSERT [dbo].[Department_Master] ON 

INSERT [dbo].[Department_Master] ([Dept_Id], [Name], [Description], [Added_By], [Added_Date], [Modified_By], [Modified_Date]) VALUES (1, N'Developer', N'Developers Group', N'Admin', CAST(0x0000A8850039C5F6 AS DateTime), NULL, NULL)
INSERT [dbo].[Department_Master] ([Dept_Id], [Name], [Description], [Added_By], [Added_Date], [Modified_By], [Modified_Date]) VALUES (2, N'Finance', N'Finance Group', N'Admin', CAST(0x0000A8850039D655 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Department_Master] OFF
SET IDENTITY_INSERT [dbo].[Group_Master] ON 

INSERT [dbo].[Group_Master] ([Grp_Id], [Name], [User_Id], [Description], [Added_By], [Added_Date], [Modified_By], [Modified_Date]) VALUES (1, N'Accutrans Developer', N'2,3,4,5,6,9,16', N'Accutrans Official Developers Group', N'Admin', CAST(0x0000A885003E0B4D AS DateTime), N'Admin', CAST(0x0000A887006065AB AS DateTime))
INSERT [dbo].[Group_Master] ([Grp_Id], [Name], [User_Id], [Description], [Added_By], [Added_Date], [Modified_By], [Modified_Date]) VALUES (2, N'Spartans Online', N'2,3,4,5,6,9', N'For any issue chat with us', N'Admin', CAST(0x0000A8850054598E AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Group_Master] OFF
SET IDENTITY_INSERT [dbo].[User_Master] ON 

INSERT [dbo].[User_Master] ([User_Id], [Dept_Id], [First_Name], [Last_Name], [Type], [Designation], [Username], [Password], [Email], [Added_By], [Added_Date], [Modified_By], [Modified_Date], [Image], [Description], [Status]) VALUES (2, N'1', N'Rupali', N'Patil', N'User', N'Sr.Developer', N'rupali', N'123', N'rupali@mailinator.com', N'Admin', CAST(0x0000A885003A1AFA AS DateTime), N'Admin', CAST(0x0000A8CE0116B199 AS DateTime), N'ferrari-94c3512cee1a4dbfb9e96fcc8210ff58.jpg', N'Senior Developer in the company', N'Online')
INSERT [dbo].[User_Master] ([User_Id], [Dept_Id], [First_Name], [Last_Name], [Type], [Designation], [Username], [Password], [Email], [Added_By], [Added_Date], [Modified_By], [Modified_Date], [Image], [Description], [Status]) VALUES (3, N'2', N'Chaitali', N'Gunjal', N'User', N'Developer', N'chaitali', N'test', N'chaitali@mailinator.com', N'Admin', CAST(0x0000A885003BB8CE AS DateTime), N'Admin', CAST(0x0000A8CE0116220A AS DateTime), N'alfa_romeo-4e2762e86cff4486a70438616219dafa.png', N'Developer in the company', N'Offline')
INSERT [dbo].[User_Master] ([User_Id], [Dept_Id], [First_Name], [Last_Name], [Type], [Designation], [Username], [Password], [Email], [Added_By], [Added_Date], [Modified_By], [Modified_Date], [Image], [Description], [Status]) VALUES (4, N'1', N'Rasika', N'Sutar', N'User', N'Developer', N'rasika', N'123', N'rasika@mailinator.com', N'Admin', CAST(0x0000A885003BDF9B AS DateTime), N'Admin', CAST(0x0000A8CE0117532D AS DateTime), N'volvo-68b39a9a7c804a3ebe9d7b77317ddc4c.jpg', N'Developer in the company', N'Offline')
INSERT [dbo].[User_Master] ([User_Id], [Dept_Id], [First_Name], [Last_Name], [Type], [Designation], [Username], [Password], [Email], [Added_By], [Added_Date], [Modified_By], [Modified_Date], [Image], [Description], [Status]) VALUES (5, N'1', N'Ali', N'Sayed', N'User', N'Developer', N'ali', N'123', N'ali@mailinator.com', N'Admin', CAST(0x0000A885003BFBD3 AS DateTime), N'Admin', CAST(0x0000A8CE01158ECE AS DateTime), N'mustang-2c0a924ef2cb433cbe7992ee9fb7ef4b.jpg', N'Developer in the company', N'Offline')
INSERT [dbo].[User_Master] ([User_Id], [Dept_Id], [First_Name], [Last_Name], [Type], [Designation], [Username], [Password], [Email], [Added_By], [Added_Date], [Modified_By], [Modified_Date], [Image], [Description], [Status]) VALUES (6, N'1', N'Abdul', N'Samad', N'User', N'Developer', N'abdul', N'123', N'abdul@mailinator.com', N'Admin', CAST(0x0000A885003C273D AS DateTime), N'Admin', CAST(0x0000A8CE011521F8 AS DateTime), N'mm-7a0d45f317614ffeb409d6be25824ad8.jpg', N'Developer in the company', N'Offline')
INSERT [dbo].[User_Master] ([User_Id], [Dept_Id], [First_Name], [Last_Name], [Type], [Designation], [Username], [Password], [Email], [Added_By], [Added_Date], [Modified_By], [Modified_Date], [Image], [Description], [Status]) VALUES (9, N'1', N'Amit Hemant', N'Sable', N'User', N'Sr.Developer', N'amit', N'123', N'amit@mailinator.com', N'Admin', CAST(0x0000A88501180696 AS DateTime), N'Admin', CAST(0x0000A8CF00D5F233 AS DateTime), N'amit-78dc4ba3f1c54664ae2f69e36d6705b5.jpg', N'Senior Developer in the company', N'Online')
INSERT [dbo].[User_Master] ([User_Id], [Dept_Id], [First_Name], [Last_Name], [Type], [Designation], [Username], [Password], [Email], [Added_By], [Added_Date], [Modified_By], [Modified_Date], [Image], [Description], [Status]) VALUES (16, N'1', N'Kaustubh', N'Jadhav', N'User', N'SEO', N'kaustubh', N'123', N'kj@mailinator.com', N'Admin', CAST(0x0000A887005DB105 AS DateTime), N'Admin', CAST(0x0000A8CE01140ACC AS DateTime), N'car_logo_PNG1641-6c8c557193364eb4aa6a750153441c60.png', N'Handles the SEO Management for the Websites', N'Offline')
INSERT [dbo].[User_Master] ([User_Id], [Dept_Id], [First_Name], [Last_Name], [Type], [Designation], [Username], [Password], [Email], [Added_By], [Added_Date], [Modified_By], [Modified_Date], [Image], [Description], [Status]) VALUES (19, NULL, N'Admin', N'Admin', N'Admin', N'Admin', N'Admin', N'Admin', NULL, N'Admin', CAST(0x0000000000000000 AS DateTime), NULL, NULL, NULL, NULL, N'Offline')
INSERT [dbo].[User_Master] ([User_Id], [Dept_Id], [First_Name], [Last_Name], [Type], [Designation], [Username], [Password], [Email], [Added_By], [Added_Date], [Modified_By], [Modified_Date], [Image], [Description], [Status]) VALUES (21, NULL, N'Asif', NULL, N'Admin', NULL, N'asif@123', N'asif@123', NULL, N'Admin', CAST(0x0000A8B3011D8EE6 AS DateTime), NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[User_Master] OFF
USE [master]
GO
ALTER DATABASE [ashwanisri_] SET  READ_WRITE 
GO
