#!/bin/bash

#version 1.0 created on 8/29/2013
#version 1.1 modified on 8/30/2013

plot_results() {

blockmean sigma_c.dat $R  -I6m -V > sigma_r.dat
surface sigma_r.dat  -Ggm0.grd -I2m  -R -T0.2
grdgradient gm0.grd -Ggm0.shd  -Nt1 -A20
psbasemap $R $J -Ba4f2/5  -K -V -X2.0 -Y2.0i -P > $M
makecpt -Chaxby -I $T -Z > vel.cpt
grdimage gm0.grd  -Cvel.cpt  -R -J -O -V -K >> $M
grdcontour gm0.grd  -R -J -Cvel.cpt -B  -A-  -O -K -S6m -V >> $M
psxy edge_location.txt -R -J -O -K -G255 -L -W1 -V >> $M 
pscoast -Jm -R  -B -N2 -W4.0 -A5000  -O  -V -K >> $M
awk '{print "-75 30 20 0 1 BL Period:",$1"s"}' period > time.dat
pstext time.dat -R -J -P -O -K -V >> $M 
psscale -Cvel.cpt -D2i/-0.5i/5i/0.4ih -X1i -O  -V  -B0.2f0.1:"$text": -E >> $M
#psscale -Cvel.cpt -D2.2i/-0.5i/3.5i/0.2ih -X1i -O  -V  -B0.5f0.25/:"km/s": -E >> $M

}


#----R and T need to be adjusted for each earthquake-----
#----phase velocity-----
M=`awk '{print "average_dyna_"$1"s.ps"}' period` 
text="Average dynamical phase velocity(km/s)"
R="-R-95/-65/24/50"
J="-Jm0.5"
T="-T3.5/4.5/0.1"
awk '{if($4>=3.5 && $4<=4.5) print $2,$3,$4}' final_dyna > sigma_c.dat
plot_results

M=`awk '{print "average_stru_"$1"s.ps"}' period` 
text="Average structural phase velocity(km/s)"
R="-R-95/-65/24/50"
J="-Jm0.5"
T="-T3.5/4.5/0.1"
awk '{if($4>=3.5 && $4<=4.5) print $2,$3,$4}' final_stru > sigma_c.dat
plot_results

rm sigma_* gm0.* time.dat vel.cpt
mv *ps plots

