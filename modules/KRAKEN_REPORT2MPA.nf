process KRAKEN_REPORT2MPA {
    label 'lowmem'
	container 'ebird013/braken:2.9'

    input:
        tuple val(sample), file(report)
    output:
	   tuple val(sample), path("${sample}.txt"), emit: mpa
       path("versions.yml"), emit: versions

    script:

    """
    kreport2mpa.py -r ${report} -o ${sample}.txt --display-header

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        KrakenTools: 1.2
    END_VERSIONS 
    """
}