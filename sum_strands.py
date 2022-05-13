import csv 
import sys 

if __name__ == "__main__": 

	file = sys.argv[1]
	out = sys.argv[2]

	with open(file, "r") as input_file, open(out, "w") as output_file: 
		f = csv.reader(input_file, delimiter="\t")
		o = csv.writer(output_file, delimiter="\t")

		for line in f: 

			forward = line
			reverse = next(f)

			position = forward[0:3]

			if "-1" in forward: 
				meth = 0 
				depth = 0 
			
			elif "-1" in reverse: 
				meth = float(forward[-2])
				depth = float(forward[-1]) 

			else: 
				meth = float(reverse[-2]) + float(forward[-2])
				depth = float(reverse[-1]) + float(forward[-1])

			o.writerow(position + [meth] + [depth])
