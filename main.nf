#!/usr/bin/env nextflow

/// To use DSL-2 will need to include this
nextflow.enable.dsl=2

// Import subworkflows to be run in the workflow
include { checkInputs } from './modules/check_cohort'
include { samtoolsStats } from './modules/samtoolsStats'
include { sambambaFlag } from './modules/sambambaFlagstat'
include { mosdepth } from './modules/mosdepth'
include { qualimapBamqc } from './modules/qualimapBamqc'
//include { multiqc } from './modules/multiqc'

/// Print a header for your pipeline 

log.info """\

      ============================================
      ============================================
                      B A M - Q C  
      ============================================
      ============================================

  -._    _.--'"`'--._    _.--'"`'--._    _.--'"`'--._      
     '-:`.'|`|"':-.  '-:`.'|`|"':-.  '-:`.'|`|"':-.  '. .  
   '.  '.  | |  | |'.  '.  | |  | |'.  '.  | |  | |'.  '.    
   : '.  '.| |  | |  '.  '.| |  | |  '.  '.| |  | |  '.  '  
   '   '.  `.:_ | :_.' '.  `.:_ | :_.' '.  `.:_ | :_.' '.   
          `-..,..-'       `-..,..-'       `-..,..-'           

 
                ~~~~ Version: 1.0 ~~~~
 

 Created by the Sydney Informatics Hub, University of Sydney

 Find documentation and more info @ https://github.com/Sydney-Informatics-Hub/bamQC-nf

 Cite this pipeline @ INSERT DOI

 Log issues @ https://github.com/Sydney-Informatics-Hub/bamQC-nf/issues

 All default parameters are set in `nextflow.config`.

 """

/// Help function 
// This is an example of how to set out the help function that 
// will be run if run command is incorrect (if set in workflow) 
// or missing

def helpMessage() {
    log.info"""
  OOPS, YOU FORGOT SOME REQUIRED ARGUMENTS!

  Usage:  nextflow run https://github.com/Sydney-Informatics-Hub/bamQC-nf --cohort <manifest.tsv>

  Required Arguments:
	
	--cohort		Specify tab-separated input file. Default
				is ./samples.tsv
	
  Optional Arguments:
	
	--outDir		Specify path to output directory. Default
				is ./Stats_out
	
	--cpus			Set the number of threads. Default is 8.


	--flagstat		Run Samtools flagstat, rather than Samtools
				stats. Default is samtools stats. 

	--qualimap		Run Qualimap bamqc tool (optional)

    """.stripIndent()
}

/// Main workflow structure. Include some input/runtime tests here.

workflow {

// Show help message if --help is run or if any required params are not 
// provided at runtime

        if ( params.help || params.cohort == false ){
        // Invoke the help function above and exit
              helpMessage()
              exit 1

        // consider adding some extra contigencies here.

// if none of the above are a problem, then run the workflow
	} else {
	
        // Check inputs
	checkInputs(Channel.fromPath(params.cohort, checkIfExists: true))

	// Split cohort file to collect info for each sample
	cohort = checkInputs.out
			.splitCsv(header: true, sep:"\t")
			.map { row -> tuple(row.sampleID, file(row.bam), file(row.bai)) }
  
	if (params.flagstat) {
	// Run sambambaFlagstats
	sambambaFlag(cohort)
	}

        // Run samtoolsStats if --flagstat not specified
        else { samtoolsStats(cohort)
        }

	// Run mosdepth 
	mosdepth(cohort)

	if (params.qualimap) {
	// Run qualimapBamQC
	qualimapBamqc(cohort)
	}

	// Run multiqc to aggregate reports
	// Still under development
	//multiqc() 
}}

workflow.onComplete {
	log.info ( workflow.success ? "\nDone! Outputs are in `${params.outDir}`, runtime info is in `./run_Info`" 
	: "Oops .. something went wrong" )
}
