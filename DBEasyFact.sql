Create database EasyFact;
GO

Use EasyFact;
GO


create procedure reporteservicios
@idfactura int as
select Productos.Descripcion,
		Productos.Precio,
		Productos.Presentacion,
		FacturasDetalle.Cantidad,
		FacturasDetalle.Importe
from FacturasDetalle, 
		Productos
where FacturasDetalle.Factura=@idfactura and FacturasDetalle.Producto=Productos.IDProducto
GO


alter procedure reportefacturas
@idfactura int as
Select Facturas.IDFactura as 'ID',
		Clientes.NombreComercialCliente,
		Clientes.MunicipioCliente as 'Municipio',
		Clientes.RFCCliente,
		Clientes.RazonSocialCliente as 'Razon Social',
		Clientes.calleCliente,
		Clientes.NumIntCliente,
		Clientes.NumExtCliente,
		Clientes.ColoniaCliente,
		Clientes.LocalidadCliente,
		Clientes.EstadoCliente,
		Clientes.PaisCliente,
		Clientes.CodigoPostalCliente, 
		Clientes.EstadoCliente,
		Clientes.PaisCliente,
		Facturas.Fecha,
		Facturas.Moneda,
		Facturas.Subtotal,
		Facturas.totalimpuestostrasladados,
		Facturas.Total,
		formaDePago,
		metodoDePago,
		descuento,
		motivodescuento,
		tipodecambio,
		fechatipodecambio,
		LugarExpedicion,
		Facturas.NumCuenta,
		Facturas.TotalLetras
from Facturas,
		Clientes
where Facturas.ClienteFactura=Clientes.IDCliente and Facturas.IDFactura=@idfactura
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

					
Create procedure modificaclientes
@idcliente int, @Nombrecomercial varchar(max),	@Contacto varchar(max), @Telefono varchar(max), @email varchar(max),
@RFC varchar(max), @RazonSocial varchar(max),
@calle varchar(max), @Numeroext varchar(max),
@Numint varchar(max),
@colonia varchar(max), @Localidad varchar(max), @ReferenciasDir varchar(max), @Municipio varchar(max), @estado varchar(max), @pais varchar(max), @codigopostal varchar(max)
as
UPDATE [EasyFact].[dbo].[Clientes]
   SET [NombreComercialCliente] = @Nombrecomercial
      ,[ContactoCliente] = @Contacto
      ,[TelefonoCliente] = @Telefono
      ,[EmailCliente] = @email
      ,[RFCCliente] = @RFC
      ,[RazonSocialCliente] = @RazonSocial
      ,[calleCliente] = @calle
      ,[NumExtCliente] = @Numeroext
      ,[NumIntCliente] = @Numint
      ,[ColoniaCliente] = @colonia
      ,[LocalidadCliente] = @Localidad
      ,[ReferenciasDireccionCliente] = @ReferenciasDir
      ,[MunicipioCliente] = @Municipio
      ,[EstadoCliente] = @estado
      ,[PaisCliente] = @pais
      ,[CodigoPostalCliente] = @codigopostal
where IDCliente=@idcliente
GO

alter procedure devuelveclientenombre
@nombre varchar(max) as
select * from Clientes where NombreComercialCliente=@nombre
GO
				
create view vistaclientes
as
Select Clientes.IDCliente,
		Clientes.NombreComercialCliente,
		Clientes.MunicipioCliente,
		Clientes.TelefonoCliente,
		Clientes.RFCCliente,
		Clientes.ContactoCliente,
		Clientes.RazonSocialCliente as 'Razon Social',
		Clientes.calleCliente,
		Clientes.NumExtCliente,
		Clientes.NumIntCliente,
		Clientes.ColoniaCliente,
		Clientes.LocalidadCliente,
		Clientes.ReferenciasDireccionCliente,
		Clientes.EstadoCliente,
		Clientes.PaisCliente,
		Clientes.EmailCliente,
		Clientes.CodigoPostalCliente
from Clientes
GO	

create procedure eliminaclientes
@idcliente int as
delete from Clientes where IDCliente=@idcliente
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
					
