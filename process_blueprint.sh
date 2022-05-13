
#!/bin/bash

############# BLUEPRINT SAMPLES ##############

#expects two big wig files from blueprint, one for methylation and one for coverage

wget http://ftp.ebi.ac.uk/pub/databases/blueprint/data/homo_sapiens/GRCh38/cord_blood/S00CP6/conventional_dendritic_cell/Bisulfite-Seq/CNAG/S00CP651.CPG_methylation_calls.bs_call.GRCh38.20160531.bw
wget http://ftp.ebi.ac.uk/pub/databases/blueprint/data/homo_sapiens/GRCh38/cord_blood/S00CP6/conventional_dendritic_cell/Bisulfite-Seq/CNAG/S00CP651.CPG_methylation_calls.bs_cov.GRCh38.20160531.bw

name="dendritic"  # give it name for ease of organizing (no spaces in name)
num=1  # and a sample number if we're downloading multiple replicates
prefix="S00CP651" # blueprint files are very long, so I define a prefix to make things look nicer in the code

./bigWigToBedGraph $prefix.CPG_methylation_calls.bs_call.GRCh38.20160531.bw $name$num"_meth.txt"
./bigWigToBedGraph $prefix.CPG_methylation_calls.bs_cov.GRCh38.20160531.bw $name$num"_depth.txt"

# combine the two files and convert to counts
bedtools intersect -a $name$num"_meth.txt" -b $name$num"_depth.txt" -wb > $name$num".txt"
awk '{print $1 "\t" $2 "\t" $3-1 "\t" $4*$8 "\t" $8}' $name$num".txt" > $name$num".meth_depth"

# find the sites that we will be using for our analysis. If the site is missing from this file, bedtools will
# keep it (that's the -loj parameter), but enter it as a -1, so we know it is missing
bedtools intersect -a all_encode_sites.txt -b $name$num".meth_depth" -loj -sorted > $name$num".sites"

# combine the forward and reverse strand methylation
python sum_strands.py $name$num".sites" $name$num".all_sites"
