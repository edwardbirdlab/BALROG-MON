process MEF {
    label 'lowmem'
    container 'mkhj/mobile_element_finder:latest'

    input:
        tuple val(sample), file(fasta)
    output:
        tuple val(sample), path("./${sample}_mef_out_result.txt"), emit: mef_txt
        tuple val(sample), path("./${sample}_mef_out.csv"), emit: mef_csv
        tuple val(sample), path("./${sample}_mef_out_mge_sequences.fna"), emit: mef_fna
        path("versions.yml"), emit: versions

    script:

    """
    mefinder find --contig ${fasta} ${sample}_mef_out

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        MEF: \$(mefinder --version 2>&1)
    END_VERSIONS 
    """
}