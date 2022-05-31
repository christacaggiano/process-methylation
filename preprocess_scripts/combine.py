import csv
import sys  

def convert_to_zero(meth, depth): 
	if float(depth) == -1: 
		return 0, 0 
	
	return float(meth), float(depth) 

if __name__ == "__main__": 

	file1=sys.argv[1]
	file2=sys.argv[2]
	output=sys.argv[3]

	with open(file1, "r") as f1, open(file2, "r") as f2, open(output, "w") as o: 

		file1_reader = csv.reader(f1, delimiter="\t")
		file2_reader = csv.reader(f2, delimiter="\t")
		output_writer = csv.writer(o, delimiter="\t")

		for line1, line2 in zip(file1_reader, file2_reader): 

			meth1, depth1 = line1[-2], line1[-1]
			meth2, depth2 = line2[-2], line2[-1]

			meth1, depth1 = convert_to_zero(meth1, depth1)
			meth2, depth2 = convert_to_zero(meth2, depth2)

			output_writer.writerow(line1[:3] + [meth1 + meth2] + [depth1 + depth2])

