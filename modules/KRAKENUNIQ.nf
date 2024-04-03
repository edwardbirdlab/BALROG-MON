process KRAKENUNIQ {
    label 'krackenuniq'
	container 'ebird013/kracken_uniq:1.0.3'
    publishDir "${params.project_name}/Pre_Processing/krackenuni", mode: 'copy', overwrite: true

    input:
        tuple val(sample), file(R1), file(R2)
        tuple file(kdb), file(db)
    output:
	    tuple val(sample), file("${report_name}"), emit: report
        tuple val(sample), file("${output_name}"), emit: output
        tuple val(sample), file("${report_name}"), file("${output_name}"), emit: report_sample

    script:

    report_name = sample + '_kreport.tsv'
    output_name = sample + '_koutput.tsv'

    """
    mkdir krackendbdir
    mv $kdb krackendbdir
    mv $db krackendbdir
    cd krackendbdir
    tar zxvf $db
    cd ..
    krakenuniq --db krackendbdir --paired --threads ${task.cpus} --preload-size 8G --report-file ${report_name} --output ${output_name} --fastq-input ${R1} ${R2}
    """
}

//${task.memory.toGiga()}