#!/usr/bin/env python3

import argparse
import sys

def read_fasta(fp):
    name, seq = None, []
    for line in fp:
        line = line.rstrip()
        if line.startswith(">"):
            if name: yield (name, ''.join(seq))
            name, seq = line[1:], []
        else:
            seq.append(line)
    if name: yield (name, ''.join(seq))

def print_gff(name,seq):
    sys.stdout.write(">"+name+"\n"+seq+"\n")

parser = argparse.ArgumentParser(description='Filter a FASTA file')
parser.add_argument('-i','--interval-out',metavar='IOUT', default='contigs.gff',type=str,
	help="Filename to write intervals")

parser.add_argument('fastafile',metavar='FILE',type=argparse.FileType('r'),help='File containing sequences in FASTA format')

args  = parser.parse_args()

for name,seq in read_fasta(args.fastafile):

