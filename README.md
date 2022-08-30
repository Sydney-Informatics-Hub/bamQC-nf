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
- Nextflow `.html` reports are stored in [benchmarkingReports](https://github.com/Sydney-Informatics-Hub/bamQC-nf/tree/main/benchmarkingReports) directory.   
- See [Nextflow's documentation](https://www.nextflow.io/docs/latest/tracing.html#trace-report) for a summary of the trace reports below.

### 6 human samples (~x30 coverage) at Pawsey Nimbus cloud 
|task_id|hash     |native_id|name            |status   |exit|submit                 |duration  |realtime  |%cpu |peak_rss|peak_vmem|rchar   |wchar   |
|-------|---------|---------|----------------|---------|----|-----------------------|----------|----------|-----|--------|---------|--------|--------|
|1      |db/1e5cbb|199553   |checkInputs (1) |CACHED   |0   |2022-08-29 03:57:13.578|149ms     |6ms       |40.6%|0       |0        |148.6 KB|702 B   |
|4      |9a/ea46d5|646424   |sambambaFlag (2)|COMPLETED|0   |2022-08-29 09:37:17.128|6h 2m 14s |6h 2m 12s |7.3% |15.2 MB |1.2 GB   |80.2 GB |3.3 MB  |
|11     |fd/d3f29b|646417   |sambambaFlag (5)|COMPLETED|0   |2022-08-29 09:37:17.117|6h 17m 11s|6h 17m 10s|7.2% |16.6 MB |1.2 GB   |85.4 GB |3.2 MB  |
|10     |f1/674e79|646443   |mosdepth (5)    |COMPLETED|0   |2022-08-29 09:37:17.163|6h 17m 13s|6h 17m 10s|4.8% |2.9 MB  |11 MB    |85.5 GB |660.4 KB|
|9      |b6/b99706|646432   |sambambaFlag (4)|COMPLETED|0   |2022-08-29 09:37:17.138|6h 59m 26s|6h 59m 25s|6.9% |16.4 MB |1.2 GB   |96 GB   |3.2 MB  |
|6      |32/6c1eac|972781   |sambambaFlag (3)|COMPLETED|0   |2022-08-29 15:54:28.418|2h 15m 39s|2h 15m 37s|19.9%|15.3 MB |1.2 GB   |85.2 GB |3.5 MB  |
|2      |25/43ea4d|972966   |sambambaFlag (1)|COMPLETED|0   |2022-08-29 15:54:29.868|2h 25m 24s|2h 25m 24s|20.7%|15.8 MB |1.2 GB   |100.6 GB|3.7 MB  |
|3      |47/dd625b|1018279  |mosdepth (1)    |COMPLETED|0   |2022-08-29 16:36:43.625|1h 43m 12s|1h 43m 10s|18.7%|1.9 GB  |3.1 GB   |100.6 GB|854.8 KB|
|12     |b4/3bc60d|958509   |mosdepth (6)    |COMPLETED|0   |2022-08-29 15:39:31.941|2h 53m 28s|2h 53m 25s|11.4%|2.8 MB  |11 MB    |103.1 GB|866.6 KB|
|7      |19/794c1a|1134653  |mosdepth (3)    |COMPLETED|0   |2022-08-29 18:33:00.304|2h 8m 59s |2h 8m 58s |13.3%|2.8 GB  |4.1 GB   |85.3 GB |823.6 KB|
|5      |d6/765991|1112947  |mosdepth (2)    |COMPLETED|0   |2022-08-29 18:19:55.913|2h 25m 27s|2h 25m 25s|11.3%|2.8 GB  |4.1 GB   |80.2 GB |728.6 KB|
|13     |70/76bcbc|1099179  |sambambaFlag (6)|COMPLETED|0   |2022-08-29 18:10:07.355|2h 43m 13s|2h 43m 12s|18.9%|15 MB   |1.2 GB   |103.1 GB|3.6 MB  |
|8      |71/3713ea|1112762  |mosdepth (4)    |COMPLETED|0   |2022-08-29 18:19:54.498|2h 38m 30s|2h 38m 29s|11.4%|1.9 GB  |3.1 GB   |96.1 GB |784.2 KB|


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
