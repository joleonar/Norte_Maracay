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

ps="sismicidad_centro.ps"
r="-68.5/-66.0/9.5/11.5"
proj="m1:1400000"

psbasemap -R$r -J$proj -Ba1f0.5:." ": -K -P > $ps

#grdimage  topov.grd -Itopov_int.grd -R$r  -J$proj -Cverde.cpt -E150 -O -K >> $ps
#grdcut ns-america.grd -Gvenezuela.grd -R-73.5/-60.0/0/13
#grdgradient venezuela.grd -A0 -Nt -Gvenez_int.grd
#grdimage  topov.grd -Ivenez_int.grd -R$r -J$proj -Cverde.cpt -E150 -O -K >> $ps

pscoast -R$r -J$proj -Df -W3.0 -Na -Ia/0.25p/0/94/144 -Ba1f0.5:." ": -T-66.5/11.1/2.0/3.0 -X4.0 -Y3.0 -G200 -K -L-66.5/9.6/9.6/50 >> $ps

#psxy -M fallas.txt -Jm -R -W5/255/0/0 -O -V -K  >> $ps
psxy -M fallas_activas2012.txt -Jm -R -W5/255/0/0 -O -V -K  >> $ps


gawk -F: '{print $2, $1}' capitales.txt | psxy -Jm -R -Sd0.3 -G0/0/0 -W5 -L -O -K >> $ps
#psxy -Jm -R -Sd0.25 -G0/0/0 -W5 -L -O -K <<END>> $ps
#-67.60 10.51
#-67.73 10.49
#END


pstext -R -Jm -K -O << END >> $ps
-66.92 10.54  12 0 5 2 Caracas  
-67.04 10.28  12 0 5 2 Los Teques
-67.60 10.28  12 0 5 2 Maracay 
-68.00 10.21  12 0 5 2 Valencia
-67.36 09.85  12 0 5 2 Sn Juan de los Morros
#-67.60 10.48  12 0 5 2 Choroni
#-67.73 10.46  12 0 5 2 B. de Cata
END

gawk -F: '{print $2, $1}' BBV.txt | psxy -Jm -R -St0.4 -G255/0/0 -W5 -L -O -K >> $ps
#gawk -F: '{print $5, $4, 14, 0, 5, 2,$3}' BBV.txt | pstext -Jm -R -G0 -O -K  >> $ps
pstext -R -Jm -K -O << END >> $ps
-66.27 10.40   14 0 5 2 BIRV
-67.84 10.36   14 0 5 2 TURV
-66.81 10.38   14 0 5 2 FUNV
END

gawk '$7>=10.4 {print $8, $7}'  collect_2.txt | psxy -J$proj -R$r -Sc0.2 -G0/255/255 -W2.0 -L -O -K >> $ps
gawk '$7< 10.4 {print $8, $7}'  collect_2.txt | psxy -J$proj -R$r -Sc0.2 -G0/255/0 -W2.0 -L -O -K >> $ps


gmtset BASEMAP_TYPE PLAIN
r1="-73/-60/5/14.5"
proj1="m1:24000000"
pscoast -R$r1 -J$proj1 -Bwsen -V -Df -O -G200 -S255  -N1 -W3.0 -X.01 -Y.01 -K >> $ps

psxy -R$r1 -J$proj1 -O -V -L -W5/255/0/0 << END >>  $ps 
-68.5  11.5
-66.0  11.5
-66.0  9.5  
-68.5  9.5
END

#gawk '$14*1.2 < 3.0 {print $9, $8}'  sismos_2011-2013_t.txt | psxy -J$proj -R$r -Sc0.3 -G0/255/0 -W -L -O -K >> $ps
#gawk '$14*1.2 >= 3.0 && $14*1.2 < 4.0 {print $9, $8}'  sismos_2011-2013_t.txt | psxy -J$proj -R$r -Sc0.3 -G0/255/255 -W -L -O -K >> $ps
#gawk '$14*1.2 >= 4.0 && $14*1.2 < 5.0 {print $9, $8}'  sismos_2011-2013_t.txt | psxy -J$proj -R$r -Sc0.4 -G255/255/0 -W -L -O -K >> $ps
#gawk '$14*1.2 >= 5.0 {print $9, $8}'  sismos_2011-2013_t.txt | psxy -J$proj -R$r -Sc0.5 -G255/0/0 -W -L -O -K >> $ps



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