Create procedure modificaproveedores
@IDProveedor int, @NombreComercialProveedor varchar(max),	@ContactoProveedor varchar(max), @TelefonoProveedor varchar(max), @EmailProveedor varchar(max),
@RFCProveedor varchar(max), @RazonSocialProveedor varchar(max),
@DireccionProveedor varchar(max)
as
UPDATE [EasyFact].[dbo].[Proveedores]
   SET [NombreComercialProveedor] = @NombreComercialProveedor
      ,[ContactoProveedor] = @ContactoProveedor
      ,[TelefonoProveedor] = @TelefonoProveedor
      ,[EmailProveedor] = @EmailProveedor
      ,[RFCProveedor] = @RFCProveedor
      ,[RazonSocialProveedor] = @RazonSocialProveedor
      ,[DireccionProveedor] = @DireccionProveedor
      where IDProveedor=@IDProveedor
GO


create procedure eliminaproveedores
@IDProveedor int as
delete from [Proveedores] where IDProveedor=@IDProveedor
GO

Create table Productos(IDProducto int not null identity(100,1) primary key,
						Proveedor int not null foreign key references Proveedores(IDProveedor),
						Presentacion varchar(max),
						Descripcion varchar(max),
						Precio decimal(18, 2),
						Cantidad decimal,
						Inventariable int)
						
GO

alter view Vistaproductos
as
SELECT [IDProducto]
      ,Proveedores.NombreComercialProveedor
      ,[Presentacion]
      ,[Descripcion]
      ,[Precio]
      ,[Cantidad]
      ,Proveedores.IDProveedor
  FROM [EasyFact].[dbo].[Productos], 
		Proveedores
where Productos.Proveedor=Proveedores.IDProveedor
GO

alter procedure devuelveproductosproveedor
@idproveedor int as
select [IDProducto]
      ,[Descripcion]
      ,[Presentacion]
      ,[Precio]
      ,[Cantidad]
from Productos
where Productos.Proveedor=@idproveedor

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

create procedure eliminaproductos
@idproducto int as 
delete from Productos where IDProducto=@idproducto
GO

create procedure modificaproductos 
@idproducto int, @proveedor int, @Presentacion varchar(max),
						@Descripcion varchar(max),
						@Precio decimal(18, 2),
						@Inventariable int as
UPDATE [EasyFact].[dbo].[Productos]
   SET [Proveedor] = @proveedor
      ,[Presentacion] = @Presentacion
      ,[Descripcion] = @Descripcion
      ,[Precio] = @Precio
      ,[Inventariable] = @Inventariable
 WHERE Productos.IDProducto=@idproducto
GO

create procedure actualizaexistenciasproductos
@idproducto int, @cantidad decimal(18, 2) as
update Productos set Cantidad+=@cantidad where IDProducto=@idproducto
GO

	
alter procedure insertaFacturaparcial
@fecha date, @cliente int, @moneda varchar(max), @tipodecambio decimal(18, 6), @fechatipocambio date, @metododepago varchar(max), @numcuenta varchar(max)  as
insert into Facturas(Fecha, ClienteFactura, Moneda, tipodecambio, fechatipodecambio, metodoDePago, NumCuenta)
 values(@fecha,  @cliente, @moneda, @tipodecambio, @fechatipocambio, @metododepago, @numcuenta)
GO

create procedure actualizafacturaparcial
@idfactura int, @subtotal decimal(18, 6), @iva decimal(18, 6), @total decimal(18, 6), @totalletras varchar(max), @descuento decimal(18, 6), @porcentajedescuento int, @motivodescuento varchar(max),
@lugarExpedicion varchar(max) as 
update Facturas set Subtotal=@subtotal, totalimpuestostrasladados=@iva, Total=@total, Cancelada=0, TotalLetras=@totalletras, FacturadaL=0,
descuento=@descuento, porcentajeDescuento=@porcentajedescuento, motivodescuento=@motivodescuento, 
LugarExpedicion=@lugarExpedicion where IDFactura=@idfactura
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

ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD FOREIGN KEY([ClienteFactura])
REFERENCES [dbo].[Clientes] ([IDCliente])
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO



create view vistaFacturas
as
Select Facturas.IDFactura as 'ID',
		Facturas.Fecha,
		numerofactura.FacturaT as 'Factura',
		Clientes.NombreComercialCliente as 'Cliente',
		Facturas.Moneda,
		Facturas.Subtotal,
		Facturas.Total,
		Facturas.ClaveCFDI,
		Facturas.formaDePago,
		Facturas.metodoDePago,
		Facturas.descuento,
		Facturas.porcentajeDescuento,
		Facturas.motivodescuento,
		Facturas.tipodecambio,
		Facturas.fechatipodecambio,
		Facturas.totalimpuestostrasladados,
		Facturas.totalImpuestosretenidos,
		Facturas.LugarExpedicion,
		Facturas.TotalLetras,
		Facturas.NumCuenta
