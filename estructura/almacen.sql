--Empleados_Dim
select 
	concat_ws(' ', emp.primerNombre, emp.segundoNombre, emp.primerApellido, emp.segundoApellido) as nombreCompleto,
	ofi.nombre as nombreOficina,
	dis.nombreDistrito as distrito,
	cnt.nombreCanton as canton,
	prv.nombre as provincia,
	emp.estadoEmpleado into correosSA.tra.Empleados_Dim
from
	correosSA.ext.EMPLEADO emp
	left join correosSA.ext.OFICINA ofi
		on emp.idOficina = ofi.idOficina
	left join correosSA.ext.DISTRITOS dis
		on emp.idDistrito = dis.idDistrito
	left join correosSA.ext.CANTONES cnt
		on dis.idCanton = cnt.idCanton
	left join correosSA.ext.PROVINCIA prv
		on cnt.idProvincia = prv.idProvincia

--Clientes_Dim
select 
	concat_ws(' ', cli.primerNombre, cli.segundoNombre, cli.primerApellido, cli.segundoApellido) as nombreCompleto,
	dis.nombreDistrito as distrito,
	cnt.nombreCanton as canton,
	prv.nombre as provincia,
	cli.tipoCliente,
	cli.estadoCliente into correosSA.tra.Clientes_Dim
from
	correosSA.ext.CLIENTE cli
	left join correosSA.ext.DISTRITOS dis
		on cli.idDistrito = dis.idDistrito
	left join correosSA.ext.CANTONES cnt
		on dis.idCanton = cnt.idCanton
	left join correosSA.ext.PROVINCIA prv
		on cnt.idProvincia = prv.idProvincia

--Oficina_Dim
select 
	ofi.idOficina,
	ofi.nombre,
	dis.nombreDistrito as distrito,
	cnt.nombreCanton as canton,
	prv.nombre as provincia into correosSA.tra.Oficina_Dim
from
	correosSA.ext.OFICINA ofi
	left join correosSA.ext.DISTRITOS dis
		on ofi.idDistrito = dis.idDistrito
	left join correosSA.ext.CANTONES cnt
		on dis.idCanton = cnt.idCanton
	left join correosSA.ext.PROVINCIA prv
		on cnt.idProvincia = prv.idProvincia

--TiemposEstadoRegistro_Dim
select
	paq.fechaRegistro as fechaHoraEstadoRegistro,
	month(paq.fechaRegistro) as mes,
	datepart(quarter, paq.fechaRegistro) as trimestre,
	case
		when datepart(month, paq.fechaRegistro) <= 6 then 1
		else 2
	end as semestre,
	year(paq.fechaRegistro) as anno into correosSA.tra.TiemposEstadoRegistro_Dim
from
	correosSA.ext.PAQUETERIA paq

--TiemposEstadoEntregado_Dim
select
	paq.fechaEntrega as fechaHoraEntregado,
	month(paq.fechaEntrega) as mes,
	datepart(quarter, paq.fechaEntrega) as trimestre,
	case
		when datepart(month, paq.fechaEntrega) <= 6 then 1
		else 2
	end as semestre,
	year(paq.fechaEntrega) as anno into correosSA.tra.TiemposEstadoEntregado_Dim
from
	correosSA.ext.PAQUETERIA paq

--TiemposEstado1_Dim
select
	hest.fechaEstado as fechaHoraEstado1,
	month(hest.fechaEstado) as mes,
	datepart(quarter, hest.fechaEstado) as trimestre,
	case
		when datepart(month, hest.fechaEstado) <= 6 then 1
		else 2
	end as semestre,
	year(hest.fechaEstado) as anno into correosSA.tra.TiemposEstado1_Dim
from
	correosSA.ext.HISTORIA_ESTADOS hest
where
    hest.idEstado = 1

--TiemposEstado2_Dim
select
	hest.fechaEstado as fechaHoraEstado2,
	month(hest.fechaEstado) as mes,
	datepart(quarter, hest.fechaEstado) as trimestre,
	case
		when datepart(month, hest.fechaEstado) <= 6 then 1
		else 2
	end as semestre,
	year(hest.fechaEstado) as anno into correosSA.tra.TiemposEstado2_Dim
from
	correosSA.ext.HISTORIA_ESTADOS hest
where
    hest.idEstado = 2

--TiemposEstado3_Dim
select
	hest.fechaEstado as fechaHoraEstado3,
	month(hest.fechaEstado) as mes,
	datepart(quarter, hest.fechaEstado) as trimestre,
	case
		when datepart(month, hest.fechaEstado) <= 6 then 1
		else 2
	end as semestre,
	year(hest.fechaEstado) as anno into correosSA.tra.TiemposEstado3_Dim
