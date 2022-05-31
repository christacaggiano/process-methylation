import pandas as pd 
import sys 
import glob 
from numpy import nan 

if __name__=="__main__": 

	input_directory = sys.argv[1]
	input_suffix = sys.argv[2]
	output_file = sys.argv[3]

	all_sample_files = glob.glob(f"{input_directory}/*{input_suffix}") 
	print(all_sample_files)

	merged = pd.DataFrame()


	for f in all_sample_files: 
		df = pd.read_csv(f, delimiter="\t", header=None)
		merged = pd.concat([merged, df.iloc[:, -2:]], axis=1)

	merged = merged.replace(-1, nan)
	merged = merged.replace(".", nan)

	merged.to_csv(output_file, header=None, sep="\t", index=False, na_rep=nan)
