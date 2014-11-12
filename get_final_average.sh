#!/bin/bash

cd slowness_all
#get average slowness
./vel_stack.py

cd ../all_stations
#get locations and velocity
for i in 1 2 3 4 5 6 7 8 9 10 12 14 16 18 20
do
	awk '{print "saclst stlo stla f *"$1"*"}' ../slowness_all/dyna_slowness_ave_$i | sh > 1
	paste 1 ../slowness_all/dyna_slowness_ave_$i | awk '{print $1,$2,$3,1/$5}' > ../plots/final_dyna_$i
	awk '{print "saclst stlo stla f *"$1"*"}' ../slowness_all/stru_slowness_ave_$i | sh > 1
	paste 1 ../slowness_all/stru_slowness_ave_$i | awk '{print $1,$2,$3,1/$5}' > ../plots/final_stru_$i
done

#plot
cd ../plots
for j in 1 2 3 4 5 6 7 8 9 10 12 14 16 18 20
do
	cp period_$j period
	cp final_dyna_$j final_dyna
	cp final_stru_$j final_stru
	./plot_final.sh
done
cd ..