from Facturas,
		Clientes,
		numerofactura
where Facturas.ClienteFactura=Clientes.IDCliente and numerofactura.Factura=Facturas.IDFactura and Facturas.Cancelada=0
GO



create view vistaFacturasCanceladas
as
Select Facturas.IDFactura as 'ID',
		Facturas.Fecha,
		numerofactura.FacturaT as 'Factura',
		Clientes.NombreComercialCliente as 'Cliente',
		Facturas.Moneda,
		Facturas.Subtotal,
		Facturas.Total,
		Facturas.ClaveCFDI,
		Facturas.formaDePago,
		Facturas.metodoDePago,
		Facturas.descuento,
		Facturas.porcentajeDescuento,
		Facturas.motivodescuento,
		Facturas.tipodecambio,
		Facturas.fechatipodecambio,
		Facturas.totalimpuestostrasladados,
		Facturas.totalImpuestosretenidos,
		Facturas.LugarExpedicion,
		Facturas.TotalLetras,
		Facturas.NumCuenta
from Facturas,
		Clientes,
		numerofactura
where Facturas.ClienteFactura=Clientes.IDCliente and numerofactura.Factura=Facturas.IDFactura and Facturas.Cancelada=1
GO


create table cancelacionesfacturas(IDACUSE int not null identity(100, 1) primary key,
						Factura int foreign key references Facturas(IDFactura),
						AcuseRecibo varchar(max));
GO
alter procedure cancelafactura
@idfactura int, @acuserecibo varchar(max) as
if EXISTS(select * from cancelacionesfacturas where Factura=@idfactura)
update Facturas set Cancelada=1 where IDFactura=@idfactura
else
update Facturas set Cancelada=1 where IDFactura=@idfactura
insert into cancelacionesfacturas values(@idfactura, @acuserecibo)
GO

create table numerofactura(idnumerofactura int not null identity(100, 1) primary key,
								Factura int not null foreign key references Facturas(IDFactura),
								FacturaT varchar(max))
GO

alter procedure ingresa_actualizafac
@idfactura int, @factura varchar(max), @folio varchar(max) as
if EXISTS(select * from numerofactura where Factura=@idfactura)
UPDATE numerofactura set FacturaT=@folio where Factura=@idfactura
else
insert into numerofactura values(@idfactura, @factura)
update Facturas set ClaveCFDI=@factura where IDFactura=@idfactura
if EXISTS(select * from numerofactura where Factura=@idfactura)
update Facturas set ClaveCFDI=@factura where IDFactura=@idfactura
GO

		

alter procedure numerofacturas
as
select MAX(IDFactura) from Facturas;
GO


alter procedure numerocompras
as
select MAX(IDCompra) from Compras;
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

ALTER TABLE [dbo].[FacturasDetalle]  WITH CHECK ADD FOREIGN KEY([Factura])
REFERENCES [dbo].[Facturas] ([IDFactura])

GO

alter procedure vistafacturasdetalle @idfactura int
as
select FacturasDetalle.IDFacturasDetalle as 'ID',
		Productos.Descripcion,
		Productos.Presentacion,
		Productos.Precio,
		FacturasDetalle.Cantidad,
		FacturasDetalle.Importe,
		Productos.IDProducto
from FacturasDetalle,
		Productos
where FacturasDetalle.Factura=@idfactura and FacturasDetalle.Producto=Productos.IDProducto

alter procedure eliminafacturadetalles
@iddetallefactura int as
delete from FacturasDetalle where IDFacturasDetalle=@iddetallefactura


alter procedure insertafacturadetalles
@idfactura int, @idproducto int, @cantidad int, @importe decimal(18, 2) as
if EXISTS(select * from [FacturasDetalle] where Factura=@idfactura and Producto=@idproducto)
update [FacturasDetalle] set Cantidad+=@cantidad, Importe+=@importe where Factura=@idfactura and Producto=@idproducto 
else
insert into [FacturasDetalle] values(@idfactura, @idproducto, @cantidad, @importe)
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

create procedure cancelacompra
@idcompra int as
update Compras set Cancelada=1 where IDCompra=@idcompra
GO

