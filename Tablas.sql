Create database EasyFact;
GO

Use EasyFact;
GO


CREATE TABLE [dbo].[Clientes](
	[IDCliente] [int] IDENTITY(100,1) NOT NULL,
	[NombreComercialCliente] [varchar](max) NULL,
	[ContactoCliente] [varchar](max) NULL,
	[TelefonoCliente] [varchar](max) NULL,
	[EmailCliente] [varchar](max) NULL,
	[RFCCliente] [varchar](max) NULL,
	[RazonSocialCliente] [varchar](max) NULL,
	[calleCliente] [varchar](max) NULL,
	[NumExtCliente] [varchar](max) NULL,
	[NumIntCliente] [varchar](max) NULL,
	[ColoniaCliente] [varchar](max) NULL,
	[LocalidadCliente] [varchar](max) NULL,
	[ReferenciasDireccionCliente] [varchar](max) NULL,
	[MunicipioCliente] [varchar](max) NULL,
	[EstadoCliente] [varchar](max) NULL,
	[PaisCliente] [varchar](max) NULL,
	[CodigoPostalCliente] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDCliente] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



Create table Proveedores(IDProveedor int not null identity(100,1) primary key,
						[NombreComercialProveedor] [varchar](max) NULL,
						[ContactoProveedor] [varchar](max) NULL,
						[TelefonoProveedor] [varchar](max) NULL,
						[EmailProveedor] [varchar](max) NULL,
						[RFCProveedor] [varchar](max) NULL,
						[RazonSocialProveedor] [varchar](max) NULL,
						[DireccionProveedor] [varchar](max) NULL)
						
GO
		

Create table Productos(IDProducto int not null identity(100,1) primary key,
						Proveedor int not null foreign key references Proveedores(IDProveedor),
						Presentacion varchar(max),
						Descripcion varchar(max),
						Precio decimal(18, 2),
						Cantidad decimal,
						Inventariable int)
						
GO

CREATE TABLE [dbo].[Facturas](
	[IDFactura] [int] IDENTITY(100,1) NOT NULL,
	[ClienteFactura] [int] NOT NULL,
	[Fecha] date,		
	[ClaveCFDI] [varchar](max) NULL,
	[formaDePago] [varchar](max),
	[Parcialidades] [varchar](max) NULL,
	[CondicionesDePago] [varchar](max) NULL,
	[metodoDePago] [varchar](max),
	[descuento] decimal(18, 6) NULL,
	[porcentajeDescuento] int NULL,
	[motivodescuento] [varchar](max) NULL,
	[Moneda] [varchar](max),
	[tipodecambio] decimal(18, 6),
	[fechatipodecambio] date,
	[totalImpuestosretenidos] decimal(18, 6) NULL,
	[totalimpuestostrasladados] decimal(18, 6),
	[Subtotal] [decimal](18, 6),
	[Total] [decimal](18, 6),
	[TotalLetras] [varchar](max),			
	[LugarExpedicion] [varchar](max),
	[NumCuenta] [varchar](max) NULL,
	[FolioFiscalOrig] [varchar](max) NULL,
	[SerieFolioFiscalOrig] [varchar](max) NULL,
	[FechaFolioFiscalOrig] [varchar](max) NULL,
	[MontoFolioFiscalOrig] [varchar](max) NULL,
	[FacturadaL] [int] NULL,
	[Cancelada] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDFactura] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

create TABLE [dbo].[Facturas]  WITH CHECK ADD FOREIGN KEY([ClienteFactura])
REFERENCES [dbo].[Clientes] ([IDCliente])
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO





create table cancelacionesfacturas(IDACUSE int not null identity(100, 1) primary key,
						Factura int foreign key references Facturas(IDFactura),
						AcuseRecibo varchar(max));
GO
create table numerofactura(idnumerofactura int not null identity(100, 1) primary key,
								Factura int not null foreign key references Facturas(IDFactura),
								FacturaT varchar(max))
GO

CREATE TABLE [dbo].[FacturasDetalle](
	[IDFacturasDetalle] [int] IDENTITY(100,1) NOT NULL,
	[Factura] [int] NOT NULL,
	[Producto] [int] not null foreign key references Productos(IDProducto),
	[Cantidad] [int],
	[Importe] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDFacturasDetalle] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

create TABLE [dbo].[FacturasDetalle]  WITH CHECK ADD FOREIGN KEY([Factura])
REFERENCES [dbo].[Facturas] ([IDFactura])

GO

Create table Compras(
	[IDCompra] [int] IDENTITY(100,1) NOT NULL primary key,
	[ProveedorCompra] [int] NOT NULL foreign key references Proveedores(IDProveedor),
	[Fecha] [date] NULL,
	[formaDePago] [varchar](max) NULL,
	[Parcialidades] [varchar](max) NULL,
	[CondicionesDePago] [varchar](max) NULL,
	[metodoDePago] [varchar](max) NULL,
	[descuento] decimal(18, 2) NULL,
	[porcentajeDescuento] int NULL,
	[motivodescuento] [varchar](max) NULL,
	[Moneda] [varchar](max) NULL,
	[tipodecambio] decimal(18, 2) NULL,
	[fechatipodecambio] date NULL,
	[Subtotal] [decimal](18, 2) NULL,
	IVA decimal(18, 2),
	[Total] [decimal](18, 2) NULL,
	NumCuenta varchar(max) null,
	[Cancelada] [int] NULL)
	
GO


CREATE TABLE [dbo].[ComprasDetalle](
	[IDComprasDetalle] [int] IDENTITY(100,1) NOT NULL,
	[Compra] [int] NOT NULL,
	[Producto] [int] not null foreign key references Productos(IDProducto),
	[Cantidad] [varchar](max) NULL,
	[Importe] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDComprasDetalle] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

create TABLE [dbo].[ComprasDetalle]  WITH CHECK ADD FOREIGN KEY([Compra])
REFERENCES [dbo].Compras([IDCompra])
GO

create table CuentaPAC(IDCuentaPAC int not null identity(100, 1) primary key,
						Nombre varchar(max),
						Usuario varchar(max),
						Cuenta varchar(max),
						Contraseña varchar(max))
						GO

