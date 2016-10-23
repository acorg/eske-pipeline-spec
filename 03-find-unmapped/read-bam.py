#!/usr/bin/env python

import pysam
import sys

samfile = pysam.AlignmentFile(sys.argv[1], 'rb')

# print('According to the BAM file, there are %d mapped reads and %d unmapped' % (
# samfile.mapped, samfile.unmapped), file=sys.stderr)

mappedCount = unmappedCount = 0

for read in samfile:
    if read.is_unmapped:
        unmappedCount += 1
        # print(dir(read))
        # print(read)
        quality = bytes(map(lambda x: x + 33, read.query_qualities)).decode('utf-8')
        # Note that printing the query name a second time (after the '+') is optional
        # in FASTQ. Unfortunately, some tools require it.
        print('@%s\n%s\n+%s\n%s' % (read.query_name, read.query_sequence,
              read.query_name, quality))
        # break
    else:
        mappedCount += 1

samfile.close()

print('Read %d mapped reads (%.2f%%), %d unmapped' % (
      mappedCount, mappedCount / (mappedCount + unmappedCount) * 100.0, unmappedCount),
      file=sys.stderr)
