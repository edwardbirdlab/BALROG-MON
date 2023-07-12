process mef_plasmid {
    label 'lowmem'
    container 'mkhj/mobile_element_finder:latest'
    publishDir "${params.project_name}/Annotation/mef_plasmid", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
    output:
        tuple val(sample), path("./${sample}_mef_out_result.txt"), emit: mef_txt
        tuple val(sample), path("./${sample}_mef_out.csv"), emit: mef_csv
        tuple val(sample), path("./${sample}_mef_out_mge_sequences.fna"), emit: mef_fna

    script:

    """
    mefinder find --contig ${fasta} ${sample}_mef_out
    """
}