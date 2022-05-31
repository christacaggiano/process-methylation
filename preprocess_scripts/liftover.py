from pyliftover import LiftOver
import csv
import sys 

def convert_hg19_to_hg38(conversion, chrom, start):
    
    coords = (conversion.convert_coordinate(str(chrom), int(start)))

    if coords: 
        return coords


if __name__ == "__main__": 

    in_file = sys.argv[1]
    out_file = sys.argv[2]
    delim = sys.argv[3]

    delim_mapping = {"space":" ", "tab":"\t", "comma":","}

    with open(in_file, "r") as bed, open(out_file, "w") as out: 
        
        output_bed = csv.writer(out, delimiter="\t")
        input_bed = csv.reader(bed, delimiter=delim_mapping[delim])

        conversion_file = "/u/home/c/christac/project-nzaitlen/tools/h19ToHg38.over.chain"
        conversion = LiftOver(conversion_file) 

        # next(input_bed) # skip header

        for line in input_bed:

            chrom, start, end = line[0], line[1], line[2]

            if "chr" not in chrom: 
                chrom = "chr" + str(chrom)

            if len(line) > 3: 
                values = line[3:]
                values[-1] = values[-1].strip()
            else: 
                end.strip("\n")
                values = []


            start_coord = convert_hg19_to_hg38(conversion, chrom, start)
            end_coord = convert_hg19_to_hg38(conversion, chrom, end)

            if (start_coord and end_coord) and (int(start_coord[0][1])<=int(end_coord[0][1])): 

                    chrom, start = start_coord[0][0], start_coord[0][1]
                    end = end_coord[0][1]

                    output_bed.writerow([chrom[3:]] + [int(start)] + [int(end)] + values)
               


