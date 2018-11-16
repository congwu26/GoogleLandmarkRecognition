#!/bin/bash

rm -rf ../train ../test ../valid
mkdir ../train ../test ../valid
for d in */ ; do
    cd $d
    class=0
    num=$(ls -l | grep -v ^d | wc -l)
    if [ $num -ge 200 ] && [ $num -le 300 ]; then
    	mkdir ../../train/$d
    	mkdir ../../valid/$d
        mkdir ../../test/$d
        ((class++))
    	count=0
        thread_test=10
        thread_valid=50
        for file in * ; do
        	if (( count < thread_test)); then
        	    cp $file ../../test/$d
        	    ((count++))
        	elif (( count < thread_valid )); then
        		cp $file ../../valid/$d
        	    ((count++))
            else
                cp $file ../../train/$d
                ((count++))
        	fi
        done
        echo $d
        echo $count
    fi
    cd ..
done
echo $class