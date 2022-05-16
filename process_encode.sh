
#!/bin/bash

############# ENCODE SAMPLES ##############

#expects a bed file of CpG methylation
#there seem to be two main bedfiles on ENCODE now, a newer one called "bed9" and an older "bed bedMethyl"
#this code will be for the "bed9" files, but it's simple to change it for the older one
#(the columns are in slightly different orders)

wget https://www.encodeproject.org/files/ENCFF917PWY/@@download/ENCFF917PWY.bed.gz  # wget the file

name="motor_neuron"  # give it name for ease of organizing (no spaces in name)
num=1  # and a sample number if we're downloading multiple replicates

gunzip ENCFF917PWY.bed.gz # unzip the bedfile
mv ENCFF763RUE.bed $name$num".bed" # rename it

# convert the file so that it is the number of methylated reads and the total number of reads
awk '{print $1 "\t" $2 "\t" $3 "\t" ($13*$10)/100 "\t" $13}' $name$num".bed"  > $name$num".meth_depth"

# find the sites that we will be using for our analysis. If the site is missing from this file, bedtools will
# keep it (that's the -loj parameter), but enter it as a -1, so we know it is missing
bedtools intersect -a all_encode_sites.txt -b $name$num".meth_depth" -loj -sorted > $name$num".sites"

# combine the forward and reverse strand methylation
python sum_strands.py $name$num".sites" $name$num".all_sites"


########### combine two replicates 

python combine.py $name"1.all_sites" $name"2.all_sites" $name"_all.bed"
