bulk insert correosTX.dbo.PAQUETERIA 
from 'D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data\paqueteriaNDc.csv' --Modifcar path con el de la maquina en .\Proyecto\data\paqueteria.csv
with(FIELDTERMINATOR = ',',
     ROWTERMINATOR = '\n',
	 BATCHSIZE = 500000,
	 TABLOCK);