# Beispiellösung für Selbstkontrollfragen aus Einheit (7) "Häufigkeitsverteilungen"
# des Kurses "Programmierung und Deskriptive Statistik" im WS 22/23
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

# ------SKF 3) Plot Häufigkeitsverteilung Pre-Post-Diff-BDI---------------------
graphics.off()                      # Schließt alle eventuell noch offenen graphics devices

# Datensatz vorbereiten
pre_bdi = Data_df$Pre.BDI           # pre-BDI Werte aus Dataframe in einen Vektor kopieren
bdi_diff = post_bdi -pre_bdi        # Pre-post-BDI Differenzen berechnen und in einem Vektor speichern

# Plot parameter defineren 
x_min   = -14                       # x-Achsenlimit
x_max   = 14                        # x-Achsenlimit
y_min   = 0                         # y-Achsenlimit
y_max   = 45                        # y-Achsenlimit

# Histogramm erzeugen
hist(                               # Histogramm
  bdi_diff,                         # Datensatz, für den ein Histogramm erstellt werden soll
  xlim  = c(x_min, x_max),          # x Achsen Limits
  ylim  = c(y_min, y_max),          # y Achsen Limits
  ylab  = "Häufigkeit",             # y-Achsenbezeichnung
  xlab  = "",                       # x-Achsenbezeichnung
  main  = "Post-Pre BDI-Differenz"  # Titel
  )  

# Diagramm als PDF speichern
dev.copy2pdf(            
  file  = file.path(fig_dir, "7_skf_3_hist_diff_bdi.pdf"), 
  width = 8, height = 5
)   

# ------SKF 4) Plot Häufigkeitsverteilung Pre-Post-Diff-BDI------
graphics.off()                     # Schließt alle offenen graphics devices

# Datensätze vorbereiten
pre_bdi_klassisch = Data_df$Pre.BDI[Data_df$Bedingung == "Klassisch"] 
pre_bdi_online = Data_df$Pre.BDI[Data_df$Bedingung == "Online"] 
post_bdi_klassisch = Data_df$Post.BDI[Data_df$Bedingung == "Klassisch"] 
post_bdi_online = Data_df$Post.BDI[Data_df$Bedingung == "Online"] 
bdi_diff_klassisch = post_bdi_klassisch - pre_bdi_klassisch    
bdi_diff_online = post_bdi_online - pre_bdi_online

# Plot parameter defineren 
x_min   = -14                      # x-Achsenlimit
x_max   = 14                       # x-Achsenlimit
y_min   = 0                        # y-Achsenlimit
y_max   = 45                       # y-Achsenlimit

# Histogramme erzeugen
# --------------------

# Klassisch
hist(                              # Histogramm
  bdi_diff_klassisch,              # Datensatz, für den ein Histogramm erstellt werden soll
  xlim  = c(x_min, x_max),         # x Achsen Limits
  ylim  = c(y_min, y_max),         # y Achsen Limits
  ylab  = "Häufigkeit",            # y-Achsenbezeichnung
  xlab  = "",                      # x-Achsenbezeichnung
  main  = "Post-Pre-BDI Differenz (Klassisch)" # Titel
  )  

# Diagramm als PDF speichern
dev.copy2pdf(            
  file  = file.path(fig_dir, "7_skf_4_hist_diff_bdi_klassisch.pdf"), 
  width = 8, height = 5
  )  

# Online
hist(                             # Histogramm
  bdi_diff_online,                # Datensatz, für den ein Histogramm erstellt werden soll
  xlim  = c(x_min, x_max),        # x Achsen Limits
  ylim  = c(y_min, y_max),        # y Achsen Limits
  ylab  = "Häufigkeit",           # y-Achsenbezeichnung
  xlab  = "",                     # x-Achsenbezeichnung
  main  = "Post-Pre-BDI Differenz (Online)" # Titel
  )  

# Diagramm als PDF speichern
dev.copy2pdf(            
  file  = file.path(fig_dir, "7_skf_3_hist_diff_bdi_online.pdf"), 
  width = 8, height = 5
  )


# ------SKF 8) Plot Häufigkeitsverteilung Pre-Post-Diff-BDI---------------------

