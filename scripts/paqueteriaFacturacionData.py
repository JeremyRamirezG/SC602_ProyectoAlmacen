import pandas as pd
import random
from datetime import datetime, timedelta

path_data = "D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data"

# Cargar archivos CSV
clientes_df = pd.read_csv(f"{path_data}\clientes.csv", header=None, names=[
    "idCliente", "cedula", "primerNombre", "segundoNombre", "primerApellido", "segundoApellido",
    "fechaNacimiento", "nombreUsuario", "correoCliente", "telefonoCliente", "direccionExacta", "tipoCliente", "estadoCliente", "idDistrito"
])

offices_df = pd.read_csv(f"{path_data}\script_oficinasProvincia.csv")
distritos_df = pd.read_csv(f"{path_data}\script_distritosProvincia.csv")

empleados_df = pd.read_csv(f"{path_data}\empleados.csv", header=None, names=[
    "idEmpleado", "cedula", "primerNombre", "segundoNombre", "primerApellido", "segundoApellido",
    "fechaNacimiento", "nombreUsuario", "telefonoEmpleado", "correoEmpleado", "direccionExacta", "estadoEmpleado", "idDistrito", "idOficina"
])

# Definir tipos de envíos con sus respectivos precios y probabilidades
tipo_envio_precios = {1: 1500, 2: 2500, 3: 2000, 4: 3000, 5: 5000, 6: 6000}
tipo_envio_pesos = [50, 15, 15, 15, 2.5, 2.5]

# Fechas de facturación
start_date = datetime(2022, 1, 1)
end_date = datetime(2024, 12, 31)

def random_date(start, end):
    fecha = start + timedelta(seconds=random.randint(0, int((end - start).total_seconds())))
    return fecha.replace(microsecond=random.randint(0, 999999))

def calcular_fechas_entrega(fecha_registro, tipo_envio):
    if tipo_envio in [2, 3]:
        fecha_entrega = fecha_registro + timedelta(days=random.randint(1, 3))
    elif tipo_envio == 4:
        fecha_entrega = fecha_registro + timedelta(days=random.randint(3, 5), hours=random.randint(20, 23))
    else:
        fecha_entrega = fecha_registro + timedelta(days=random.randint(3, 6))
    return fecha_entrega.replace(microsecond=random.randint(0, 999999))

facturas = []
paqueteria = []
detalle_factura = []
historial_estados = []
id_factura = 1
id_paquete = 1

print(f"Inicia creación de datos. Hora: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

for f in range(2583444):
    fecha_registro = random_date(start_date, end_date)
    cliente = clientes_df.sample(n=1).iloc[0]
    id_cliente = random.choice(clientes_df["idCliente"].tolist())
    id_provincia = int(str(cliente["cedula"])[0])
    num_paquetes = random.randint(1, 3)
    id_oficina = offices_df[offices_df["idProvincia"] == id_provincia].sample(n=1).iloc[0]["idOficina"]
    id_empleado = empleados_df[empleados_df["idOficina"] == id_oficina].sample(n=1).iloc[0]["idEmpleado"]
    
    total_costo_flete = 0
    
    for _ in range(num_paquetes):
        id_tipo_envio = random.choices(list(tipo_envio_precios.keys()), weights=tipo_envio_pesos, k=1)[0]
        costo_flete = tipo_envio_precios[id_tipo_envio]
        total_costo_flete += costo_flete
        fecha_entrega = calcular_fechas_entrega(fecha_registro, id_tipo_envio)
        descripcion = f"Paquete {id_paquete}"
        
        paqueteria.append([id_paquete, descripcion, fecha_registro, fecha_entrega, fecha_registro, id_oficina, id_empleado, id_cliente, id_tipo_envio])
        detalle_factura.append([id_paquete, id_factura, descripcion, costo_flete, id_paquete])

        historial_estados.append([1, id_paquete, fecha_registro])

        if (fecha_entrega - fecha_registro).days > 1:
            fecha_transito = fecha_registro + timedelta(days=random.randint(1, (fecha_entrega - fecha_registro).days))
            historial_estados.append([2, id_paquete, fecha_transito.replace(microsecond=random.randint(0, 999999))])

        if random.random() < 0.1:
            estado_final = random.choice([3, 4])
            historial_estados.append([estado_final, id_paquete, fecha_entrega])
        
        id_paquete += 1
    
    costo_iva = round(total_costo_flete * 0.13, 2)
    total_factura = total_costo_flete + costo_iva
    facturas.append([id_factura, fecha_registro, total_costo_flete, costo_iva, total_costo_flete, total_factura, id_cliente])
    
    id_factura += 1
    if (f + 1) % 100000 == 0:
        print(f"Se han generado {f + 1} facturas... Hora: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

# Guardar archivos
pd.DataFrame(facturas, columns=["idFactura", "fechaRegistro", "costoFlete", "totalSinIVA", "costoIVA", "totalFactura", "idCliente"]).to_csv(f"{path_data}\dataFacturas.csv", index=False, header=False)

pd.DataFrame(paqueteria, columns=["idPaquete", "descripcion", "fechaRegistro", "fechaEntrega", "fechaUltimaModificacion", "idOficina", "idEmpleado", "idCliente", "idTipoEnvio"]).to_csv(f"{path_data}\paqueteria.csv", index=False, header=False)

pd.DataFrame(detalle_factura, columns=["linea", "idFactura", "descripcion", "totalLinea", "idPaquete"]).to_csv(f"{path_data}\detalleFactura.csv", index=False, header=False)

pd.DataFrame(historial_estados, columns=["idEstado", "idPaquete", "fechaEstado"]).to_csv(f"{path_data}\historialPaqueteria.csv", index=False, header=False)

print("Archivos de facturación generados exitosamente.")
