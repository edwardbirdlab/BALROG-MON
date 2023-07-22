process KRAKEN2 {
    label 'kracken2'
	container 'ebird013/kracken2:2.1.3'
    publishDir "${params.project_name}/Assembly/kraken2/${sample}", mode: 'copy', overwrite: true

    input:
        tuple val(sample), file(ref)
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
    kraken2 --db krakendb --threads 16 --output ${sample}_out.tsv --report ${sample}_report.tsv ${ref}
    """
}