process amrfinder_genome {
   label 'lowmem'
    container 'library://edwardbirdlab/bara/amrfinderplus:3.11.4'
    publishDir "${params.project_name}/AMR_Annotation/AMRFinder_genome", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
    output:
        path("./${sample}_AMRFinder.tsv"), emit: amrfinder_genome_results

    script:

    """
    amrfinder -n ${fasta} -o ${sample}_AMRFinder.tsv
    """
}