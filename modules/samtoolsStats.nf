#!/bin/env nextflow 

// Enable DSL-2 syntax
nextflow.enable.dsl=2

// Define the process
/// This example takes input manifest and capitalises sampleID
process samtoolsStats {
	cpus "${params.cpus}"
	debug true 
	publishDir "${params.outDir}/${sampleID}", mode: 'copy'
	
	// resource parameters. currently set to 4 CPUs
	cpus "${params.cpus}"

	// Run with samtools v1.15 container
        container "${params.samtools__container}"

	input:
	tuple val(sampleID), file(bam)

	output:
	tuple val(sampleID), path("${sampleID}.samtools.stats"), emit: samtools_stats

	script:
	"""
	samtools stats \
        --threads ${params.cpus} \
        ${bam} > ${sampleID}.samtools.stats
	"""
}
