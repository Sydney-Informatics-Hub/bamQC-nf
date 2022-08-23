# bamQC-nf
<p align="center">
:wrench: This pipeline is currently under development :wrench:
</p>

## Description 

Report summary statistics relating to quality of bam files with Nextflow. bamQC-nf is a Nextflow pipeline that runs the following tools using Singularity containers:
* Samtools stats: detailed summary statistics for bam files
* Mosdepth: fast bam depth calculations 
* Qualimap bamqc: quality evaluation of bam files
* MultiQC: cohort-level summary report of pipeline outputs (currently under development)

## Diagram

<p align="center"> 
<img src="https://user-images.githubusercontent.com/73086054/184803464-d3c5ef56-6d2f-4d27-b4e8-3d6786e3374d.png" width="80%">
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

#### 3. Prepare reference assembly 

Samtools stats uses a reference genome to summarise the GC-depth and mismatches-per-cycle calculation. Samtools expects the reference has been indexed with Samtools faidx. 

#### 4. Run the pipeline

To run the default pipeline, run the following command:   

```
nextflow run main.nf --cohort <samples.tsv> --ref <ref.fasta> 
```

Or run the following script after filling out the required input variables:  

```
bash run_bamqc.sh
```

While some parameters have default values in the workflow, you can adjust any of them in running your command. See the `nextflow.config` file to adjust the defaults, or add the following flags to your run command:
* `--outDir`: This directory contains outputs for all samples processed with this pipeline. Currently set to `./bamQC_results`
* `--runReports`: This directory contains all runtime summaries including resource usage and timelines. Currently set to `./bamQC_runInfo`

Once the workflow has completed its run you can clean up the working files Nextflow produces by running:

```
bash cleanup.sh
```

### Infrastructure usage and recommendations
Coming soon! 

## Benchmarking
Coming soon! 

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
* reference assembly (fasta format)

## Help/FAQ/Troubleshooting

## Acknowledgements/citations/credits
### Authors 
- Georgie Samaha (Sydney Informatics Hub, University of Sydney)   
- Nandan Deshpande (Sydney Informatics Hub, University of Sydney)

### Acknowledgements 
Acknowledgements (and co-authorship, where appropriate) are an important way for us to demonstrate the value we bring to your research. Your research outcomes are vital for ongoing funding of the Sydney Informatics Hub and national compute facilities. We suggest including the following acknowledgement in any publications that follow from this work:  

The authors acknowledge the technical assistance provided by the Sydney Informatics Hub, a Core Research Facility of the University of Sydney and the Australian BioCommons which is enabled by NCRIS via Bioplatforms Australia.  

Documentation was created following the [Australian BioCommons documentation guidelines](https://github.com/AustralianBioCommons/doc_guidelines)  
