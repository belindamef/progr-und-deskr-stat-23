# Beispiel für simples Datenanalyseskript. 

# Directory and file name Management
work_dir = getwd()                               # Working directory
data_dir = file.path(work_dir, "Data")           # Datenverzeichnispfad
results_dir = file.path(work_dir, "Results")     # Ergebnisverzeichnispfad
rawdata_fname = "cushny.csv"                     # (base) Daten filename
rawdata_fpath = file.path(data_dir, fname)       # Rohdaten Dateipfad (Input)
out_fname = "descr_stats.csv"                    # (base) Results filename
out_fpath = file.path(results_dir, out_fname)    # Ergebnisse Dateipfad (Output)

# Read Data
Data_df = read.table(rawdata_fpath)              # Einlesen der Datei

# Compute and print descriptive statistics
descr_stats = summary(Data_df)                   # Deskriptive Statistiken berechnen
print(descr_stats)                               # Ergebnisse ausgeben

# Save results
write.table(descr_stats,                         # Daten, die gespeichert werden sollen
  file = out_fpath,                              # Pfad/Dateiname (Speicherort)
  sep = ",",                                     # Werteseperator (hier: Kommata, weil csv)
  row.names = F)                                 # keine Zeilennamen
