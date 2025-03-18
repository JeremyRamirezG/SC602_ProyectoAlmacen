import csv

input_file = "D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data\paqueteriaND.csv"  # Replace with your CSV file
output_file = "D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data\paqueteriaNDc.csv"  # Output file with integers

with open(input_file, "r", newline="") as infile, open(output_file, "w", newline="") as outfile:
    reader = csv.reader(infile)
    writer = csv.writer(outfile)

    for row in reader:
        cleaned_row = []
        for i, value in enumerate(row):
            # Check if the value is a decimal and should be converted
            if i >= 5 and value.replace('.', '', 1).isdigit() and '.' in value:  # Only convert from column 6 onwards
                cleaned_row.append(str(int(float(value))))
            else:
                cleaned_row.append(value)

        writer.writerow(cleaned_row)

print(f"Cleaned CSV saved as {output_file}")
