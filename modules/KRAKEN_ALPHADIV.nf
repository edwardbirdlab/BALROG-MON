process KRAKEN_ALPHADIV {
    label 'lowmem'
	container 'ebird013/braken:2.9'
    publishDir "${params.project_name}/Kraken2_Alpha_Diveristy/${sample}/${task.process}", mode: 'copy', overwrite: true

    input:
        tuple val(sample), file(report)
    output:
	   tuple val(sample), path("${sample}_alphadiv.txt"), emit: txt

    script:

    """
    alpha_diversity.py -f ${report} -a Sh >> ${sample}_alphadiv.txt
    """
}