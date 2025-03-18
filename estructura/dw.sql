select * into correosDW.dbo.Empleados_Dim
from correosSA.tra.Empleados_Dim
alter table correosDW.dbo.Empleados_Dim add primary key(nombreCompleto)

select * into correosDW.dbo.Clientes_Dim
from correosSA.tra.Clientes_Dim
alter table correosDW.dbo.Clientes_Dim add primary key(nombreCompleto)

select * into correosDW.dbo.Oficina_Dim
from correosSA.tra.Oficina_Dim
alter table correosDW.dbo.Oficina_Dim add primary key(idOficina)

select * into correosDW.dbo.TiemposEstadoRegistro_Dim
from correosSA.tra.TiemposEstadoRegistro_Dim
alter table correosDW.dbo.TiemposEstadoRegistro_Dim alter column fechaHoraEstadoRegistro datetime2(7) not null
alter table correosDW.dbo.TiemposEstadoRegistro_Dim add primary key(fechaHoraEstadoRegistro)

select * into correosDW.dbo.TiemposEstadoEntregado_Dim
from correosSA.tra.TiemposEstadoEntregado_Dim
alter table correosDW.dbo.TiemposEstadoEntregado_Dim alter column fechaHoraEntregado datetime2(7) not null
alter table correosDW.dbo.TiemposEstadoEntregado_Dim add primary key(fechaHoraEntregado)

select * into correosDW.dbo.TiemposEstado1_Dim
from correosSA.tra.TiemposEstado1_Dim
alter table correosDW.dbo.TiemposEstado1_Dim alter column fechaHoraEstado1 datetime2(7) not null
alter table correosDW.dbo.TiemposEstado1_Dim add primary key(fechaHoraEstado1)

select * into correosDW.dbo.TiemposEstado2_Dim
from correosSA.tra.TiemposEstado2_Dim
alter table correosDW.dbo.TiemposEstado2_Dim alter column fechaHoraEstado2 datetime2(7) not null
alter table correosDW.dbo.TiemposEstado2_Dim add primary key(fechaHoraEstado2)

select * into correosDW.dbo.TiemposEstado3_Dim
from correosSA.tra.TiemposEstado3_Dim
alter table correosDW.dbo.TiemposEstado3_Dim alter column fechaHoraEstado3 datetime2(7) not null
alter table correosDW.dbo.TiemposEstado3_Dim add primary key(fechaHoraEstado3)

select * into correosDW.dbo.TiemposEstado4_Dim
from correosSA.tra.TiemposEstado4_Dim
alter table correosDW.dbo.TiemposEstado4_Dim alter column fechaHoraEstado4 datetime2(7) not null
alter table correosDW.dbo.TiemposEstado4_Dim add primary key(fechaHoraEstado4)

select * into correosDW.dbo.PaquetesEnviados_H
from correosSA.tra.PaquetesEnviados_H
alter table correosDW.dbo.PaquetesEnviados_H add primary key(idPaquete)
alter table correosDW.dbo.PaquetesEnviados_H add foreign key(nombreCompletoEmpleado) references correosDW.dbo.Empleados_Dim(nombreCompleto)
alter table correosDW.dbo.PaquetesEnviados_H add foreign key(nombreCompletoCliente) references correosDW.dbo.Clientes_Dim(nombreCompleto)
alter table correosDW.dbo.PaquetesEnviados_H add foreign key(idOficina) references correosDW.dbo.Oficina_Dim(idOficina)
alter table correosDW.dbo.PaquetesEnviados_H add foreign key(fechaHoraRegistro) references correosDW.dbo.TiemposEstadoRegistro_Dim(fechaHoraEstadoRegistro)
alter table correosDW.dbo.PaquetesEnviados_H add foreign key(fechaHoraEntrega) references correosDW.dbo.TiemposEstadoEntregado_Dim(fechaHoraEntregado)
alter table correosDW.dbo.PaquetesEnviados_H add foreign key(fechaHoraEstado1) references correosDW.dbo.TiemposEstado1_Dim(fechaHoraEstado1)
alter table correosDW.dbo.PaquetesEnviados_H add foreign key(fechaHoraEstado2) references correosDW.dbo.TiemposEstado2_Dim(fechaHoraEstado2)
alter table correosDW.dbo.PaquetesEnviados_H add foreign key(fechaHoraEstado3) references correosDW.dbo.TiemposEstado3_Dim(fechaHoraEstado3)
alter table correosDW.dbo.PaquetesEnviados_H add foreign key(fechaHoraEstado4) references correosDW.dbo.TiemposEstado4_Dim(fechaHoraEstado4)