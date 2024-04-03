process KRAKEN_REPORT2MPA {
    label 'lowmem'
	container 'ebird013/braken:2.9'
    publishDir "${params.project_name}/Kraken2_mpa/${sample}", mode: 'copy', overwrite: true

    input:
        tuple val(sample), file(report)
    output:
	   tuple val(sample), path("${sample}.txt"), emit: mpa

    script:

    """
    kreport2mpa.py -r ${report} -o ${sample}.txt --display-header
    """
}