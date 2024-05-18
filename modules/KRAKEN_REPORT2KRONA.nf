process KRAKEN_REPORT2KRONA {
    label 'lowmem'
	container 'ebird013/kraken2blob:1.0'

    input:
        tuple val(sample), file(report)
    output:
	   tuple val(sample), path("${sample}.krona"), path("${sample}.krona.html"), emit: krona

    script:

    """
    kreport2krona.py -r ${report} -o ${sample}.krona
    ktImportText ${sample}.krona -o ${sample}.krona.html
    """
}