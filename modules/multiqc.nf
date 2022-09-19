#!/bin/env nextflow 

// Enable DSL-2 syntax
nextflow.enable.dsl=2

// Define the process

// THIS IS CURRENTLY BROKEN //
process multiQC {
	debug true
        publishDir "${params.outDir}/${sampleID}/multiQC", mode: 'copy'

        // Run with multiqc container. currently v1.12
        container "${params.multiqc__container}"

        input:
        // this is broken and wrong anyway 
        // shouldn't be looking for outputs in final outdir
        // should feed in with channels from other processes
        tuple val(sampleID), path("*", stageAs: "?/*")

        output:
	tuple val(sampleID), path("multiqc_report.html")
        tuple val(sampleID), path("multiqc_data")

        script:
        """
	multiqc ${params.outDir}/${sampleID}
        """
}