# -----------------------------------------------------------------
#     Histogramm mit gewünschter Klassenbreite von 3 (geg.: h)
# ----------------------------------------------------------------

# Vorbereitung des Wertes für das hist() Inputargument "breaks = "
h       = 1                        # gewünschte Klassenbreite
b_0     = min(bdi_diff_klassisch)  # b_0
b_k     = max(bdi_diff_klassisch)  # b_k
k       = ceiling((b_k - b_0)/h)   # Anzahl der Klassen (Wird nicht benötigt)
b       = seq(b_0, b_k, by = h)    # Klassen [b_{j-1}, b_j[

# Klassisch
hist(                              # Histogramm
  bdi_diff_klassisch,              # Datensatz, für den ein Histogramm erstellt werden soll
  breaks = b,                      # breaks
  xlim   = c(x_min, x_max),        # x Achsen Limits
  ylim   = c(y_min, y_max),        # y Achsen Limits
  ylab   = "Häufigkeit",           # y-Achsenbezeichnung
  xlab   = "",                     # x-Achsenbezeichnung
  main   = "Post-Pre-BDI Differenz (Klassisch), h = 3" # Titel
)  

# Diagramm als PDF speichern
dev.copy2pdf(            
  file  = file.path(fig_dir, "7_skf_8_hist_diff_bdi_klassisch_h3.pdf"), 
  width = 8, height = 5
)  

# Online
hist(                             # Histogramm
  bdi_diff_online,                # Datensatz, für den ein Histogramm erstellt werden soll
  breaks = b,                     # breaks
  xlim   = c(x_min, x_max),       # x Achsen Limits
  ylim   = c(y_min, y_max),       # y Achsen Limits
  ylab   = "Häufigkeit",          # y-Achsenbezeichnung
  xlab   = "",                    # x-Achsenbezeichnung
  main   = "Post-Pre-BDI Differenz (Online), h = 3" # Titel
)  

# Diagramm als PDF speichern
dev.copy2pdf(            
  file  = file.path(fig_dir, "7_skf_5_hist_diff_bdi_online_h3.pdf"), 
  width = 8, height = 5
)

# -------------------------------------------------------------
#     Histogramm nach Excelstandard (geg.: k)
# -------------------------------------------------------------
graphics.off()

# Vorbereitung des Wertes für das hist() Inputargument "breaks = "
n        = length(x)               # Anzahl Datenwerte
k        = ceiling(sqrt(n))        # Anzahl der Klassen
b        = seq(b_0, b_k, len = k)  # Klassen [b_{j-1}, b_j[
h        = b[2] - b[1]             # Klassenbreite (Wird nicht benötigt)

# Klassisch
hist(                              # Histogramm
  bdi_diff_klassisch,              # Datensatz, für den ein Histogramm erstellt werden soll
  breaks = b,                      # breaks
  xlim   = c(x_min, x_max),        # x Achsen Limits
  ylim   = c(y_min, y_max),        # y Achsen Limits
  ylab   = "Häufigkeit",           # y-Achsenbezeichnung
  xlab   = "",                     # x-Achsenbezeichnung
  main   = "Post-Pre-BDI Differenz (Klassisch), Excelstandard" # Titel
)  

# Diagramm als PDF speichern
dev.copy2pdf(            
  file  = file.path(fig_dir, "7_skf_8_hist_diff_bdi_klassisch_excel.pdf"), 
  width = 8, height = 5
)  

# Online
hist(                             # Histogramm
  bdi_diff_online,                # Datensatz, für den ein Histogramm erstellt werden soll
  breaks = b,                     # breaks
  xlim  = c(x_min, x_max),        # x Achsen Limits
  ylim  = c(y_min, y_max),        # y Achsen Limits
  ylab  = "Häufigkeit",           # y-Achsenbezeichnung
  xlab  = "",                     # x-Achsenbezeichnung
  main  = "Post-Pre-BDI Differenz (Online), Excelstandard" # Titel
)  

# Diagramm als PDF speichern
dev.copy2pdf(            
  file  = file.path(fig_dir, "7_skf_5_hist_diff_bdi_online_excel.pdf"), 
  width = 8, height = 5
)

# --------------------------------------------------------------
#     Histogramm mit Sturges Klassenzahl (geg.: k)
# --------------------------------------------------------------
graphics.off()

