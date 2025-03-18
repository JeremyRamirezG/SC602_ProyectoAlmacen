bulk insert correosTX.dbo.DETALLE_FACTURACION 
from 'D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data\detalleFactura.csv' --Modifcar path con el de la maquina en .\Proyecto\data\detalleFactura.csv
with(FIELDTERMINATOR = ',',
     ROWTERMINATOR = '\n',
	 BATCHSIZE = 500000,
	 TABLOCK);