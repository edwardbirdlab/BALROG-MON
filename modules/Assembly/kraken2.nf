process kraken2 {
    label 'lowmemlong'
	container 'ebird013/kracken2:2.1.3'
    publishDir "${params.project_name}/kraken2", mode: 'copy', overwrite: true

    input:
        val(ref)
        tuple val(kracken_db), file(txt), file(db)
    output:
	   path('*.tsv'), emit: tsv

    script:

    """
    mkdir krakendb
    mv $txt krakendb
    mv $db krakendb
    cd krakendb
    tar zxvf $db
    cd ..
    kraken2 --db krakendb --threads 16 --output kraken_out.tsv --report kraken_report.tsv --memory-mapping ${ref}
    """
}