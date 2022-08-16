#!/bin/bash

# define inputs
ref= # reference.fasta
cohort= #name of input samples file

# run bamQC-nf workflow
nextflow run main.nf \
	--ref ${ref} \
	--cohort ${cohort}
