#!/usr/bin/env python

import gzip
import sys

class MaskGenerator:
  def __init__(self, filename, chr):
    self.lastCalledPos = -1
    self.lastStartPos = -1
    sys.stderr.write("making mask {}\n".format(filename))
    self.file = open(filename, "w")
    self.chr = chr
  
  # assume 1-based coordinate, output in bed format
  def addCalledPosition(self, pos):
    if self.lastCalledPos == -1:
      self.lastCalledPos = pos
      self.lastStartPos = pos
    elif pos == self.lastCalledPos + 1:
      self.lastCalledPos = pos
    else:
      # import pdb;pdb.set_trace();
      self.file.write("{}\t{}\t{}\n".format(self.chr, self.lastStartPos - 1, self.lastCalledPos))
      self.lastStartPos = pos
      self.lastCalledPos = pos

with open("mask_100_50_1M.fa", "r") as f:
  for line in f:
    if line.startswith('>'):
      chr = line.split()[0][1:]
      mask = MaskGenerator("chr{}.mask.bed".format(chr), chr)
      pos = 0
      continue
    for c in line.strip():
      pos += 1
      if pos % 1000000 == 0:
        sys.stderr.write("processing pos:{}\n".format(pos))
      if c == "3":
        mask.addCalledPosition(pos)
      
