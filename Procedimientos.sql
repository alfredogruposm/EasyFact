

create procedure devuelveproductosproveedor
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
GO

create procedure eliminacompradetalles
@iddetallecompra int as
delete from ComprasDetalle where IDComprasDetalle=@iddetallecompra
GO

create procedure insertacompradetalles
@idcompra int, @idproducto int, @cantidad int, @importe decimal(18, 2) as
if EXISTS(select * from ComprasDetalle where Compra=@idcompra and Producto=@idproducto)
update ComprasDetalle set Cantidad+=@cantidad, Importe+=@importe where Compra=@idcompra and Producto=@idproducto 
else
insert into ComprasDetalle values(@idcompra, @idproducto, @cantidad, @importe)
GO



create procedure insertacompraparcial
@fecha date, @proveedor int, @moneda varchar(max), @tipodecambio decimal(18, 6), @fechatipocambio date, @metododepago varchar(max), @numcuenta varchar(max)  as
insert into Compras(Fecha, ProveedorCompra, Moneda, tipodecambio, fechatipodecambio, metodoDePago, NumCuenta)
 values(@fecha,  @proveedor, @moneda, @tipodecambio, @fechatipocambio, @metododepago, @numcuenta)
GO

create procedure actualizacompraparcial
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


create procedure cancelacompra
@idcompra int as
update Compras set Cancelada=1 where IDCompra=@idcompra
GO


create procedure vistafacturasdetalle @idfactura int
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

create procedure eliminafacturadetalles
@iddetallefactura int as
delete from FacturasDetalle where IDFacturasDetalle=@iddetallefactura


create procedure insertafacturadetalles
@idfactura int, @idproducto int, @cantidad int, @importe decimal(18, 2) as
if EXISTS(select * from [FacturasDetalle] where Factura=@idfactura and Producto=@idproducto)
update [FacturasDetalle] set Cantidad+=@cantidad, Importe+=@importe where Factura=@idfactura and Producto=@idproducto 
else
insert into [FacturasDetalle] values(@idfactura, @idproducto, @cantidad, @importe)
GO



create procedure ingresa_actualizafac
@idfactura int, @factura varchar(max), @folio varchar(max) as
if EXISTS(select * from numerofactura where Factura=@idfactura)
UPDATE numerofactura set FacturaT=@folio where Factura=@idfactura
else
insert into numerofactura values(@idfactura, @factura)
update Facturas set ClaveCFDI=@factura where IDFactura=@idfactura
if EXISTS(select * from numerofactura where Factura=@idfactura)
update Facturas set ClaveCFDI=@factura where IDFactura=@idfactura
GO

		

create procedure numerofacturas
as
select MAX(IDFactura) from Facturas;
GO


create procedure numerocompras
as
select MAX(IDCompra) from Compras;
GO


create procedure cancelafactura
@idfactura int, @acuserecibo varchar(max) as
if EXISTS(select * from cancelacionesfacturas where Factura=@idfactura)
update Facturas set Cancelada=1 where IDFactura=@idfactura
else
update Facturas set Cancelada=1 where IDFactura=@idfactura
insert into cancelacionesfacturas values(@idfactura, @acuserecibo)
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

	
create procedure insertaFacturaparcial
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

create procedure eliminaclientes
@idcliente int as
delete from Clientes where IDCliente=@idcliente
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

create procedure devuelveclientenombre
@nombre varchar(max) as
select * from Clientes where NombreComercialCliente=@nombre
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


create procedure reportefacturas
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
