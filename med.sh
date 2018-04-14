echo '' > med.csv
for i in $@ ; do
    awk '{print $NF,$0}' $i | sort | cut -f2- -d' ' > $i.tmp 
    mv $i.tmp $i
    j=$(sort -n $i | sed -ne "$(($((wc -l))/2+1))p")
	 y=$(echo "$i"| sed 's/\.[^.]*$//' | sed 's/\.[^.]*$//')
	echo "median is $z"
	echo "$y $j" > med.csv
done
