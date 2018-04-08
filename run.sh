#!/bin/bash


for i in $@ ; do
	tail -n +2 "$i" > "$i.tmp" && mv "$i.tmp" "$i"
	z=$(sort -n $i | sed -ne "$(($((wc -l))/2+1))p")
	echo "median is $z"
	gnuplot -e "set terminal png ; set output '$i.png' ; plot '$i' with line"
done
