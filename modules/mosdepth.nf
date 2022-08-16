#!/bin/env nextflow 

// Enable DSL-2 syntax
nextflow.enable.dsl=2

// Define the process
process mosdepth {
	debug true
        publishDir "${params.outDir}/${sampleID}", mode: 'copy'

        // resource parameters. currently set to 4 CPUs
        cpus "${params.cpus}"

        // Run with mosdepth container. currently v0.3.1
        container "${params.mosdepth__container}"

        input:
        tuple val(sampleID), file(bam), file(bai)

        output:
        tuple val(sampleID), 
	path("${sampleID}.mosdepth.global.dist.txt"), 
	path("${sampleID}.mosdepth.summary.txt"),
	path("${sampleID}.per-base.bed.gz"), 
	emit: mos_depth

        script:
        """
	mosdepth --threads ${params.cpus} \
	--no-per-base \
        ${sampleID} \
        ${bam}        
        """
}


