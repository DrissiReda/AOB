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
	awk '{print $NF}' $i | sort | cut -f2- -d' ' > $i.tmp && mv $i.tmp $i
	fnan=$(head -n +1 $i | awk -F ' *' '$NF ~ /^[^0-9].*$/ { print $NF }')
	lnan=$(tail -n1 $i | awk -F ' *' '$NF ~ /^[^0-9].*$/ { print $NF }')
	if [ ! -z "$fnan" ]; then #first line is nan
		tail -n +2 "$i" > "$i.tmp" && mv "$i.tmp" "$i"
	elif [ ! -z "$lnan" ]; then #last line is nan
		sed '$d' "$i" >  "$i.tmp" && mv "$i.tmp" "$i"
	fi
	z=$(sort -n $i | sed -ne "$(($((wc -l))/2+1))p")
	y=$(echo "$i"| sed 's/\.[^.]*$//' | sed 's/\.[^.]*$//')
	echo "median is $z"
	echo "$y $z" >> med.csv
	cat -n "$i" > "$i.tmp" && mv "$i.tmp" "$i"
	#gnuplot -e "set terminal png ; set output 'graphics/$y.png' ; plot '$x' with line, '$i' with line"
	x=$i
done
