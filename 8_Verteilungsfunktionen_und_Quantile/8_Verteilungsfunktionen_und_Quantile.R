# Beispiellösung für Selbstkontrollfragen aus Einheit (8) "Verteilungsfunktionen
# und Quantile" des Kurses "Programmierung und Deskriptive Statistik" im WS 22/23
#
# author: Belinda Fleischmann

# Directory management
work_dir = getwd()                                   # Working directory
data_dir = file.path(work_dir, "Data")               # Datenverzeichnispfad
fig_dir = file.path(work_dir, "Figures")             # Figures-Verzeichnispfad
rawdata_fname = "psychotherapie_datensatz.csv"       # (base) Daten filename
rawdata_fpath = file.path(data_dir, rawdata_fname)   # Rohdaten Dateipfad (Input)

# Output-Ordner erstellen, falls nicht existent
if (!file.exists(fig_dir)){
 dir.create(fig_dir)
}

# Import data
Data_df =  read.table(rawdata_fpath, sep = ",", header = T)

# ------SKF 2) Plot Häufigkeitsverteilung Post-BDI------------------------------
graphics.off()                      # Schließt alle eventuell noch offenen graphics devices

# Datensatz vorbereiten
post_bdi = Data_df$Post.BDI         # Post-BDI Werte aus Dataframe in einen Vektor kopieren

# Plot parameter defineren 
x_min   = 12                        # x-Achsenlimit
x_max   = 25                        # x-Achsenlimit
y_min   = 0                         # y-Achsenlimit
y_max   = 45                        # y-Achsenlimit

# Histogramm erzeugen
hist(                               # Histogramm
  post_bdi,                         # Datensatz, für den ein Histogramm erstellt werden soll
  xlim  = c(x_min, x_max),          # x Achsen Limits
  ylim  = c(y_min, y_max),          # y Achsen Limits
  ylab  = "Häufigkeit",             # y-Achsenbezeichnung
  xlab  = "",                       # x-Achsenbezeichnung
  main  = "Post-BDI"                # Titel
  )

# Diagramm als PDF speichern
dev.copy2pdf(            
  file  = file.path(fig_dir, "7_skf_2_hist_post_bdi.pdf"), 
  width = 8, height = 5
  )   


# ------SKF 4) Plot Empirische Verteilungsfunktion Post-BDI---------------------

