process amrfinder_plasmid {
   label 'lowmem'
    container 'library://edwardbirdlab/bara/amrfinderplus:3.11.4'
    publishDir "${params.project_name}/AMR_Annotation/AMRFinder_plasmid", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
    output:
        path("./${sample}_AMRFinder.tsv"), emit: amrfinder_plasmid_results

    script:

    """
    amrfinder -n ${fasta} -o ${sample}_AMRFinder.tsv
    """
}