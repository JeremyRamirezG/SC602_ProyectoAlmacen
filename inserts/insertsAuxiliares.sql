INSERT INTO correosTX.dbo.TIPO_ENVIO (idTipoEnvio, descripcion)
VALUES 
(1, 'Env�o Est�ndar'),
(2, 'Env�o Expr�s'),
(3, 'Env�o Mismo D�a'),
(4, 'Env�o Nocturno'),
(5, 'Env�o de Productos Peligrosos'),
(6, 'Env�o Refrigerado');

INSERT INTO correosTX.dbo.ESTADOS (idEstado, descripcion)
VALUES 
(1, 'Enviado'),
(2, 'En tr�nsito'),
(3, 'Devuelto al remitente'),
(4, 'Extraviado');