--Crear copia de la base de datos
select * into correosSA.ext.TIPO_ENVIO
from correosTX.dbo.TIPO_ENVIO

select * into correosSA.ext.PROVINCIA
from correosTX.dbo.PROVINCIA

select * into correosSA.ext.CANTONES
from correosTX.dbo.CANTONES

select * into correosSA.ext.DISTRITOS
from correosTX.dbo.DISTRITOS

select * into correosSA.ext.OFICINA
from correosTX.dbo.OFICINA

select * into correosSA.ext.EMPLEADO
from correosTX.dbo.EMPLEADO

select * into correosSA.ext.CLIENTE
from correosTX.dbo.CLIENTE

select * into correosSA.ext.PAQUETERIA
from correosTX.dbo.PAQUETERIA

select * into correosSA.ext.FACTURACION
from correosTX.dbo.FACTURACION

select * into correosSA.ext.DETALLE_FACTURACION
from correosTX.dbo.DETALLE_FACTURACION

select * into correosSA.ext.ESTADOS
from correosTX.dbo.ESTADOS

select * into correosSA.ext.HISTORIA_ESTADOS
from correosTX.dbo.HISTORIA_ESTADOS