# Vorbereitung des Wertes für das hist() Inputargument "breaks = "
n        = length(x)               # Anzahl Datenwerte
k        = ceiling(log2(n)+1)      # Anzahl der Klassen
b        = seq(b_0, b_k, len = k)  # Klassen [b_{j-1}, b_j[
h        = b[2] - b[1]             # Klassenbreite (wird nicht benötigt)

# Klassisch
hist(                              # Histogramm
  bdi_diff_klassisch,              # Datensatz, für den ein Histogramm erstellt werden soll
  breaks = b,                      # breaks
  xlim   = c(x_min, x_max),        # x Achsen Limits
  ylim   = c(y_min, y_max),        # y Achsen Limits
  ylab   = "Häufigkeit",           # y-Achsenbezeichnung
  xlab   = "",                     # x-Achsenbezeichnung
  main   = "Post-Pre-BDI Differenz (Klassisch), Sturges" # Titel
)  

# Diagramm als PDF speichern
dev.copy2pdf(            
  file  = file.path(fig_dir, "7_skf_8_hist_diff_bdi_klassisch_sturges.pdf"), 
  width = 8, height = 5
)  

# Online
hist(                             # Histogramm
  bdi_diff_online,                # Datensatz, für den ein Histogramm erstellt werden soll
  breaks = b,                     # breaks
  xlim  = c(x_min, x_max),        # x Achsen Limits
  ylim  = c(y_min, y_max),        # y Achsen Limits
  ylab  = "Häufigkeit",           # y-Achsenbezeichnung
  xlab  = "",                     # x-Achsenbezeichnung
  main  = "Post-Pre-BDI Differenz (Online), Sturges" # Titel
)  

# Diagramm als PDF speichern
dev.copy2pdf(            
  file  = file.path(fig_dir, "7_skf_5_hist_diff_bdi_online_sturges.pdf"), 
  width = 8, height = 5
)



# --------------------------------------------------------------
#     Histogramm mit Scott Klassenzahl (geg.: h)
# --------------------------------------------------------------
graphics.off()

# Vorbereitung des Wertes für das hist() Inputargument "breaks = "
n        = length(x)                 # Anzahl Datenwerte
S        = sd(x)                     # Stichprobenstandardabweichung
h        = ceiling(3.49*S/(n^(1/3))) # Klassenbreite
k        = ceiling((b_k - b_0)/h)    # Anzahl der Klassen
b        = seq(b_0, b_k, len = k)    # Klassen [b_{j-1}, b_j[
h        = b[2] - b[1]               # Klassenbreite
 
# Klassisch
hist(                                # Histogramm
  bdi_diff_klassisch,                # Datensatz, für den ein Histogramm erstellt werden soll
  breaks = b,                        # breaks
  xlim   = c(x_min, x_max),          # x Achsen Limits
  ylim   = c(y_min, y_max),          # y Achsen Limits
  ylab   = "Häufigkeit",             # y-Achsenbezeichnung
  xlab   = "",                       # x-Achsenbezeichnung
  main   = "Post-Pre-BDI Differenz (Klassisch), Scott" # Titel
)  

# Diagramm als PDF speichern
dev.copy2pdf(            
  file  = file.path(fig_dir, "7_skf_8_hist_diff_bdi_klassisch_scott.pdf"), 
  width = 8, height = 5
)  

# Online
hist(                                # Histogramm
  bdi_diff_online,                   # Datensatz, für den ein Histogramm erstellt werden soll
  breaks = b,                        # breaks
  xlim  = c(x_min, x_max),           # x Achsen Limits
  ylim  = c(y_min, y_max),           # y Achsen Limits
  ylab  = "Häufigkeit",              # y-Achsenbezeichnung
  xlab  = "",                        # x-Achsenbezeichnung
  main  = "Post-Pre-BDI Differenz (Online), Scott" # Titel
)  

# Diagramm als PDF speichern
dev.copy2pdf(            
  file  = file.path(fig_dir, "7_skf_5_hist_diff_bdi_online_scott.pdf"), 
  width = 8, height = 5
)




#------
graphics.off()                   # Schließt alle eventuell noch offenen graphics devices