create view vistacompras
as
Select Compras.IDCompra as 'ID',
		Compras.Fecha,
		Proveedores.NombreComercialProveedor as 'Proveedor',
		Compras.Moneda,
		Compras.Subtotal,
		Compras.Total,
		Compras.Iva,
		Compras.formaDePago,
		Compras.metodoDePago,
		Compras.descuento,
		Compras.porcentajeDescuento,
		Compras.motivodescuento,
		Compras.NumCuenta
from Compras,
		Proveedores
where Compras.ProveedorCompra=Proveedores.IDProveedor and Compras.Cancelada=0
GO



create view vistacomprasCanceladas
as
Select Compras.IDCompra as 'ID',
		Compras.Fecha,
		Proveedores.NombreComercialProveedor as 'Proveedor',
		Compras.Moneda,
		Compras.Subtotal,
		Compras.Total,
		Compras.Iva,
		Compras.formaDePago,
		Compras.metodoDePago,
		Compras.descuento,
		Compras.porcentajeDescuento,
		Compras.motivodescuento,
		Compras.NumCuenta
from Compras,
		Proveedores
where Compras.ProveedorCompra=Proveedores.IDProveedor and Compras.Cancelada=1
GO




alter procedure insertacompraparcial
@fecha date, @proveedor int, @moneda varchar(max), @tipodecambio decimal(18, 6), @fechatipocambio date, @metododepago varchar(max), @numcuenta varchar(max)  as
insert into Compras(Fecha, ProveedorCompra, Moneda, tipodecambio, fechatipodecambio, metodoDePago, NumCuenta)
 values(@fecha,  @proveedor, @moneda, @tipodecambio, @fechatipocambio, @metododepago, @numcuenta)
GO

alter procedure actualizacompraparcial
@idcompra int, @subtotal decimal(18, 6), @iva decimal(18, 6), @total decimal(18, 6), @descuento decimal(18, 6), @porcentajedescuento int, @motivodescuento varchar(max)
as 
update Compras set Subtotal=@subtotal, IVA=@iva, Total=@total, Cancelada=0, 
descuento=@descuento, porcentajeDescuento=@porcentajedescuento, motivodescuento=@motivodescuento
where [IDCompra]=@idcompra
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
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

ALTER TABLE [dbo].[ComprasDetalle]  WITH CHECK ADD FOREIGN KEY([Compra])
REFERENCES [dbo].Compras([IDCompra])
GO

select * from Facturas

Create procedure vistacomprasdetalle @idcompra int
as
select ComprasDetalle.IDComprasDetalle as 'ID',
		Productos.Descripcion,
		Productos.Presentacion,
		Productos.Precio,
		ComprasDetalle.Cantidad,
		ComprasDetalle.Importe,
		Productos.IDProducto
from ComprasDetalle,
		Productos
where ComprasDetalle.Compra=@idcompra and ComprasDetalle.Producto=Productos.IDProducto

create procedure eliminacompradetalles
@iddetallecompra int as
delete from ComprasDetalle where IDComprasDetalle=@iddetallecompra

select * from ComprasDetalle
create procedure insertacompradetalles
@idcompra int, @idproducto int, @cantidad int, @importe decimal(18, 2) as
if EXISTS(select * from ComprasDetalle where Compra=@idcompra and Producto=@idproducto)
update ComprasDetalle set Cantidad+=@cantidad, Importe+=@importe where Compra=@idcompra and Producto=@idproducto 
else
insert into ComprasDetalle values(@idcompra, @idproducto, @cantidad, @importe)
GO


create table CuentaPAC(IDCuentaPAC int not null identity(100, 1) primary key,
						Nombre varchar(max),
						Usuario varchar(max),
						Cuenta varchar(max),
						Contraseña varchar(max))
						GO


create procedure modificadatospac
@idcuenta int, @nombre varchar(max), @Usuario varchar(max), @cuenta varchar(max), @contraseña varchar(max) as
update CuentaPAC set Nombre=@nombre, Usuario=@Usuario, Cuenta=@cuenta, Contraseña=@contraseña where IDCuentaPAC=@idcuenta
GO

create procedure eliminadatospac
@idcuenta int as
delete from CuentaPAC where IDCuentaPAC=@idcuenta
GO

create procedure devuelvedatospac
as
select IDCuentaPAC as 'ID',
		Nombre,
		Usuario,
		Cuenta,
		Contraseña
from CuentaPAC
GO


create procedure devuelvedatospacNOMBRE
@Nombre varchar(max) as
select 	Usuario,
		Cuenta,
		Contraseña
from CuentaPAC
where Nombre=@Nombre
GO
