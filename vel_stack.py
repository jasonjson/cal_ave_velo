#!/usr/bin/env python

import sys

def stack_velo(infile,outfile):
    f = open(infile,'r')
    lines = f.readlines()
    dyna = {}
    for line in lines:
        # slicing string, the whole line is a string, not a list
        sta = line[0:4]
        slow = line[5:]
        print slow
        #remove large or small slowness values, velo between 3.5 and 4.5
        if float(slow) < 0.2222 or float(slow) > 0.2857:
            continue
        else:
            if sta not in dyna.keys():
                #make sure the values are list, so we can append new value to it next step
                dyna[sta] =  [slow,]
            elif slow == 'nan':
                continue
            else:
                dyna[sta].append(slow)
    dyna_ave = {}
    for key,values in dyna.items():
        #must put count sum_slowness here, so it will keep the value (0) for each new iteration
        count = 0
        sum_slowness = 0
        for value in values:
            sum_slowness += float(value)
            count += 1
        dyna_ave[key] = sum_slowness / count
    outf = open(outfile,'w')
    for key,value in dyna_ave.items():
        outf.write(key + ' '+ str(value) + '\n')
    outf.close 

stack_velo('stru_slowness_1','dyna_slowness_stru_1')
#def main():
#    for i in [1,2,3,4,5,6,7,8,9,10,12,14,16,18,20]:
#        stack_velo('dyna_slowness_'+str(i),'dyna_slowness_ave_'+str(i))
#        stack_velo('stru_slowness_'+str(i),'stru_slowness_ave_'+str(i))
#    try:
#        arg = sys.argv[1]
#    except:
#        print "Error: missing flag; usage: --dyna or --stru"
#        sys.exit(1)
#    else:
#        if arg == '--dyna':
#            stack_velo('dyna_slowness','dyna_slowness_ave')
#        elif arg == '--stru':
#            stack_velo('stru_slowness','stru_slowness_ave')

if __name__ == '__main__':
    main()
