# bamQC-nf
<p align="center">
:wrench: This pipeline is currently under development :wrench:
</p>

## Description 

A flexible pipeline for reporting summary statistics relating to quality of bam files. bamQC-nf is a Nextflow (DSL2) pipeline that runs the following tools using Singularity containers:
* Samtools stats: detailed summary statistics for bam files (default) 
* Mosdepth: fast bam depth calculations (default)
* Sambamba flagstats: high-level summary statistics for bam files (optional)
* Qualimap bamqc: quality evaluation of bam files (optional)
* MultiQC: cohort-level summary report of pipeline outputs (currently under development)

## Diagram

<p align="center"> 
<img src="https://user-images.githubusercontent.com/73086054/187155487-0b85634a-0495-4aff-8813-259314bf67ab.png" width="80%">
</p> 

## User guide
### Quickstart guide

#### 1. Set up 

Clone this repository by running:

```
git clone https://github.com/Sydney-Informatics-Hub/bamQC-nf.git
cd bamQC-nf
```

#### 2. Create cohort file 

Create a tab-delimited file listing all samples to be processed and their corresponding bam and bai files. The cohort file can be named whatever you like. This file must have one row per unique sample, matching the format: 

|sampleID |bam                   |bai                        |
|---------|----------------------|---------------------------|
|sample1  |/path/to/sample1.bam  | /path/to/sample1.bam.bai  |
|sample2  |/path/to/sample2.bam  | /path/to/sample2.bam.bai  |
|sample3  |/path/to/sample3.bam  | /path/to/sample3.bam.bai  |
|sample4  |/path/to/sample4.bam  | /path/to/sample4.bam.bai  |
|sample5  |/path/to/sample5.bam  | /path/to/sample5.bam.bai  |
|sample6  |/path/to/sample6.bam  | /path/to/sample6.bam.bai  |

#### 3. Run the pipeline

To run the default pipeline with Samtools stats and mosdepth, run the following command:   

```
nextflow run main.nf --cohort <samples.tsv> --cpus <number of CPUs>
```

Or run the following script after filling out the required input variables:  

```
bash run_bamqc.sh
```

For improved flexibility and speed, users can specify which tools to run in addition to and instead of default options. For example, to run the pipeline with Samtools flagstat instead of Samtools stats, run the following:

```
nextflow run main.nf --cohort <samples.tsv> --cpus <number of CPUs> --flagstat
```

While some parameters have default values in the workflow, you can adjust any of them in running your command. See the `nextflow.config` file to adjust the defaults, or add the following flags to your run command:
* `--flagstat`: This runs sambamba flagstat instead of Samtools stats, for a faster runtime and less verbose metrics. 
* `--qualimap`: This runs Qualimap's bamqc tool in addition to default tools. When coupled with `flagstat` will run Sambamba flagstat, Mosdepth, and Qualimap bamqc  
* `--outDir`: This directory contains outputs for all samples processed with this pipeline. Currently set to `./bamQC_results`
* `--runReports`: This directory contains all runtime summaries including resource usage and timelines. Currently set to `./bamQC_runInfo`

Once the workflow has completed its run you can clean up the working files Nextflow produces by running:

```
bash cleanup.sh
```

### Infrastructure usage and recommendations
Coming soon! 

## Benchmarking
Nextflow reports are stored in [benchmarkingReports](https://github.com/Sydney-Informatics-Hub/bamQC-nf/tree/main/benchmarkingReports) directory. 

## Workflow summaries
### Metadata 
|metadata field     | workflow_name / workflow_version  |
|-------------------|:---------------------------------:|
|Version            | 1.0                               |
|Maturity           | under development                 |
|Creators           | Georgie Samaha, Cali Willet  |
|Source             | NA                                |
|License            | GPL-3.0 license                   |
|Workflow manager   | Nextflow                          |
|Container          | None                              |
|Install method     | Manual                            |
|GitHub             | Sydney-Informatics-Hub/bamQC-nf   |
|bio.tools          | NA                                |
|BioContainers      | NA                                | 
|bioconda           | NA                                |

### Component tools

singularity  
nextflow/20.07.1  
samtools/1.15  
qualimap/2.2.1  
mosdepth/0.3.1  

### Reqired (minimum) inputs/parameters

* indexed bam files
* cohort file listing all samples to be processed. Columns are sampleID, bam, bai (tab-delimited text format)

## Help/FAQ/Troubleshooting

## Acknowledgements/citations/credits
### Authors 
- Georgie Samaha (Sydney Informatics Hub, University of Sydney)   
- Cali Willet (Sydney Informatics Hub, University of Sydney)

### Acknowledgements 

- This pipeline was built using the [Nextflow DSL2 template](https://github.com/Sydney-Informatics-Hub/Nextflow_DSL2_template).  
- Documentation was created following the [Australian BioCommons documentation guidelines](https://github.com/AustralianBioCommons/doc_guidelines) .  

#### Cite us to support us! 
Acknowledgements (and co-authorship, where appropriate) are an important way for us to demonstrate the value we bring to your research. Your research outcomes are vital for ongoing funding of the Sydney Informatics Hub and national compute facilities. We suggest including the following acknowledgement in any publications that follow from this work:  

The authors acknowledge the technical assistance provided by the Sydney Informatics Hub, a Core Research Facility of the University of Sydney and the Australian BioCommons which is enabled by NCRIS via Bioplatforms Australia. 
