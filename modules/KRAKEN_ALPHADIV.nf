process KRAKEN_ALPHADIV {
    label 'lowmem'
	container 'ebird013/braken:2.9'

    input:
        tuple val(sample), file(report)
    output:
	   tuple val(sample), path("${sample}_alphadiv.txt"), emit: txt

    script:

    """
    alpha_diversity.py -f ${report} -a Sh >> ${sample}_alphadiv.txt
    """
}