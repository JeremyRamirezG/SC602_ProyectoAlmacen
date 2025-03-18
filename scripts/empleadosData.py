import pandas as pd
import random
import names
from datetime import datetime, timedelta

path_data = "D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data"
oficinas_df = pd.read_csv(f"{path_data}\script_oficinasProvincia.csv")  # Contiene idProvincia, idOficina
distritos_df = pd.read_csv(f"{path_data}\script_distritosProvincia.csv")  # Contiene idProvincia, idDistrito

def generar_cedula(id_provincia):
    return f"{id_provincia}{random.randint(10000000, 99999999)}"

start_date = datetime(1965, 1, 1)
end_date = datetime(2006, 12, 31)

def random_date(start, end):
    return start + timedelta(seconds=random.randint(0, int((end - start).total_seconds())))

def generar_telefono():
    return f"+506{random.randint(60000000, 89999999)}"

def generar_estado():
    return "Activo" if random.random() < 0.9 else "Inactivo"

direcciones_genericas = [
    "Calle 1 en Barrio Centro",
    "Avenida 3 en detrás del parque",
    "Frente a la iglesia principal",
    "Diagonal al supermercado La Favorita",
    "En la esquina del Banco Nacional",
]

empleados = []
id_empleado = 1

for _, oficina in oficinas_df.iterrows():
    id_provincia = oficina["idProvincia"]
    id_oficina = oficina["idOficina"]
    num_empleados = random.choices(
        population=list(range(5, 45)),  # Valores posibles
        weights=[3]*10 + [5]*20 + [1]*10,   # Pesos (más probabilidad para <20)
        k=1
    )[0]
    
    for _ in range(num_empleados):
        id_distrito = distritos_df[distritos_df["idProvincia"] == id_provincia].sample(n=1).iloc[0]["idDistrito"]
        
        primer_nombre = names.get_first_name()
        segundo_nombre = names.get_first_name()
        primer_apellido = names.get_last_name()
        segundo_apellido = names.get_last_name()
        fecha_nacimiento = random_date(start_date, end_date).strftime("%Y-%m-%d %H:%M:%S")
        nombre_usuario = f"{primer_nombre[0]}{primer_apellido[:6]}{id_empleado}".lower()
        correo_empleado = f"{nombre_usuario}@correossj.cr"
        telefono_empleado = generar_telefono()
        direccion_exacta = random.choice(direcciones_genericas)
        estado_empleado = generar_estado()
        cedula = generar_cedula(id_provincia)
        
        empleados.append([
            id_empleado, cedula, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido,
            fecha_nacimiento, nombre_usuario, telefono_empleado, correo_empleado,
            direccion_exacta, estado_empleado, id_distrito, id_oficina
        ])
        
        id_empleado += 1  # Incrementar ID de empleado

# Crear DataFrame y guardar CSV
empleados_df = pd.DataFrame(empleados, columns=[
    "idEmpleado", "cedula", "primerNombre", "segundoNombre", "primerApellido", "segundoApellido",
    "fechaNacimiento", "nombreUsuario", "telefonoEmpleado", "correoEmpleado",
    "direccionExacta", "estadoEmpleado", "idDistrito", "idOficina"
])

empleados_df.to_csv(f"{path_data}\empleados.csv", index=False, header=False)
print("Archivo empleados.csv generado exitosamente.")