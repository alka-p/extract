#!/bin/bash
##Author: Alka Potdar 
###Script to extract all data for a particular SNP or a gene from a master file as well as filter significant data with p<0.05


###updated the grep command to grab intergenic snps where the gene is present in the form of gene_ and _gene
##command to use on terminal##
###./extract_script.sh

echo -n "Please enter the master file name > "
read master
echo "You entered: $master"

echo -n "Please enter the name of your input list file which has names of snps/genes > "
read name
echo "You entered: $name"

filename_out=${name}_out.txt
filename_count=${name}_count.txt
filename_filter=${name}_p0.05.txt

head -n1 $master > $filename_out

echo "count" > $filename_count

for col1 in $(cat $name)
do
 echo Searching for $col1
 ###Use -w to grep for whole words (exact gene names) in a tab/space-delimited file###
 #grep -w "$col1" $master >> $filename_out
 #grep "$col1_" $master >> $filename_out
 grep "$col1" $master >> $filename_out
 #grep -c -w "$col1" $master >> $filename_count
 #grep -c "$col1_" $master >> $filename_count
  grep -c "$col1" $master >> $filename_count
done

##extract only significant associations
awk '($11 + 0) < 0.05' $filename_out > $filename_filter
