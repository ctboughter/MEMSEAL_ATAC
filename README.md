# Processing ASAPseq Data for the MEMSEAL DARPA Project

# Summary 
This will take inspiration directly from the pre_MEMSEAL repository (also found on my [ctboughter] personal github) for pre-processing CITEseq and VDJseq data.

It will, at some point, require running countASAP (https://github.com/ctboughter/countASAP). To avoid redundancies, the reader will be redirected to that GitHub page for the running of CountASAP.

Again, fundamental to many 'omics projects, the input data unfortunately cannot be included in this repository (too large). Instead "inputs" will refer to the associated input files needed for running a given step.

# Interpreting the Scripts

Scripts are numbered roughly in the order they are run in the pipeline. If there are alternative or parallel processes at a given step, a letter is included (as in step3A, step3B). The entire analysis in this project includes various 'Omics inputs, so eventually this repository will be subdivided for each pipeline. Ordered scripts will be within each directory. For instance, directories will be named "RNAseq", "ATACseq", etc. and each of these directories will have numbered steps.

# Instructions

1. The 1move_files.sh script should be run from whichever directory the files are located. Ideally, a given directory will hold data across multiple days, multiple samples, and multiple assays. This script will allow you to move files from whatever poorly formatted directories we get from a sequencing core into a format that is readable by the scripts later on in this pipeline

2. The 2strip_files.sh script is a (potentially optional) way of removing leading stings from the filenames within the directories you created and filled in step 1. Currently it isn't automated to run through all the files. You first run the script with:

```
./2strip_files.sh
```

Then hit enter, and then enter the directory name where you'd like to strip the leading strings from the files in said directory.

3. 3run_atac.sh automates the process of submitting jobs to a (PBS/SGE) cluster to run cellranger-atac. If you won't be running these on a cluster, you can simply run cellranger-atac with no special flags. To run cellranger-atac, you need a reference genome (on whatever machine you're using). In the example script, the reference is refdata-cellranger-arc-mm10-2020-A-2.0.0

4. 4process_atac.sh takes a template script (found in 4inputs) and automatically fills in variable information to cycle through consecutive input ATAC files, again submitting the overall job to a (PBS/SGE) cluster. If you want to just look at a basic, finished script, see 4outputs for an example. You could just run that R script by itself. Note in 4process_atac.sh, the script relies on a singularity container, which is specifically used because running R on a compute cluster can be a pain. If running this script locally, you can just skip all that singularity stuff and run some manually-edited version of proc_temp_d1.R (in 4outputs) yourself.

To elaborate further on this somewhat complex step:
- The R script takes as input the cellranger-atac outputs filtered_peak_bc_matrix.h5, singlecell.csv, and fragments.tsv.gz
- It generates QC PDFs, some example UMAP, expression, and coverage PDFs, and matrix outputs (both csv, h5, and h5ad) for use in later steps

This final R step will give you all the outputs needed to assess single cell chromatin accessibility using something like signac. The outputs from step 4 will also allow you to incorporate surface-marker information using countASAP.

# CountASAP
 Because countASAP has a dedicated GitHub page (https://github.com/ctboughter/countASAP) I won't further elaborate here. Please see that repository for instruction. I will add, the output generated in step 4, specifically the *h5ad file, is what is used as input for countASAP, along with the unzipped FASTQ files from your surface marker sequencing run. In addition, you need a barcode file, which is included with the countASAP package (assuming you are using the same surface marker panel as the countASAP team) in the path countASAP/countASAP/ex_inputs/asapSeq_barcodes.csv.

# Further Reading
The following links may be helpful for understanding the various steps of the analysis:

- Cellranger Multi Instructions: https://www.10xgenomics.com/support/software/cell-ranger-atac/latest
- Signac chromatin accessibility analysis: https://stuartlab.org/signac/

# Repository Maintainer
At present, this repository is maintained by Chris Boughter. Don't hesitate to reach out if there are questions. This project is funded by DARPA, and supported by researchers at the NIH and at the UMD Medical School.

