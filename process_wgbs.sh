
#!/bin/bash

######## 
name="skeletal"
num=1
bedtools intersect -a $name$num"_meth.txt" -b $name$num"_depth.txt" -wb -sorted > $name$num".txt"
awk '{print $1 "\t" $2-1 "\t" $3-1 "\t" ($4/100)*$8 "\t" $8}' $name$num".txt" > $name$num".bed"
bedtools intersect -a all_encode_sites.txt -b  $name$num".bed"  -loj > $name$num".sites" 
python sum_strands.py $name$num".sites" $name$num".all_sites" 