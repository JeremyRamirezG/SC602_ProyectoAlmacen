bulk insert correosTX.dbo.EMPLEADO 
from 'D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data\empleados.csv' --Modifcar path con el de la maquina en .\Proyecto\data\empleados.csv
with(FIELDTERMINATOR = ',',
     ROWTERMINATOR = '\n',
	 BATCHSIZE = 300,
	 TABLOCK);