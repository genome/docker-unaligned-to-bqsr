#!/bin/bash

set -o pipefail
set -o errexit

/usr/bin/java -Xmx4g -jar /opt/picard/picard.jar SamToFastq I=$1 INTERLEAVE=true INCLUDE_NON_PF_READS=true FASTQ=/dev/stdout | /usr/local/bin/bwa mem -K 100000000 -t $4 -Y -p -R "$2" $3 /dev/stdin | /usr/bin/java -Xmx4g -jar /opt/picard/picard.jar MergeBamAlignment VALIDATION_STRINGENCY=SILENT ALIGNED=/dev/stdin UNMAPPED=$1 OUTPUT=/dev/stdout REFERENCE_SEQUENCE=$3 EXPECTED_ORIENTATIONS=FR ATTRIBUTES_TO_RETAIN=X0 ATTRIBUTES_TO_RETAIN=XA ATTRIBUTES_TO_RETAIN=XS PAIRED_RUN=true SORT_ORDER=queryname IS_BISULFITE_SEQUENCE=false ALIGNED_READS_ONLY=false CLIP_ADAPTERS=false MAX_RECORDS_IN_RAM=2000000 ADD_MATE_CIGAR=true MAX_INSERTIONS_OR_DELETIONS=-1 PRIMARY_ALIGNMENT_STRATEGY=MostDistant ALIGNER_PROPER_PAIR_FLAGS=false UNMAP_CONTAMINANT_READS=false CLIP_OVERLAPPING_READS=false