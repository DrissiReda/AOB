#!/bin/bash
mkdir -p graphics
echo '' > med.csv
# i=$1
# tail -n +2 "$i" > "$i.tmp" && mv "$i.tmp" "$i"
# z=$(sort -n $i | sed -ne "$(($((wc -l))/2+1))p")
# y=$(echo "$i"| sed 's/\.[^.]*$//' | sed 's/\.[^.]*$//')
# echo "median is $z"
# echo "$y $z" >> med.csv
# cat -n "$i" > "$i.tmp" && mv "$i.tmp" "$i"
# gnuplot -e "set terminal png ; set output 'graphics/$y.png' ; plot 'omp.tsv' with line, '$i' with line ;"
# x=$1
# shift
for i in $@ ; do
	awk '{print $NF}' $i | cut -f2- -d' ' > $i.tmp && mv $i.tmp $i # remove other fields
	awk -F ' *' '$NF ~ /^[0-9].*$/ { print $NF }' $i  > $i.tmp && mv $i.tmp $i # remove nan lines
	z=$(sort -n $i | sed -ne "$(($((wc -l))/2+1))p")
	y=$(echo "$i"| sed 's/\.[^.]*$//' | sed 's/\.[^.]*$//')
	echo "median is $z"
	echo "$y $z" >> med.csv
	cat -n "$i" > "$i.tmp" && mv "$i.tmp" "$i"
	sed -i 's/\./,/g' $i
	#gnuplot -e "set terminal png ; set output 'graphics/$y.png' ; plot '$x' with line, '$i' with line"
	x=$i
done
sort -nr -k2 med.csv > med.tmp && mv med.tmp med.csv
sed -i 's/\./,/g' med.csv
