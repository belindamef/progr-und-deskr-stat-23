# Beispiel für simples Datenanalyseskript. 

# Directory and fname Management
work_dir = getwd()                               # Working directory
data_dir = file.path(work_dir, "Data")           # Datenverzeichnispfad
rawdata_fname = "cushny.csv"                     # (base) filename
fpath = file.path(data_dir, fname)               # filepath
outdata_fname = "descr_stats.txt"

# Read Data
Data_df = read.table(fpath)                      # Einlesen der Datei

# Compute and print descriptive statistics
print(summary(Data_df))                          # Deskriptive Statistik
