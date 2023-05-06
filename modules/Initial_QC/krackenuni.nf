process krackenuni {
    label 'kracken'
	container 'ebird013/kracken_uniq:1.0.3'
    publishDir "${params.project_name}/Pre_Processing/krackenuni", mode: 'copy', overwrite: true

    input:
        tuple val(sample), file(R1), file(R2)
        tuple val(kracken_db), file(kdb), file(db)
    output:
	    tuple val(sample), file('*.tsv'), emit: tsv

    script:

    out_name = sample + '_kracken.tsv'

    """
    mkdir krackendb
    mv $kdb krackendb
    mv $db krackendb
    cd krackendb
    tar zxvf $db
    cd ..
    krakenuniq --db krackendb --threads 16 --report-file ${out_name} --fastq-input *.fq.gz
    """
}