from
	correosSA.ext.HISTORIA_ESTADOS hest
where
    hest.idEstado = 3

--TiemposEstado4_Dim
select
	hest.fechaEstado as fechaHoraEstado4,
	month(hest.fechaEstado) as mes,
	datepart(quarter, hest.fechaEstado) as trimestre,
	case
		when datepart(month, hest.fechaEstado) <= 6 then 1
		else 2
	end as semestre,
	year(hest.fechaEstado) as anno into correosSA.tra.TiemposEstado4_Dim
from
	correosSA.ext.HISTORIA_ESTADOS hest
where
    hest.idEstado = 4

--PaquetesEnviados_H
--v1
/*
select
	paq.idPaquete,
	fact.costoFlete,
	paq.fechaRegistro as fechaHoraRegistro,
	paq.fechaEntrega as fechaHoraEntrega,
	case
		when hest.idEstado = 1 then hest.fechaEstado
		else null
	end as fechaHoraEstado1,
	case
		when hest.idEstado = 2 then hest.fechaEstado
		else null
	end as fechaHoraEstado2,
	case
		when hest.idEstado = 3 then hest.fechaEstado
		else null
	end as fechaHoraEstado3,
	case
		when hest.idEstado = 4 then hest.fechaEstado
		else null
	end as fechaHoraEstado4,
	concat_ws(' ', emp.primerNombre, emp.segundoNombre, emp.primerApellido, emp.segundoApellido) as nombreCompletoEmpleado,
	concat_ws(' ', cli.primerNombre, cli.segundoNombre, cli.primerApellido, cli.segundoApellido) as nombreCompletoCliente
from correosSA.ext.PAQUETERIA paq
	left join correosSA.ext.TIPO_ENVIO tenv
		on paq.idTipoEnvio = tenv.idTipoEnvio
	left join correosSA.ext.DETALLE_FACTURACION dfact
		on paq.idPaquete = dfact.idPaquete
	left join correosSA.ext.FACTURACION fact
		on dfact.idFactura = fact.idFactura
	left join correosSA.ext.HISTORIA_ESTADOS hest
		on paq.idPaquete = hest.idPaquete
	left join correosSA.ext.OFICINA ofi
		on paq.idOficina = ofi.idOficina
	left join correosSA.ext.EMPLEADO emp
		on paq.idEmpleado = emp.idEmpleado
	left join correosSA.ext.CLIENTE cli
		on paq.idCliente = cli.idCliente
*/

--v2
select
	paq.idPaquete,
	fact.costoFlete,
	paq.fechaRegistro as fechaHoraRegistro,
	paq.fechaEntrega as fechaHoraEntrega,
	hest1.fechaEstado as fechaHoraEstado1,
	hest2.fechaEstado as fechaHoraEstado2,
	hest3.fechaEstado as fechaHoraEstado3,
	hest4.fechaEstado as fechaHoraEstado4,
	concat_ws(' ', emp.primerNombre, emp.segundoNombre, emp.primerApellido, emp.segundoApellido) as nombreCompletoEmpleado,
	concat_ws(' ', cli.primerNombre, cli.segundoNombre, cli.primerApellido, cli.segundoApellido) as nombreCompletoCliente,
	ofi.idOficina into correosSA.tra.PaquetesEnviados_H
from correosSA.ext.PAQUETERIA paq
	left join correosSA.ext.TIPO_ENVIO tenv
		on paq.idTipoEnvio = tenv.idTipoEnvio
	left join correosSA.ext.DETALLE_FACTURACION dfact
		on paq.idPaquete = dfact.idPaquete
	left join correosSA.ext.FACTURACION fact
		on dfact.idFactura = fact.idFactura
	left join correosSA.ext.HISTORIA_ESTADOS hest1
		on paq.idPaquete = hest1.idPaquete AND hest1.idEstado = 1
	left join correosSA.ext.HISTORIA_ESTADOS hest2
		on paq.idPaquete = hest2.idPaquete AND hest2.idEstado = 2
	left join correosSA.ext.HISTORIA_ESTADOS hest3
		on paq.idPaquete = hest3.idPaquete AND hest3.idEstado = 3
	left join correosSA.ext.HISTORIA_ESTADOS hest4
		on paq.idPaquete = hest4.idPaquete AND hest4.idEstado = 4
	left join correosSA.ext.OFICINA ofi
		on paq.idOficina = ofi.idOficina
	left join correosSA.ext.EMPLEADO emp
		on paq.idEmpleado = emp.idEmpleado
	left join correosSA.ext.CLIENTE cli
		on paq.idCliente = cli.idCliente
	