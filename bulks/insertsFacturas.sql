bulk insert correosTX.dbo.FACTURACION 
from 'D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data\dataFacturas.csv' --Modifcar path con el de la maquina en .\Proyecto\data\dataFacturas.csv
with(FIELDTERMINATOR = ',',
     ROWTERMINATOR = '\n',
	 BATCHSIZE = 250000,
	 TABLOCK);