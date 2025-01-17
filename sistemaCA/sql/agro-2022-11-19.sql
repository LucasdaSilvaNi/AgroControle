USE [master]
GO
/****** Object:  Database [dbsysca]    Script Date: 19/11/2022 20:04:01 ******/
CREATE DATABASE [dbsysca]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbsysca', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SERVIDORBANCO\MSSQL\DATA\dbsysca.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'dbsysca_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SERVIDORBANCO\MSSQL\DATA\dbsysca_log.ldf' , SIZE = 1088KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [dbsysca] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbsysca].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbsysca] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbsysca] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbsysca] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbsysca] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbsysca] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbsysca] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [dbsysca] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbsysca] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbsysca] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbsysca] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbsysca] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbsysca] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbsysca] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbsysca] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbsysca] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dbsysca] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbsysca] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbsysca] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbsysca] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbsysca] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbsysca] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbsysca] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbsysca] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [dbsysca] SET  MULTI_USER 
GO
ALTER DATABASE [dbsysca] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbsysca] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbsysca] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbsysca] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [dbsysca] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dbsysca] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'dbsysca', N'ON'
GO
ALTER DATABASE [dbsysca] SET QUERY_STORE = OFF
GO
USE [dbsysca]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 19/11/2022 20:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ----------------------------
-- Function structure for [fn_diagramobjects]
-- ----------------------------

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	

GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 19/11/2022 20:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblaplicacao]    Script Date: 19/11/2022 20:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblaplicacao](
	[id_aplicacao] [int] IDENTITY(1,1) NOT NULL,
	[data_cadastro] [date] NOT NULL,
	[status] [varchar](15) NOT NULL,
	[data_aplicacao] [date] NULL,
	[areaaplicada] [float] NULL,
	[obs] [varchar](200) NULL,
	[descricao] [varchar](80) NULL,
	[id_talhao] [int] NULL,
	[id_safra] [int] NULL,
	[id_ben] [int] NULL,
	[id_funcionario] [int] NULL,
	[tipoaplicaco] [varchar](50) NULL,
 CONSTRAINT [PK_tblaplicacao] PRIMARY KEY CLUSTERED 
(
	[id_aplicacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblbens]    Script Date: 19/11/2022 20:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblbens](
	[id_ben] [int] IDENTITY(1,1) NOT NULL,
	[descricao] [varchar](120) NOT NULL,
	[tipoben] [varchar](80) NOT NULL,
	[codigoControle] [varchar](10) NULL,
	[data_aquisicao] [date] NULL,
	[preco_aquisicao] [real] NULL,
	[horimetro_inicial] [int] NULL,
	[hodometro_inicial] [int] NULL,
	[placa] [varchar](8) NULL,
 CONSTRAINT [PK_tblbens] PRIMARY KEY CLUSTERED 
(
	[id_ben] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblcultura]    Script Date: 19/11/2022 20:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblcultura](
	[id_cultura] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](80) NULL,
 CONSTRAINT [PK_tblcultura] PRIMARY KEY CLUSTERED 
(
	[id_cultura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblfornecedor]    Script Date: 19/11/2022 20:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblfornecedor](
	[id_fornecedor] [int] IDENTITY(1,1) NOT NULL,
	[nomefatasia] [varchar](120) NULL,
	[razaosocial] [varchar](120) NULL,
	[cpf] [varchar](15) NULL,
	[cnpj] [varchar](15) NULL,
	[endereco] [varchar](120) NULL,
	[cidade] [varchar](120) NULL,
	[fone] [varchar](15) NULL,
	[email] [varchar](120) NULL,
	[obs] [varchar](150) NULL,
	[ie] [varchar](13) NULL,
 CONSTRAINT [PK_tblfornecedor] PRIMARY KEY CLUSTERED 
(
	[id_fornecedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblfuncionario]    Script Date: 19/11/2022 20:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblfuncionario](
	[id_funcionario] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](80) NOT NULL,
	[funcao] [varchar](80) NULL,
	[ctps] [varchar](15) NULL,
	[data_admissao] [date] NULL,
	[renumeracao_mensal] [real] NULL,
	[endere] [varchar](80) NULL,
	[bairro] [varchar](80) NULL,
	[telefone] [varchar](15) NULL,
	[email] [varchar](80) NULL,
	[rg] [varchar](15) NULL,
	[cpf] [varchar](15) NULL,
	[obs] [varchar](180) NULL,
	[celular] [varchar](15) NULL,
	[sobrenome] [varchar](80) NULL,
	[sexo] [nchar](2) NULL,
 CONSTRAINT [PK_tblfuncionario] PRIMARY KEY CLUSTERED 
(
	[id_funcionario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblitenrevisao]    Script Date: 19/11/2022 20:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblitenrevisao](
	[id_itenrevisao] [int] IDENTITY(1,1) NOT NULL,
	[preco] [real] NULL,
	[id_produtos] [int] NULL,
	[id_revisao] [int] NULL,
 CONSTRAINT [PK_tbintenrevisao] PRIMARY KEY CLUSTERED 
(
	[id_itenrevisao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblproduto]    Script Date: 19/11/2022 20:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblproduto](
	[id_produto] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](80) NOT NULL,
	[descricao] [varchar](120) NULL,
	[unidade_medida] [varchar](2) NULL,
	[id_tipoproduto] [int] NOT NULL,
 CONSTRAINT [PK_tblproduto] PRIMARY KEY CLUSTERED 
(
	[id_produto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblprodutosaplicado]    Script Date: 19/11/2022 20:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblprodutosaplicado](
	[id_produtosaplicado] [int] IDENTITY(1,1) NOT NULL,
	[quantidade] [int] NOT NULL,
	[preco] [real] NULL,
	[id_produto] [int] NOT NULL,
	[id_aplicacao] [int] NULL,
 CONSTRAINT [PK_tblprodutosaplicado] PRIMARY KEY CLUSTERED 
(
	[id_produtosaplicado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblrevisaofuturas]    Script Date: 19/11/2022 20:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblrevisaofuturas](
	[id_revisao] [int] IDENTITY(1,1) NOT NULL,
	[motivo] [varchar](120) NOT NULL,
	[data_cadastro] [date] NULL,
	[data_revisao] [date] NULL,
	[status] [varchar](12) NULL,
	[id_ben] [int] NOT NULL,
	[id_safra] [int] NOT NULL,
 CONSTRAINT [PK_tblrevisaofuturas] PRIMARY KEY CLUSTERED 
(
	[id_revisao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblsafra]    Script Date: 19/11/2022 20:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblsafra](
	[id_safra] [int] IDENTITY(1,1) NOT NULL,
	[obs] [varchar](150) NULL,
	[status] [varchar](15) NULL,
	[id_cultura] [int] NULL,
	[dataincio] [date] NOT NULL,
	[descricao] [varchar](80) NULL,
	[datafechamento] [date] NULL,
 CONSTRAINT [PK_tblsafra] PRIMARY KEY CLUSTERED 
(
	[id_safra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbltalhao]    Script Date: 19/11/2022 20:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbltalhao](
	[id_talhao] [int] IDENTITY(1,1) NOT NULL,
	[descricao] [varchar](80) NOT NULL,
	[localizacao] [varchar](80) NOT NULL,
	[tamanho] [float] NULL,
	[obs] [varchar](150) NULL,
	[sistemaCutivo] [varchar](80) NULL,
 CONSTRAINT [PK_tbltalao] PRIMARY KEY CLUSTERED 
(
	[id_talhao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbltipoproduto]    Script Date: 19/11/2022 20:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbltipoproduto](
	[id_tipoproduto] [int] IDENTITY(1,1) NOT NULL,
	[descicao] [varchar](80) NULL,
 CONSTRAINT [PK_tbltipoproduto] PRIMARY KEY CLUSTERED 
(
	[id_tipoproduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblusuario]    Script Date: 19/11/2022 20:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblusuario](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[login] [varchar](80) NOT NULL,
	[senha] [varchar](30) NOT NULL,
	[id_funcionario] [int] NOT NULL,
 CONSTRAINT [Pk_tblusuario] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblfuncionario] ON 

INSERT [dbo].[tblfuncionario] ([id_funcionario], [nome], [funcao], [ctps], [data_admissao], [renumeracao_mensal], [endere], [bairro], [telefone], [email], [rg], [cpf], [obs], [celular], [sobrenome], [sexo]) VALUES (1, N'Eduardo', N'Analista de Ti', N'15458785', CAST(N'2012-01-11' AS Date), 1500, N'545345345', N'rua dourados', N'6599463782', N'edu.avila@gmail.com', N'154878565', N'34234', N'asdsadasdasdasdasdas', N'32432432', N'avila', NULL)
INSERT [dbo].[tblfuncionario] ([id_funcionario], [nome], [funcao], [ctps], [data_admissao], [renumeracao_mensal], [endere], [bairro], [telefone], [email], [rg], [cpf], [obs], [celular], [sobrenome], [sexo]) VALUES (18, N'Anantan ', N'sadsadasdas', N'2342343242', CAST(N'2013-02-22' AS Date), 3.423432E+07, N'sdadasdas', N'rua sdahdsi', N'32432423', N'saddasdsadas', N'32432432', N'34324234', N'asdasdasdas', N'23432432', N'biba', N'M ')
INSERT [dbo].[tblfuncionario] ([id_funcionario], [nome], [funcao], [ctps], [data_admissao], [renumeracao_mensal], [endere], [bairro], [telefone], [email], [rg], [cpf], [obs], [celular], [sobrenome], [sexo]) VALUES (19, N'matheus ', N'sdasdasd', N'234324', CAST(N'2013-02-11' AS Date), 2.343243E+07, N'dscsdfasdas', N'dasdhaushduah', N'32432432', N'sdsadsadas', N'2343242', N'234324324', N'asdasdasdasda', N'234324', N'pessoa', N'M ')
INSERT [dbo].[tblfuncionario] ([id_funcionario], [nome], [funcao], [ctps], [data_admissao], [renumeracao_mensal], [endere], [bairro], [telefone], [email], [rg], [cpf], [obs], [celular], [sobrenome], [sexo]) VALUES (20, N'Lucas', N'Analista', N'', CAST(N'2013-02-22' AS Date), 1000, N'', N'', N'', N'', N'', N'46941692898', N'', N'', N'da Silva NIshikawara', NULL)
SET IDENTITY_INSERT [dbo].[tblfuncionario] OFF
GO
SET IDENTITY_INSERT [dbo].[tblproduto] ON 

INSERT [dbo].[tblproduto] ([id_produto], [nome], [descricao], [unidade_medida], [id_tipoproduto]) VALUES (1, N'sojadasd', N'', N'sc', 1)
INSERT [dbo].[tblproduto] ([id_produto], [nome], [descricao], [unidade_medida], [id_tipoproduto]) VALUES (3, N'parafuso', N'parafuso de rosca fina', N'pc', 1)
INSERT [dbo].[tblproduto] ([id_produto], [nome], [descricao], [unidade_medida], [id_tipoproduto]) VALUES (4, N'asuidhasidhasi', N'asidhasihdaiu', N'ml', 1)
SET IDENTITY_INSERT [dbo].[tblproduto] OFF
GO
SET IDENTITY_INSERT [dbo].[tbltipoproduto] ON 

INSERT [dbo].[tbltipoproduto] ([id_tipoproduto], [descicao]) VALUES (1, N'graão')
SET IDENTITY_INSERT [dbo].[tbltipoproduto] OFF
GO
SET IDENTITY_INSERT [dbo].[tblusuario] ON 

INSERT [dbo].[tblusuario] ([id_usuario], [login], [senha], [id_funcionario]) VALUES (1, N'admin', N'admin', 1)
INSERT [dbo].[tblusuario] ([id_usuario], [login], [senha], [id_funcionario]) VALUES (2, N'admin2', N'veralucia', 1)
SET IDENTITY_INSERT [dbo].[tblusuario] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__sysdiagr__532EC15436DCBEB9]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[sysdiagrams] ADD UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__tblaplic__DCE6A0B7E822DCF5]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tblaplicacao] ADD UNIQUE NONCLUSTERED 
(
	[id_aplicacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_tblaplicacao]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tblaplicacao] ADD  CONSTRAINT [UQ_tblaplicacao] UNIQUE NONCLUSTERED 
(
	[id_aplicacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__tblbens__D507662744C3AA4D]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tblbens] ADD UNIQUE NONCLUSTERED 
(
	[id_ben] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_tblbens]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tblbens] ADD  CONSTRAINT [UQ_tblbens] UNIQUE NONCLUSTERED 
(
	[id_ben] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__tblforne__6C47709325AE3581]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tblfornecedor] ADD UNIQUE NONCLUSTERED 
(
	[id_fornecedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_tblforncedor]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tblfornecedor] ADD  CONSTRAINT [UQ_tblforncedor] UNIQUE NONCLUSTERED 
(
	[id_fornecedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__tblfunci__6FBD69C5AD5113D4]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tblfuncionario] ADD UNIQUE NONCLUSTERED 
(
	[id_funcionario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_tblfuncionario]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tblfuncionario] ADD  CONSTRAINT [UQ_tblfuncionario] UNIQUE NONCLUSTERED 
(
	[id_funcionario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__tblitenr__FFEAE7DF029DFA58]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tblitenrevisao] ADD UNIQUE NONCLUSTERED 
(
	[id_itenrevisao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_tblitenrevisao]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tblitenrevisao] ADD  CONSTRAINT [UQ_tblitenrevisao] UNIQUE NONCLUSTERED 
(
	[id_itenrevisao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__tblprodu__BA38A6B94CEE4822]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tblproduto] ADD UNIQUE NONCLUSTERED 
(
	[id_produto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_tblproduto]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tblproduto] ADD  CONSTRAINT [UQ_tblproduto] UNIQUE NONCLUSTERED 
(
	[id_produto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__tblprodu__1270DCE7295AFB3B]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tblprodutosaplicado] ADD UNIQUE NONCLUSTERED 
(
	[id_produtosaplicado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_tblprodutosaplicado]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tblprodutosaplicado] ADD  CONSTRAINT [UQ_tblprodutosaplicado] UNIQUE NONCLUSTERED 
(
	[id_produtosaplicado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__tblrevis__901C08C17C7890DB]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tblrevisaofuturas] ADD UNIQUE NONCLUSTERED 
(
	[id_revisao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_tblrevisaofuturas]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tblrevisaofuturas] ADD  CONSTRAINT [UQ_tblrevisaofuturas] UNIQUE NONCLUSTERED 
(
	[id_revisao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__tbltipop__ECD075FD4BCD5BAE]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tbltipoproduto] ADD UNIQUE NONCLUSTERED 
(
	[id_tipoproduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_tbltipoproduto]    Script Date: 19/11/2022 20:04:05 ******/
ALTER TABLE [dbo].[tbltipoproduto] ADD  CONSTRAINT [UQ_tbltipoproduto] UNIQUE NONCLUSTERED 
(
	[id_tipoproduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblaplicacao]  WITH CHECK ADD FOREIGN KEY([id_ben])
REFERENCES [dbo].[tblbens] ([id_ben])
GO
ALTER TABLE [dbo].[tblaplicacao]  WITH CHECK ADD FOREIGN KEY([id_funcionario])
REFERENCES [dbo].[tblfuncionario] ([id_funcionario])
GO
ALTER TABLE [dbo].[tblaplicacao]  WITH CHECK ADD FOREIGN KEY([id_safra])
REFERENCES [dbo].[tblsafra] ([id_safra])
GO
ALTER TABLE [dbo].[tblaplicacao]  WITH CHECK ADD FOREIGN KEY([id_talhao])
REFERENCES [dbo].[tbltalhao] ([id_talhao])
GO
ALTER TABLE [dbo].[tblaplicacao]  WITH CHECK ADD  CONSTRAINT [FK_tblaplicacao_tblbens] FOREIGN KEY([id_ben])
REFERENCES [dbo].[tblbens] ([id_ben])
GO
ALTER TABLE [dbo].[tblaplicacao] CHECK CONSTRAINT [FK_tblaplicacao_tblbens]
GO
ALTER TABLE [dbo].[tblaplicacao]  WITH CHECK ADD  CONSTRAINT [FK_tblaplicacao_tblfuncionario] FOREIGN KEY([id_funcionario])
REFERENCES [dbo].[tblfuncionario] ([id_funcionario])
GO
ALTER TABLE [dbo].[tblaplicacao] CHECK CONSTRAINT [FK_tblaplicacao_tblfuncionario]
GO
ALTER TABLE [dbo].[tblaplicacao]  WITH CHECK ADD  CONSTRAINT [FK_tblaplicacao_tblsafra] FOREIGN KEY([id_safra])
REFERENCES [dbo].[tblsafra] ([id_safra])
GO
ALTER TABLE [dbo].[tblaplicacao] CHECK CONSTRAINT [FK_tblaplicacao_tblsafra]
GO
ALTER TABLE [dbo].[tblaplicacao]  WITH CHECK ADD  CONSTRAINT [FK_tblaplicacao_tbltalhao] FOREIGN KEY([id_talhao])
REFERENCES [dbo].[tbltalhao] ([id_talhao])
GO
ALTER TABLE [dbo].[tblaplicacao] CHECK CONSTRAINT [FK_tblaplicacao_tbltalhao]
GO
ALTER TABLE [dbo].[tblitenrevisao]  WITH CHECK ADD  CONSTRAINT [FK_tblintenrevisao_tblprodutos] FOREIGN KEY([id_produtos])
REFERENCES [dbo].[tblproduto] ([id_produto])
GO
ALTER TABLE [dbo].[tblitenrevisao] CHECK CONSTRAINT [FK_tblintenrevisao_tblprodutos]
GO
ALTER TABLE [dbo].[tblitenrevisao]  WITH CHECK ADD  CONSTRAINT [FK_tblintenrevisao_tblrevisaofuturas] FOREIGN KEY([id_revisao])
REFERENCES [dbo].[tblrevisaofuturas] ([id_revisao])
GO
ALTER TABLE [dbo].[tblitenrevisao] CHECK CONSTRAINT [FK_tblintenrevisao_tblrevisaofuturas]
GO
ALTER TABLE [dbo].[tblproduto]  WITH CHECK ADD FOREIGN KEY([id_tipoproduto])
REFERENCES [dbo].[tbltipoproduto] ([id_tipoproduto])
GO
ALTER TABLE [dbo].[tblproduto]  WITH CHECK ADD  CONSTRAINT [FK_tblproduto_tbltipoproduto] FOREIGN KEY([id_tipoproduto])
REFERENCES [dbo].[tbltipoproduto] ([id_tipoproduto])
GO
ALTER TABLE [dbo].[tblproduto] CHECK CONSTRAINT [FK_tblproduto_tbltipoproduto]
GO
ALTER TABLE [dbo].[tblprodutosaplicado]  WITH CHECK ADD FOREIGN KEY([id_produto])
REFERENCES [dbo].[tblproduto] ([id_produto])
GO
ALTER TABLE [dbo].[tblprodutosaplicado]  WITH CHECK ADD  CONSTRAINT [FK_tblprodutosaplicado_tblaplicacao] FOREIGN KEY([id_aplicacao])
REFERENCES [dbo].[tblaplicacao] ([id_aplicacao])
GO
ALTER TABLE [dbo].[tblprodutosaplicado] CHECK CONSTRAINT [FK_tblprodutosaplicado_tblaplicacao]
GO
ALTER TABLE [dbo].[tblprodutosaplicado]  WITH CHECK ADD  CONSTRAINT [FK_tblprodutosaplicado_tblproduto] FOREIGN KEY([id_produto])
REFERENCES [dbo].[tblproduto] ([id_produto])
GO
ALTER TABLE [dbo].[tblprodutosaplicado] CHECK CONSTRAINT [FK_tblprodutosaplicado_tblproduto]
GO
ALTER TABLE [dbo].[tblrevisaofuturas]  WITH CHECK ADD FOREIGN KEY([id_ben])
REFERENCES [dbo].[tblbens] ([id_ben])
GO
ALTER TABLE [dbo].[tblrevisaofuturas]  WITH CHECK ADD FOREIGN KEY([id_safra])
REFERENCES [dbo].[tblsafra] ([id_safra])
GO
ALTER TABLE [dbo].[tblrevisaofuturas]  WITH CHECK ADD  CONSTRAINT [FK_tblrevisaofuturas_tblbens] FOREIGN KEY([id_ben])
REFERENCES [dbo].[tblbens] ([id_ben])
GO
ALTER TABLE [dbo].[tblrevisaofuturas] CHECK CONSTRAINT [FK_tblrevisaofuturas_tblbens]
GO
ALTER TABLE [dbo].[tblrevisaofuturas]  WITH CHECK ADD  CONSTRAINT [Fk_tblrevisaofuturas_tblsafra] FOREIGN KEY([id_safra])
REFERENCES [dbo].[tblsafra] ([id_safra])
GO
ALTER TABLE [dbo].[tblrevisaofuturas] CHECK CONSTRAINT [Fk_tblrevisaofuturas_tblsafra]
GO
ALTER TABLE [dbo].[tblsafra]  WITH CHECK ADD FOREIGN KEY([id_cultura])
REFERENCES [dbo].[tblcultura] ([id_cultura])
GO
ALTER TABLE [dbo].[tblsafra]  WITH CHECK ADD  CONSTRAINT [FK_tblsafra_tblcultura] FOREIGN KEY([id_cultura])
REFERENCES [dbo].[tblcultura] ([id_cultura])
GO
ALTER TABLE [dbo].[tblsafra] CHECK CONSTRAINT [FK_tblsafra_tblcultura]
GO
ALTER TABLE [dbo].[tblusuario]  WITH CHECK ADD FOREIGN KEY([id_funcionario])
REFERENCES [dbo].[tblfuncionario] ([id_funcionario])
GO
/****** Object:  StoredProcedure [dbo].[psListarSafra]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[psListarSafra]
	
AS
BEGIN
	Select id_safra,descricao,dataincio,datafechamento,id_cultura,[status],obs	 From tblsafra 
END

GO
/****** Object:  StoredProcedure [dbo].[psVisualizarSafra]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[psVisualizarSafra]

	@id_safra int


AS
Begin

	Select id_safra,descricao,dataincio,datafechamento,id_cultura,[status],obs from tblsafra where id_safra = @id_safra


end
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ----------------------------
-- Procedure structure for [sp_alterdiagram]
-- ----------------------------

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	

GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ----------------------------
-- Procedure structure for [sp_creatediagram]
-- ----------------------------

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	

GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ----------------------------
-- Procedure structure for [sp_dropdiagram]
-- ----------------------------

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	

GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ----------------------------
-- Procedure structure for [sp_helpdiagramdefinition]
-- ----------------------------

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	

GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ----------------------------
-- Procedure structure for [sp_helpdiagrams]
-- ----------------------------

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	

GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ----------------------------
-- Procedure structure for [sp_renamediagram]
-- ----------------------------

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	

GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ----------------------------
-- Procedure structure for [sp_upgraddiagrams]
-- ----------------------------

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	

GO
/****** Object:  StoredProcedure [dbo].[spAlterarFuncionario]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[spAlterarFuncionario]
	
	@idfuncionario int,
	@nome varchar(80),
	@funcao	varchar(80),
	@ctps varchar(15),
	@renumeracao real,
	@endere varchar(80),
	@bairro varchar(80),
	@telefone varchar(15),
	@email varchar(80),
	@rg varchar(15),
	@cpf varchar(15),
	@obs varchar(180),
	@celular varchar(15),
	@sobrenome varchar(80),
	@sexo nchar(2)


AS
BEGIN
	update tblfuncionario set nome = @nome ,funcao = @funcao,ctps = @ctps, renumeracao_mensal = @renumeracao,endere =@endere,
	bairro = @bairro,telefone = @telefone,email = @email,rg = @rg, cpf = @cpf, obs = @obs,celular = @celular,sobrenome = @sobrenome, sexo = @sexo where id_funcionario = @idfuncionario
END
GO
/****** Object:  StoredProcedure [dbo].[spAlterarProduto]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAlterarProduto]
	@idproduto int,
	@nome varchar(80),
	@decricao varchar(120),
	@unidade_medida varchar(2),
	@Idtipo_produto int
	
AS
BEGIN
	update tblproduto set  nome = @nome ,descricao = @decricao , unidade_medida = @unidade_medida,id_tipoproduto = @Idtipo_produto where id_produto = @idproduto
END

GO
/****** Object:  StoredProcedure [dbo].[spAtualizarSafra]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAtualizarSafra]
	@idsafra int,
	@descricao varchar(80),
	@status  varchar(15),
	@obs varchar(150),
	@dataincio date,
	@id_cultura int,
	@datafechamento date
AS
BEGIN
	update tblsafra set descricao =@descricao ,[status]=@status,obs=@obs,dataincio= @dataincio,id_cultura=@id_cultura,datafechamento=@datafechamento where id_safra = @idsafra
END
GO
/****** Object:  StoredProcedure [dbo].[spCadastarProduto]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
CREATE PROCEDURE [dbo].[spCadastarProduto]
	@nome varchar(80),
	@descricao varchar(120),
	@unidade_medida varchar(2),
	@id_tipoproduto int
AS
BEGIN
	INSERT INTO tblproduto (nome,descricao,unidade_medida,id_tipoproduto) values (@nome,@descricao,@unidade_medida,@id_tipoproduto)
END

GO
/****** Object:  StoredProcedure [dbo].[spCadastrarSafra]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCadastrarSafra]
	@descricao varchar(80),
	@status  varchar(15),
	@obs varchar(150),
	@dataincio date,
	@id_cultura int,
	@datafechamento date
AS
BEGIN
	insert into tblsafra (descricao,[status],obs,dataincio,id_cultura,datafechamento) values (@descricao,@status,@obs,@dataincio,@id_cultura,@datafechamento)
END

GO
/****** Object:  StoredProcedure [dbo].[spDeletarFuncionario]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[spDeletarFuncionario]
	@idfuncionario int 
AS
BEGIN
	Delete from tblfuncionario where @idfuncionario = id_funcionario
END
GO
/****** Object:  StoredProcedure [dbo].[spDeletarProduto]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeletarProduto]
	@idproduto int 
AS
BEGIN
	Delete from tblproduto where id_produto = @idproduto
END

GO
/****** Object:  StoredProcedure [dbo].[spDeletarSafra]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeletarSafra]
	@id_safra int
	
AS
BEGIN
	Delete from tblsafra where id_safra = @id_safra 
END
GO
/****** Object:  StoredProcedure [dbo].[spListaProduto]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListaProduto]
	
AS
BEGIN
	SELECT id_produto,nome,descricao,unidade_medida,id_tipoproduto FROM tblproduto
END

GO
/****** Object:  StoredProcedure [dbo].[spListarTalhao]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spListarTalhao]


AS
BEGIN
	select * from tbltalhao 
END

GO
/****** Object:  StoredProcedure [dbo].[spListarTipoCultura]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListarTipoCultura]
	
	
AS
BEGIN
	Select * from tblcultura
END
GO
/****** Object:  StoredProcedure [dbo].[spListatipoProduto]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListatipoProduto]
	
AS
BEGIN
	SELECT * FROM tbltipoproduto
END

GO
/****** Object:  StoredProcedure [dbo].[spPesqiosaTipoCultura]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPesqiosaTipoCultura]
	@nome varchar(80)
	
AS
BEGIN
	Select * from tblcultura where nome like '%'+@nome+'%'
END
GO
/****** Object:  StoredProcedure [dbo].[spPesquisaFunCPF]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPesquisaFunCPF]
	@descricao varchar(15)
AS
BEGIN
	SELECT * FROM tblfuncionario where cpf like '%'+@descricao+'%'
END

GO
/****** Object:  StoredProcedure [dbo].[spPesquisaFunId]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPesquisaFunId]
	@descricao int
AS
BEGIN
	SELECT * FROM tblfuncionario where id_funcionario = @descricao
END

GO
/****** Object:  StoredProcedure [dbo].[spPesquisaFunNome]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPesquisaFunNome]
	@descricao varchar(80)
AS
BEGIN
	SELECT * FROM tblfuncionario where nome like '%'+@descricao+'%'
END

GO
/****** Object:  StoredProcedure [dbo].[spPesquisaTipoproduto]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPesquisaTipoproduto]
	@descricao varchar(80)
AS
BEGIN
	SELECT * FROM tbltipoproduto where descicao like '@descricao%'
END

GO
/****** Object:  StoredProcedure [dbo].[spVisualizarFuncionario]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[spVisualizarFuncionario]
	@idfuncionario int 
AS
BEGIN
	select * from tblfuncionario where id_funcionario = @idfuncionario
END

GO
/****** Object:  StoredProcedure [dbo].[spVisualizarProduto]    Script Date: 19/11/2022 20:04:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spVisualizarProduto]
	@idproduto int 
AS
BEGIN
	select * from tblproduto where id_produto = @idproduto
END

GO
USE [master]
GO
ALTER DATABASE [dbsysca] SET  READ_WRITE 
GO
