process KRAKEN2_PLUSPF_SE {
    label 'kracken2_PlusPF'
	container 'ebird013/kraken2:latest'

    input:
        tuple val(sample), file(R1)
        tuple file(txt), file(db)
    output:
	   tuple val(sample), path("${sample}_out.tsv"), emit: out
       tuple val(sample), path("${sample}_report.tsv"), emit: report

    script:

    """
    mkdir krakendb
    mv $txt krakendb
    mv $db krakendb
    cd krakendb
    tar zxvf $db
    cd ..
    kraken2 --db krakendb --threads ${task.cpus} --output ${sample}_out.tsv --report ${sample}_report.tsv --report-minimizer-data --minimum-hit-groups {params.k2_min_hit_group} --confidence {params.k2_confidence} ${R1}
    """
}