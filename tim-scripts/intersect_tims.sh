#!/bin/bash


### for each sample merge with the tims, this substantially reduces the number of sites
### for intersection

bedtools intersect -b final_idt_tims_500_sorted.txt -a <sample_all_sites <sample_final_idt_tims.txt>
python sum_by_list.py final_idt_tims_500_sorted.txt <sample_final_idt_tims.txt> <sample_final_idt_tims_summed.txt>  1


### after all the samples are subset to tims, merge them together to make one matrix
### this can be then combined with the input cfDNA matrix 
# python merge_files.py <suffix of all files to be merged together> <output file>
python merge_files.py <input directory> <_final_idt_tims_summed.txt> <output_name>
