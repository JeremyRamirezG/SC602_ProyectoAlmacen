bulk insert correosTX.dbo.CLIENTE 
from 'D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data\clientes.csv' --Modifcar path con el de la maquina en .\Proyecto\data\clientes.csv
with(FIELDTERMINATOR = ',',
     ROWTERMINATOR = '\n',
	 BATCHSIZE = 50000,
	 TABLOCK);