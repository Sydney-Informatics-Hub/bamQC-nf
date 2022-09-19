// Enable DSL-2 syntax
nextflow.enable.dsl=2

// Define the process
process sambambaFlag {
        cpus "${params.cpus}"
        debug true
        publishDir "${params.outDir}/${sampleID}", mode: 'copy'

        // resource parameters. currently set to 4 CPUs
        cpus "${params.cpus}"

        // Run with sambamba v0.8.2 container
        container "${params.sambamba__container}"

        input:
        tuple val(sampleID), file(bam)

        output:
        tuple val(sampleID), path("${sampleID}.sambamba.flagstats"), emit: in2multiqc

        script:
        """
        sambamba flagstat \
        --nthreads ${params.cpus} \
	--show-progress \
        ${bam} > ${sampleID}.sambamba.flagstats
        """
}
