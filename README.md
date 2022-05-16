# Processing Publicly Available WGBS Data

The goal of this repository is to give some simple shell scripts to process WGBS data, ultimately to be used for
downstream analysis (especially with [CelFiE](https://github.com/christacaggiano/celfie))

To run this code the following software is needed:
- Python >= 3.0
- [Bedtools](https://bedtools.readthedocs.io/en/latest/)
- The `bigWigToBedGraph` [command line utility](https://genome.ucsc.edu/goldenpath/help/bigWig.html) from UCSC

The scripts run on the command line like this:
```
./process_encode.sh
./process_blueprint.sh

```

The output should be one file, with a total of number of ~28 million sites.

# Converting to Hg38

To convert to hg38, take a final bed file (with no header) and use the liftover python script in this repository

```
python liftover.py <input file name> <output file name> <delimiter of file>
```

For example, if you had a tab delimited file named "adipose.bed", you would run

```
python liftover.py adipose.bed adipose_hg38.bed tab
```

This code only works for hg19->hg38. To change it, you need to change the [UCSC liftover chain file](https://hgdownload.cse.ucsc.edu/goldenpath/hg19/liftOver/) specified in the
python script.

There will likely be slightly difference in the number of final sites versus the starting number, but if this difference is larger than 10% of the starting number, there was likely something wrong with the conversion.


# Merging replicates

If there is more than one replicate of a tissue, and you wish to combine them, use the following python script:

```
python combine.py <rep1 bed file> <rep2 bed file> <output file>
```

ex:

```
python combine.py brain1.all_sites brain2.all_sites brain_all.meth_depth

```

See `process_encode.sh` for an example in a bash context. 
