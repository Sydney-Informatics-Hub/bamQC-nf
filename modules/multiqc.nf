#!/bin/env nextflow 

// Enable DSL-2 syntax
nextflow.enable.dsl=2

// Define the process
process multiqc {
	debug true
        publishDir "${params.outDir}", mode: 'copy'

        // resource parameters. currently set to 4 CPUs for all 
        cpus "${params.cpus}"

        // Run with multiqc container. currently v1.12
        container "${params.multiqc__container}"

        input:

        output:

        script:
        """
        """
}


