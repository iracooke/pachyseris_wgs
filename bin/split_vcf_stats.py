#!/usr/bin/env python3

import argparse
import sys

# def read_fasta(fp):
#     name, seq = None, []
#     for line in fp:
#         line = line.rstrip()
#         if line.startswith(">"):
#             if name: yield (name, ''.join(seq))
#             name, seq = line[1:], []
#         else:
#             seq.append(line)
#     if name: yield (name, ''.join(seq))

# def print_fasta(name,seq):
#     sys.stdout.write(">"+name+"\n"+seq+"\n")

parser = argparse.ArgumentParser(description='Extract outputs produced by bcftools stats into a separate file for plotting')

parser.add_argument('statsfile',metavar='FILE',type=argparse.FileType('r'),help='Outputs from bcftools stats')

parser.add_argument('section',metavar='SECTION',type=str,help="Section to extract, eg QUAL,IDD,DP")


args  = parser.parse_args()

for line in args.statsfile:
    if line.startswith("# "+args.section) or line.startswith(args.section):
        sys.stdout.write(line)