import pandas as pd

# Define file paths
archivo_historial = "D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data\historialPaqueteria.csv"  # Update with the actual path
archivo_paqueteria = "D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data\paqueteria.csv"

# Read the CSV files without headers
df1 = pd.read_csv(archivo_historial, header=None)
df2 = pd.read_csv(archivo_paqueteria, header=None)

# Identify the timestamp columns
timestamp_cols_df1 = [2]  # Third column (index 2) contains timestamps
timestamp_cols_df2 = [2, 3, 4]  # Columns with timestamps in File 2

# Convert timestamp columns to datetime
for col in timestamp_cols_df1:
    df1[col] = pd.to_datetime(df1[col], format="%Y-%m-%d %H:%M:%S.%f")

for col in timestamp_cols_df2:
    df2[col] = pd.to_datetime(df2[col], format="%Y-%m-%d %H:%M:%S.%f")

# Merge both dataframes for processing
df_combined = pd.concat([df1, df2], ignore_index=True)

# Identify all timestamp columns
timestamp_cols = timestamp_cols_df1 + timestamp_cols_df2

# Find and adjust duplicate timestamps
for col in timestamp_cols:
    seen = {}
    for i in range(len(df_combined)):
        timestamp = df_combined.at[i, col]
        if timestamp in seen:
            # Add milliseconds to avoid duplication
            df_combined.at[i, col] += pd.Timedelta(milliseconds=len(seen[timestamp]))
            seen[timestamp].append(i)
        else:
            seen[timestamp] = [i]

# Save the updated files
df1_updated = df_combined.iloc[:len(df1)]
df2_updated = df_combined.iloc[len(df1):]

df1_updated.to_csv("D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data\historialPaqueteriaND.csv", index=False, header=False)
df2_updated.to_csv("D:\Portafolio Universidad\Portafolio de materias\VI Cuatrimestre\SC-602 - Data Warehouse y Base de Datos Multidimensionales\Proyecto\data\paqueteriaND.csv", index=False, header=False)

print("Duplicate timestamps adjusted. Updated files saved as 'file1_updated.csv' and 'file2_updated.csv'.")
