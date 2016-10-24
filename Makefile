.PHONY: x, run, clean

x:
	@echo "There is no default make target. Use 'make run' to run the SLURM pipeline"

run:
	slurm-pipeline.py -s specification.json *.fastq.gz > status.json

# Remove all intermediate files. Only run this if you're sure you want to
# throw away all that work!
clean:
	rm -f \
              01-trim/*.discarded.gz \
              01-trim/*.settings \
              01-trim/*.fastq.gz \
              01-trim/slurm-*.out \
              02-map/*.out \
              02-map/*.bam \
              03-find-unmapped/*.fastq.gz \
              03-find-unmapped/*.out \
              04-diamond/*.json.bz2 \
              04-diamond/*.out

# Remove all intermediates and the final panel output.
clobber: clean
	rm -fr 05-panel/out
