input_file = "D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data\historialPaqueteriaND.csv"   # Replace with your CSV file
output_file = "D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data\historialPaqueteriaNDc.csv"  # Output file without trailing commas

with open(input_file, "r") as infile, open(output_file, "w") as outfile:
    for line in infile:
        cleaned_line = line.rstrip(",\n") + "\n"  # Remove trailing commas
        outfile.write(cleaned_line)

print(f"Cleaned CSV saved as {output_file}")
