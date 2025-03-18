bulk insert correosTX.dbo.HISTORIA_ESTADOS 
from 'D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data\historialPaqueteriaNDc.csv' --Modifcar path con el de la maquina en .\Proyecto\data\historialPaqueteria.csv
with(FIELDTERMINATOR = ',',
     ROWTERMINATOR = '\n',
	 BATCHSIZE = 1000000,
	 TABLOCK);