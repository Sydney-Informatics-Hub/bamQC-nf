#!/bin/env nextflow 

// Enable DSL-2 syntax
nextflow.enable.dsl=2

// Define the process
process qualimapBamqc {
	cpus "${params.cpus}"
	debug true
        publishDir "${params.outDir}/${sampleID}", mode: 'copy'

        // resource parameters. currently set to 4 CPUs
        cpus "${params.cpus}"

        // Run with qualimap container. currently v2.21
        container "${params.qualimap__container}"

        input:
        tuple val(sampleID), file(bam)

        output:
        tuple val(sampleID), file("./qualimap"), 
        emit: qualimap_out

        script:
        """
	qualimap bamqc -nt ${params.cpus} \
        -bam ${bam} \
	--java-mem-size=4G \
	-outdir ./qualimap \
	-outformat html 
        """
}


