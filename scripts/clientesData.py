import pandas as pd
import random
import names
from datetime import datetime, timedelta

path_data = "D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data"
distritos_df = pd.read_csv(f"{path_data}\script_distritosProvincia.csv")

def generar_cedula(id_provincia):
    return f"{id_provincia}{random.randint(10000000, 99999999)}"

start_date = datetime(1965, 1, 1)
end_date = datetime(2006, 12, 31)

def random_date(start, end):
    return start + timedelta(seconds=random.randint(0, int((end - start).total_seconds())))

def generar_estado():
    return "Activo" if random.random() < 0.9 else "Inactivo"

def generar_tipo_cliente():
    return "Individual" if random.random() < 0.9 else "Empresarial"

def generar_telefono():
    return f"+506{random.randint(60000000, 89999999)}"

def generar_correo(nombre_usuario):
    dominios = ["@gmail.com", "@hotmail.com", "@yahoo.com"]
    return f"{nombre_usuario}{random.choice(dominios)}"

direcciones_genericas = [
    "Calle 1 en Barrio Centro",
    "Avenida 3 en detrás del parque",
    "Frente a la iglesia principal",
    "Diagonal al supermercado La Favorita",
    "En la esquina del Banco Nacional",
]

provincias = [1, 2, 3, 4, 5, 6, 7]
pesos_provincias = [25, 15, 15, 15, 10, 10, 10]

clientes = []
id_cliente = 1
nombres_usados = set()

print(f"Inicia creacion de clientes. Hora: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

for _ in range(658113):
    id_provincia = random.choices(provincias, weights=pesos_provincias, k=1)[0]
    id_distrito = distritos_df[distritos_df["idProvincia"] == id_provincia].sample(n=1).iloc[0]["idDistrito"]

    while True:  # Genera nombres hasta que sean únicos
        primer_nombre = names.get_first_name()
        segundo_nombre = names.get_first_name()
        primer_apellido = names.get_last_name()
        segundo_apellido = names.get_last_name()

        nombre_completo = f"{primer_nombre} {segundo_nombre} {primer_apellido} {segundo_apellido}"

        if nombre_completo not in nombres_usados:
            nombres_usados.add(nombre_completo)
            break

    fecha_nacimiento = random_date(start_date, end_date).strftime("%Y-%m-%d %H:%M:%S")
    nombre_usuario = f"{primer_nombre[0]}{primer_apellido[:6]}{id_cliente}".lower()
    correo_cliente = generar_correo(nombre_usuario)
    telefono_cliente = generar_telefono()
    direccion_exacta = random.choice(direcciones_genericas)
    estado_cliente = generar_estado()
    tipo_cliente = generar_tipo_cliente()
    cedula = generar_cedula(id_provincia)
    
    clientes.append([
        id_cliente, cedula, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido,
        fecha_nacimiento, nombre_usuario, correo_cliente, telefono_cliente, direccion_exacta, tipo_cliente, estado_cliente, id_distrito
    ])
    
    if (_ + 1) % 10000 == 0:
        print(f"Se han generado {_ + 1} clientes... Hora: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

    id_cliente += 1 

print(f"Clientes generados, creando CSV. Hora: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

clientes_df = pd.DataFrame(clientes, columns=[
    "idCliente", "cedula", "primerNombre", "segundoNombre", "primerApellido", "segundoApellido",
    "fechaNacimiento", "nombreUsuario", "correoCliente", "telefonoCliente", "direccionExacta", "tipoCliente", "estadoCliente", "idDistrito"
])

clientes_df.to_csv(f"{path_data}\clientes.csv", index=False, header=False)
print(f"Archivo clientes.csv generado exitosamente. Hora: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
