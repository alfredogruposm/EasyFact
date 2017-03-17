
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


create view Vistaproductos
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
