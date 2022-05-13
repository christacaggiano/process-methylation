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

The output should be one file, with a total of number of X sites. 
