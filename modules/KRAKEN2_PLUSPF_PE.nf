process KRAKEN2_PLUSPF_PE {
    label 'kracken2_PlusPF'
	container 'ebird013/kracken2:2.1.3'
    publishDir "${params.project_name}/Assembly/kraken2/${sample}/${task.process}", mode: 'copy', overwrite: true

    input:
        tuple val(sample), file(R1), file(R2)
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
    kraken2 --db krakendb --threads ${task.cpus} --output ${sample}_out.tsv --report ${sample}_report.tsv --report-minimizer-data --minimum-hit-groups 3 ${R1} ${R2}
    """
}