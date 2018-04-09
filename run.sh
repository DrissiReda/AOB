#!/bin/bash
mkdir -p graphics
echo '' > med.csv
i=$1
#tail -n +2 "$i" > "$i.tmp" && mv "$i.tmp" "$i"
z=$(sort -n $i | sed -ne "$(($((wc -l))/2+1))p")
y=$(echo "$i"| sed 's/\.[^.]*$//' | sed 's/\.[^.]*$//')
echo "median is $z"
echo "$y $z" >> med.csv
#cat -n "$i" > "$i.tmp" && mv "$i.tmp" "$i"
gnuplot -e "set terminal png ; set output 'graphics/$y.png' ; plot '$i' with line ;"
x=$1
shift
for i in $@ ; do
	#tail -n +2 "$i" > "$i.tmp" && mv "$i.tmp" "$i"
	z=$(sort -n $i | sed -ne "$(($((wc -l))/2+1))p")
	y=$(echo "$i"| sed 's/\.[^.]*$//' | sed 's/\.[^.]*$//')
	echo "median is $z"
	echo "$y $z" >> med.csv
	#cat -n "$i" > "$i.tmp" && mv "$i.tmp" "$i"
	gnuplot -e "set terminal png ; set output 'graphics/$y.png' ; plot '$x' with line, '$i' with line"
	x=$i
done
