/*
Subworkflow for annotation of Mobile elements and functional annoation of bacterial genomes
Requries set params:

NONE

*/

include { MEF as MEF } from '../modules/MEF.nf'
include { PROKKA as PROKKA } from '../modules/PROKKA.nf'
include { amrfinder_genome as amrfinder_genome } from '../modules/amrfinder_genome.nf'


workflow FUNCTIONAL_ANNOTATION {
    take:
        classified_assembly      //   channel: [ val(sample), path("${sample}_scaffolds.fasta")]

    main:

        MEF(classified_assembly)
        PROKKA(classified_assembly)
        
}