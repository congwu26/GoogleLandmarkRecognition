#!/bin/bash

for d in */ ; do
	echo $d
    cd $d
    num=$(ls -l | grep -v ^d | wc -l)
    if [ $num -ge 20 ]; then
    	mkdir ../../train/$d
    	mkdir ../../valid/$d
    	count=0
    	((thre=num / 4))
        for file in * ; do
        	if (( count > thre)); then
        	    cp $file ../../train/$d
        	    ((count++))
        	else
        		cp $file ../../valid/$d
        	    ((count++))
        	fi
        done
    fi
    cd ..
done
