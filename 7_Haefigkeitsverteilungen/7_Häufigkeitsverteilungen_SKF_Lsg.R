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

# Vorbereitung des Wertes für das hist() Inputargument "breaks = ": 

# Für die Berechnung von Klassenbreiten benötigen wir zunächst die min/max Werte
# und die Anzahl der Datenpunkte
b_0_klassisch     = min(bdi_diff_klassisch)    # b_0 (min Wert)
b_k_klassisch     = max(bdi_diff_klassisch)    # b_k (max Wert)
b_0_online        = min(bdi_diff_online)       # b_0 (min Wert)
b_k_online        = max(bdi_diff_online)       # b_k (max Wert)
n_klassisch       = length(bdi_diff_klassisch) # Anzahl Datenwerte
n_online          = length(bdi_diff_online)    # Anzahl Datenwerte

# a) Gewünschte Klassebreite von 3
h              = 3                                       # gewünschte Klassenbreite
b_h3_klassisch = seq(b_0_klassisch, b_k_klassisch, by = h) # Klassen [b_{j-1}, b_j[
b_h3_online    = seq(b_0_online, b_k_online, by = h)       # Klassen [b_{j-1}, b_j[

# b) Excelstandard
k_klassisch       = ceiling(sqrt(n_klassisch))   # Anzahl der Klassen
k_online          = ceiling(sqrt(n_online))      # Anzahl der Klassen
b_excel_klassisch = seq(b_0_klassisch, b_k_klassisch, len = k_klassisch)
b_excel_online    = seq(b_0_online, b_k_online, len = k_online)

# c) Sturges Klassenzahl
k_klassisch         = ceiling(log2(n_klassisch) + 1)   # Anzahl der Klassen
k_online            = ceiling(log2(n_online) + 1)      # Anzahl der Klassen
b_sturges_klassisch = seq(b_0_klassisch, b_k_klassisch, len = k_klassisch)
b_sturges_online   = seq(b_0_online, b_k_online, len = k_online)

# d) Scott Klassenzahl (geg.: h)
S_klassisch       = sd(bdi_diff_klassisch)                               # Stichprobenstandardabweichung
S_online          = sd(bdi_diff_online)                                  # Stichprobenstandardabweichung
h_klassisch       = ceiling(3.49*S_klassisch/(n_klassisch^(1/3)))        # Klassenbreite
h_online          = ceiling(3.49*S_online/(n_online^(1/3)))              # Klassenbreite
k_klassisch       = ceiling((b_k_klassisch - b_0_klassisch)/h_klassisch) # Anzahl der Klassen
k_online          = ceiling((b_k_online - b_0_online)/h_online)          # Anzahl der Klassen
b_scott_klassisch = seq(b_0_klassisch, b_k_klassisch, len = k_klassisch)
b_scott_online    = seq(b_0_online, b_k_online, len = k_online)


# Damit wir die gleichen Befehle zur Histogramm-erzeugung nicht 4x wiederholen müssen, 
# erzeugen wir für verschiedene Ansätze (a bis d) Listen, durch die wir mit
# for-loops durchiterieren können. 
breaks_list_klassisch = list(
  "h3"            = b_h3_klassisch,
  "Excelstandard" = b_excel_klassisch,
  "Sturges"       = b_sturges_klassisch,
  "Scott"         = b_scott_klassisch
  )
breaks_list_online = list(
  "h3"            = b_h3_online,
  "Excelstandard" = b_excel_online,
  "Stuges"        = b_sturges_online,
  "Scott"         = b_scott_online
  )

# Plot Histogramm - Klassisch
for (breaks_method_name in names(breaks_list_klassisch)) {
  graphics.off()
  
  # Histogramm plotten
  hist(                                                    # Histogramm
    bdi_diff_klassisch,                                    # Datensatz, für den ein Histogramm erstellt werden soll
    breaks = breaks_list_klassisch[[breaks_method_name]],  # breaks
    xlim   = c(x_min, x_max),                              # x Achsen Limits
    ylim   = c(y_min, y_max),                              # y Achsen Limits
    ylab   = "Häufigkeit",                                 # y-Achsenbezeichnung
    xlab   = "",                                           # x-Achsenbezeichnung
    main   = paste("Post-Pre-BDI Differenz (Klassisch),", 
                   breaks_method_name)
    )  
  
  # Diagramm als PDF speichern
  dev.copy2pdf(            
    file  = file.path(fig_dir, paste("7_skf_8_hist_diff_bdi_klassisch_",
                                     breaks_method_name, ".pdf", sep = "")), 
    width = 8, height = 5
    )  
  }

# Plot Histogramm - Online
for (breaks_method_name in names(breaks_list_online)) {
  graphics.off()
  
  # Histogramm plotten
  hist(                                                    # Histogramm
    bdi_diff_online,                                       # Datensatz, für den ein Histogramm erstellt werden soll
    breaks = breaks_list_online[[breaks_method_name]],  # breaks
    xlim   = c(x_min, x_max),                              # x Achsen Limits
    ylim   = c(y_min, y_max),                              # y Achsen Limits
    ylab   = "Häufigkeit",                                 # y-Achsenbezeichnung
    xlab   = "",                                           # x-Achsenbezeichnung
    main   = paste("Post-Pre-BDI Differenz (Online),", 
                   breaks_method_name)
  )  
  
  # Diagramm als PDF speichern
  dev.copy2pdf(            
    file  = file.path(fig_dir, paste("7_skf_8_hist_diff_bdi_online_",
                                     breaks_method_name, ".pdf", sep = "")), 
    width = 8, height = 5
  )  
}

#------
graphics.off()                   # Schließt alle eventuell noch offenen graphics devices