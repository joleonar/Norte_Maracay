rm .gmtcommands4
rm .gmtdefaults4

gmtset MEASURE_UNIT cm
gmtset FRAME_WIDTH .15
gmtset FRAME_PEN 1
gmtset PAPER_MEDIA A4
gmtset TICK_PEN 2
gmtset WANT_EURO_FONT FALSE
gmtset DOTS_PR_INCH 300
gmtset TICK_LENGTH 0.030
gmtset X_AXIS_LENGTH 5
gmtset Y_AXIS_LENGTH 8
gmtset HEADER_FONT_SIZE 16
gmtset GRID_CROSS_SIZE 0.1i BASEMAP_TYPE FANCY 
gmtset PLOT_DEGREE_FORMAT -D
#ddd:mm:ssF

ps="sismicidad_centro_zoom.ps"
r="-68.0/-67.3/10.3/10.75"
proj="m1:400000"

psbasemap -R$r -J$proj -Ba1f0.5:." ": -K -P > $ps

#grdimage  topov.grd -Itopov_int.grd -R$r  -J$proj -Cverde.cpt -E150 -O -K >> $ps
#grdcut ns-america.grd -Gvenezuela.grd -R-73.5/-60.0/0/13
#grdgradient venezuela.grd -A0 -Nt -Gvenez_int.grd
#grdimage  topov.grd -Ivenez_int.grd -R$r -J$proj -Cverde.cpt -E150 -O -K >> $ps

pscoast -R$r -J$proj -Df -W3.0 -Na -Ia/0.25p/0/94/144 -Ba.25f0.25:." ": -X4.0 -Y4.0 -G200 -K -L-67.40/10.38/10.32/10 >> $ps

psxy -M fallas_activas2012.txt -Jm -R -W5/255/0/0 -O -V -K  >> $ps
pstext -R -Jm -K -O << END >> $ps
-67.50  10.59  16 7 5 2 F. San Sebastian
END

gawk -F: '{print $2, $1}' c1r.txt | psxy -Jm -R -Sc0.8 -G0/0/0 -W5 -L -O -K >> $ps

psxy -Jm -R -Sd0.25 -G0/0/0 -W5 -L -O -K <<END>> $ps
-67.60 10.51
-67.73 10.49
END


pstext -R -Jm -K -O << END >> $ps
-66.92 10.45  12 0 5 2 Caracas  
-67.04 10.37  12 0 5 2 Los Teques
-67.60 10.28  12 0 5 2 Maracay 
-68.00 10.21  12 0 5 2 Valencia
-67.36 09.85  12 0 5 2 Sn Juan de los Morros
-67.60 10.48  12 0 5 2 Choroni
-67.73 10.46  12 0 5 2 B. de Cata
END


gawk -F: '{print $2, $1}' BBV.txt | psxy -Jm -R -St0.8 -G255/0/0 -W5 -L -O -K >> $ps

pstext -R -Jm -K -O << END >> $ps
-66.27 10.57   14 0 5 2 BIRV
-67.84 10.50   14 0 5 2 TURV
-66.81 10.56   14 0 5 2 FUNV
END

gawk '{print $8, $7}'  collect_1.txt | psxy -J$proj -R$r -Sc0.2 -G0/255/0  -W1 -L -O -K >> $ps

psxy -R -Jm -Sa0.5 -G255/0/0 -W1 -O -V -K << END >> $ps
-67.658 10.526
END

gmtset BASEMAP_TYPE PLAIN
r1="-73/-60/5/14.5"
proj1="m1:24000000"
pscoast -R$r1 -J$proj1 -Bwsen -V -Df -O -G255/255/190 -S150/245/240  -N1 -W -X.01 -Y.01>> $ps


gawk '$14*1.2 < 3.0 {print $9, $8}'  sismos_2011-2013_t.txt | psxy -J$proj -R$r -Sc0.04 -G0/255/0 -W -L -O -K >> $ps
gawk '$14*1.2 >= 3.0 && $14*1.2 < 4.0 {print $9, $8}'  sismos_2011-2013_t.txt | psxy -J$proj -R$r -Sc0.08 -G0/255/255 -W -L -O -K >> $ps
gawk '$14*1.2 >= 4.0 && $14*1.2 < 5.0 {print $9, $8}'  sismos_2011-2013_t.txt | psxy -J$proj -R$r -Sc0.12 -G255/255/0 -W -L -O -K >> $ps
gawk '$14*1.2 >= 5.0 {print $9, $8}'  sismos_2011-2013_t.txt | psxy -J$proj -R$r -Sc0.15 -G255/0/0 -W -L -O -K >> $ps



## LEYENDA
#echo -69.5  8.0 > cuadro
#echo -69.5  9.05 >> cuadro
#echo -68.0  9.05 >> cuadro
#echo -68.0  8.0 >> cuadro
#psxy cuadro -R -Jm -G255 -W5 -O -V -K -M  >> $ps
#rm cuadro

# mayor 5
#echo -69.4 8.9 | psxy -R -Jm -Sc0.16 -G255/0/0 -W1 -O -V -K >> $ps

# 4-4.9
#echo -69.4 8.7 | psxy -R -Jm -Sc0.14 -G255/255/0 -W1  -O -V -K >> $ps

# 3-3.9
#echo -69.4 8.5 | psxy -R -Jm -Sc0.12 -G0/255/255 -W1-L -O -V -K >> $ps

# <3
#echo -69.4 8.3 | psxy -R -Jm -Sc0.09 -G0/255/0 -W1-L -O -V -K >> $ps

#echo -69.45 8.135 > linea
#echo -69.20  8.135  >> linea
#psxy linea -R$r -J$proj -G255 -W6/255/0/0 -O -V -K -M  >> $ps
#rm linea

#echo -69.3  8.9 11 0 5 5 Magnitud mayor a 5.0 |pstext -R$r -J$proj -O -V -K >> $ps
#echo -69.3  8.7 11 0 5 5 Magnitud 4.0 - 4.9 |pstext -R$r -J$proj -O -V -K >> $ps
#echo -69.3  8.5 11 0 5 5 Magnitud 3.0 - 3.9 |pstext -R$r -J$proj -O -V -K >> $ps
#echo -69.3  8.3 11 0 5 5 Magnitud menor a 3.0  |pstext -R$r -J$proj -O -V -K >> $ps
#echo -69.1  8.1 11 0 5 1 Falla Geol  |pstext -R$r -J$proj -O -V >> $ps

gs $ps
