#!/bin/bash

# nextflow workflows produce a lot of extra files that you might not want to keep after your run is finished
# run this to clean up after a run
# removes all work directories and hidden files including logs

rm -r work/ .nextflow*


