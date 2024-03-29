USE [LBD]
GO
/****** Object:  UserDefinedFunction [dbo].[cpEstandar]    Script Date: 02/11/2019 09:02:10 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[cpEstandar]
(
@cp varchar(5)
)
returns varchar(10)
as
begin
declare @cpEstandar varchar(10)
set @cpEstandar=(case len(@cpEstandar) when 1 then '0000'+@cpEstandar
									   when 2 then '000'+@cpEstandar
									   when 3 then '0'+@cpEstandar
									   when 4 then '0'+@cpEstandar
									   else
									   @cpEstandar
				end)
return @cpEstandar
end;
GO
/****** Object:  Table [dbo].[ciudad]    Script Date: 02/11/2019 09:02:10 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ciudad](
	[idciudad] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](max) NOT NULL,
	[idestado] [int] NOT NULL,
 CONSTRAINT [pk_idciudad] PRIMARY KEY CLUSTERED 
(
	[idciudad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[estado]    Script Date: 02/11/2019 09:02:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[estado](
	[idestado] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](max) NOT NULL,
 CONSTRAINT [pk_idestado] PRIMARY KEY CLUSTERED 
(
	[idestado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[estados_ciudades]    Script Date: 02/11/2019 09:02:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[estados_ciudades]
as
select c.nombre as ciudad,e.nombre as estado
from ciudad c
inner join estado e on c.idestado=e.idestado;
GO
/****** Object:  Table [dbo].[colonia]    Script Date: 02/11/2019 09:02:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[colonia](
	[idcolonia] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](max) NOT NULL,
	[codigopostal] [int] NOT NULL,
	[idciudad] [int] NOT NULL,
 CONSTRAINT [pk_idcolonia] PRIMARY KEY CLUSTERED 
(
	[idcolonia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ciudades_colonias]    Script Date: 02/11/2019 09:02:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ciudades_colonias]
as
select co.nombre as colonia, ci.nombre as ciudad
from colonia co
inner join ciudad ci on co.idciudad=ci.idciudad;
GO
/****** Object:  View [dbo].[estados_ciudades_colonias]    Script Date: 02/11/2019 09:02:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[estados_ciudades_colonias]
as
select co.nombre as colonia, ci.nombre as ciudad, e.nombre as estado
from colonia co
inner join ciudad ci on co.idciudad=ci.idciudad
inner join estado e on ci.idestado=e.idestado;
GO
/****** Object:  View [dbo].[ciudades_colonias_cp]    Script Date: 02/11/2019 09:02:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ciudades_colonias_cp]
as
select co.nombre as colonia,co.codigopostal as cp, ci.nombre as ciudad
from ciudad ci
left join colonia co on ci.idciudad=co.idciudad;
GO
/****** Object:  View [dbo].[estados_ciudades_colonias_cp]    Script Date: 02/11/2019 09:02:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[estados_ciudades_colonias_cp]
as
select co.nombre as colonia,co.codigopostal as cp, ci.nombre as ciudad, e.idestado as estado
from ciudad ci
inner join colonia co on ci.idciudad=co.idciudad
inner join estado e on ci.idestado=e.idestado;
GO
/****** Object:  Table [dbo].[domicilio]    Script Date: 02/11/2019 09:02:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[domicilio](
	[iddomicilio] [int] IDENTITY(1,1) NOT NULL,
	[calle] [varchar](max) NOT NULL,
	[numint] [varchar](4) NOT NULL,
	[numex] [varchar](4) NULL,
	[idcolonia] [int] NOT NULL,
	[domiciliocompleto]  AS (((((([calle]+' ')+[numint])+' ')+[numex])+', ')+[idcolonia]),
 CONSTRAINT [pk_iddomicilio] PRIMARY KEY CLUSTERED 
(
	[iddomicilio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nombre]    Script Date: 02/11/2019 09:02:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nombre](
	[idnombre] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](15) NOT NULL,
	[appat] [varchar](15) NOT NULL,
	[apmat] [varchar](15) NOT NULL,
	[nombrecompleto]  AS (((([nombre]+' ')+[appat])+' ')+[apmat]),
 CONSTRAINT [pk_idnombre] PRIMARY KEY CLUSTERED 
(
	[idnombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[persona]    Script Date: 02/11/2019 09:02:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[persona](
	[idpersona] [int] IDENTITY(1,1) NOT NULL,
	[idnombre] [int] NOT NULL,
	[iddomicilio] [int] NOT NULL,
	[edad] [int] NOT NULL,
	[idsexo] [int] NOT NULL,
 CONSTRAINT [pk_idpersona] PRIMARY KEY CLUSTERED 
(
	[idpersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sexo]    Script Date: 02/11/2019 09:02:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sexo](
	[idsexo] [int] IDENTITY(1,1) NOT NULL,
	[sexo] [varchar](9) NULL,
 CONSTRAINT [pk_idsexo] PRIMARY KEY CLUSTERED 
(
	[idsexo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ciudad] ON 

INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (1, N'Aguascalientes', 1)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (2, N'Mexicali', 2)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (3, N'La Paz', 3)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (4, N'Campeche', 4)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (5, N'Tuxtla Gutierrez', 5)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (6, N'Chihuahua', 6)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (7, N'Coyoacan', 7)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (8, N'Saltillo', 8)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (9, N'Colima', 9)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (10, N'Vicente Guerrero', 10)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (11, N'Vicente Guerrero', 11)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (12, N'Chilpancingo de los Bravo', 12)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (13, N'Pachuca de Soto', 13)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (14, N'Guadalajara', 14)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (15, N'Texcoco', 15)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (16, N'Morelia', 16)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (17, N'Cuernavaca', 17)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (18, N'Tepic', 18)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (19, N'Monterrey', 19)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (20, N'Oaxaca de Juarez', 20)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (21, N'Puebla', 21)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (22, N'Queretaro', 22)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (23, N'Tulum', 23)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (24, N'San Luis Potosi', 24)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (25, N'Culiacan', 25)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (26, N'Arizpe', 26)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (27, N'Cardenas', 27)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (28, N'Nuevo Laredo', 28)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (29, N'Tlaxcala', 29)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (30, N'Xalapa', 30)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (31, N'Merida', 31)
INSERT [dbo].[ciudad] ([idciudad], [nombre], [idestado]) VALUES (32, N'Zacatecas', 32)
SET IDENTITY_INSERT [dbo].[ciudad] OFF
SET IDENTITY_INSERT [dbo].[colonia] ON 

INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1, N'Las Brisas', 20010, 1)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (2, N'Nueva Esperanza', 21050, 2)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1002, N'Lomas de Palmira', 23010, 3)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1003, N'San Joaquín', 24020, 4)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1004, N'Rosario Poniente', 29014, 5)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1005, N'Cuarteles', 31020, 6)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1006, N'Atlántida', 4370, 7)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1007, N'Loma Linda', 25016, 8)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1008, N'Las Palmas', 28017, 9)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1009, N'Revolución', 34892, 10)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1010, N'La Bufa', 36094, 11)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1011, N'Azteca', 39010, 12)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1012, N'Los Cedros', 42033, 13)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1013, N'El Jaguey', 44249, 14)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1014, N'San Juanito', 56120, 15)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1015, N'Cosmos', 58050, 16)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1016, N'El Veladero', 62243, 17)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1017, N'Reforma', 63038, 18)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1018, N'Real Cumbres', 64346, 19)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1019, N'Revolución', 68010, 20)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1020, N'Polideportivo', 72014, 21)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1021, N'Diligencias', 76020, 22)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1022, N'Maya Pax', 77760, 23)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1023, N'La Matamoros', 78100, 24)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1024, N'El Caiman', 81902, 25)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1025, N'El Alamito', 84640, 26)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1026, N'El Parnaso', 86495, 27)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1027, N'Bellavista', 88179, 28)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1028, N'Los Volcanes', 90014, 29)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1029, N'Solidaridad', 91013, 30)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1030, N'Itzimna', 97100, 31)
INSERT [dbo].[colonia] ([idcolonia], [nombre], [codigopostal], [idciudad]) VALUES (1031, N'De Olivos', 98024, 32)
SET IDENTITY_INSERT [dbo].[colonia] OFF
SET IDENTITY_INSERT [dbo].[estado] ON 

INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (1, N'Aguascalientes')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (2, N'Baja California')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (3, N'Baja California Sur')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (4, N'Campeche')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (5, N'Chiapas')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (6, N'Chihuahua')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (7, N'Ciudad de Mexico')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (8, N'Coahuila de Zaragoza')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (9, N'Colima')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (10, N'Durango')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (11, N'Guanajuato')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (12, N'Guerrero')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (13, N'Hidalgo')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (14, N'Jalisco')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (15, N'Mexico')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (16, N'Michoacan de Ocampo')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (17, N'Morelos')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (18, N'Nayarit')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (19, N'Nuevo Leon')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (20, N'Oaxaca')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (21, N'Puebla')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (22, N'Queretaro')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (23, N'Quintana Roo')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (24, N'San Luis Potosi')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (25, N'Sinaloa')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (26, N'Sonora')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (27, N'Tabasco')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (28, N'Tamaulipas')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (29, N'Tlaxcala')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (30, N'Veracruz')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (31, N'Yucatán')
INSERT [dbo].[estado] ([idestado], [nombre]) VALUES (32, N'Zacatecas')
SET IDENTITY_INSERT [dbo].[estado] OFF
SET IDENTITY_INSERT [dbo].[nombre] ON 

INSERT [dbo].[nombre] ([idnombre], [nombre], [appat], [apmat]) VALUES (1, N'Isarel', N'Limones', N'Vieyra')
INSERT [dbo].[nombre] ([idnombre], [nombre], [appat], [apmat]) VALUES (2, N'Samuel', N'Limones', N'Vieyra')
INSERT [dbo].[nombre] ([idnombre], [nombre], [appat], [apmat]) VALUES (1002, N'Emmanuel', N'Limones', N'Vieyra')
SET IDENTITY_INSERT [dbo].[nombre] OFF
SET IDENTITY_INSERT [dbo].[sexo] ON 

INSERT [dbo].[sexo] ([idsexo], [sexo]) VALUES (1, N'Masculino')
INSERT [dbo].[sexo] ([idsexo], [sexo]) VALUES (2, N'Femenino')
SET IDENTITY_INSERT [dbo].[sexo] OFF
/****** Object:  Index [uc_ciudad]    Script Date: 02/11/2019 09:02:14 p. m. ******/
ALTER TABLE [dbo].[ciudad] ADD  CONSTRAINT [uc_ciudad] UNIQUE NONCLUSTERED 
(
	[idciudad] ASC,
	[idestado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [uc_colonia]    Script Date: 02/11/2019 09:02:14 p. m. ******/
ALTER TABLE [dbo].[colonia] ADD  CONSTRAINT [uc_colonia] UNIQUE NONCLUSTERED 
(
	[idcolonia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [uc_domicilio]    Script Date: 02/11/2019 09:02:14 p. m. ******/
ALTER TABLE [dbo].[domicilio] ADD  CONSTRAINT [uc_domicilio] UNIQUE NONCLUSTERED 
(
	[iddomicilio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [uc_estado]    Script Date: 02/11/2019 09:02:14 p. m. ******/
ALTER TABLE [dbo].[estado] ADD  CONSTRAINT [uc_estado] UNIQUE NONCLUSTERED 
(
	[idestado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [uc_nombre]    Script Date: 02/11/2019 09:02:14 p. m. ******/
ALTER TABLE [dbo].[nombre] ADD  CONSTRAINT [uc_nombre] UNIQUE NONCLUSTERED 
(
	[idnombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [uc_persona]    Script Date: 02/11/2019 09:02:14 p. m. ******/
ALTER TABLE [dbo].[persona] ADD  CONSTRAINT [uc_persona] UNIQUE NONCLUSTERED 
(
	[idpersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [uc_sexo]    Script Date: 02/11/2019 09:02:14 p. m. ******/
ALTER TABLE [dbo].[sexo] ADD  CONSTRAINT [uc_sexo] UNIQUE NONCLUSTERED 
(
	[idsexo] ASC,
	[sexo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ciudad]  WITH CHECK ADD  CONSTRAINT [rel_estado_ciudad] FOREIGN KEY([idestado])
REFERENCES [dbo].[estado] ([idestado])
GO
ALTER TABLE [dbo].[ciudad] CHECK CONSTRAINT [rel_estado_ciudad]
GO
ALTER TABLE [dbo].[colonia]  WITH CHECK ADD  CONSTRAINT [rel_ciudad_colonia] FOREIGN KEY([idciudad])
REFERENCES [dbo].[ciudad] ([idciudad])
GO
ALTER TABLE [dbo].[colonia] CHECK CONSTRAINT [rel_ciudad_colonia]
GO
ALTER TABLE [dbo].[domicilio]  WITH CHECK ADD  CONSTRAINT [rel_colonia_domicilio] FOREIGN KEY([idcolonia])
REFERENCES [dbo].[colonia] ([idcolonia])
GO
ALTER TABLE [dbo].[domicilio] CHECK CONSTRAINT [rel_colonia_domicilio]
GO
ALTER TABLE [dbo].[persona]  WITH CHECK ADD  CONSTRAINT [rel_domicilio_persona] FOREIGN KEY([iddomicilio])
REFERENCES [dbo].[domicilio] ([iddomicilio])
GO
ALTER TABLE [dbo].[persona] CHECK CONSTRAINT [rel_domicilio_persona]
GO
ALTER TABLE [dbo].[persona]  WITH CHECK ADD  CONSTRAINT [rel_nombre_persona] FOREIGN KEY([idnombre])
REFERENCES [dbo].[nombre] ([idnombre])
GO
ALTER TABLE [dbo].[persona] CHECK CONSTRAINT [rel_nombre_persona]
GO
ALTER TABLE [dbo].[persona]  WITH CHECK ADD  CONSTRAINT [rel_sexo_persona] FOREIGN KEY([idsexo])
REFERENCES [dbo].[sexo] ([idsexo])
GO
ALTER TABLE [dbo].[persona] CHECK CONSTRAINT [rel_sexo_persona]
GO
/****** Object:  StoredProcedure [dbo].[ciudades_estados]    Script Date: 02/11/2019 09:02:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ciudades_estados]
as
select c.nombre as ciudad,e.nombre as estado
from ciudad c
inner join estado e on c.idestado=e.idestado;
GO
/****** Object:  StoredProcedure [dbo].[ciudades_estados_ordenados_AZ]    Script Date: 02/11/2019 09:02:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[ciudades_estados_ordenados_AZ]
as
select c.nombre as ciudad,e.nombre as estado
from ciudad c
inner join estado e on c.idestado=e.idestado
order by c.nombre asc;
GO
/****** Object:  StoredProcedure [dbo].[colonias_ciudades]    Script Date: 02/11/2019 09:02:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[colonias_ciudades]
as
select co.nombre as colonia, ci.nombre as ciudad
from colonia co
inner join ciudad ci on co.idciudad=ci.idciudad;
GO
/****** Object:  StoredProcedure [dbo].[colonias_ciudades_ordenados_ZA]    Script Date: 02/11/2019 09:02:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[colonias_ciudades_ordenados_ZA]
as
select co.nombre as colonia, ci.nombre as ciudad
from colonia co
inner join ciudad ci on co.idciudad=ci.idciudad
order by ci.nombre desc;
GO
/****** Object:  StoredProcedure [dbo].[colonias_cp_ciudades_estados_ordenados_AZ]    Script Date: 02/11/2019 09:02:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[colonias_cp_ciudades_estados_ordenados_AZ]
as
select co.nombre as colonia,co.codigopostal as cp, ci.nombre as ciudad, e.nombre as estado
from ciudad ci
left join colonia co on ci.idciudad=co.idciudad
left join estado e on ci.idestado=e.idestado
order by e.nombre asc;
GO
