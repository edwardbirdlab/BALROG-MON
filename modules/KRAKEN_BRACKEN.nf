process KRAKEN_BRACKEN {
    label 'lowmem'
	container 'ebird013/braken:2.9'
    publishDir "${params.project_name}/Bracken_Krona/${sample}/${task.process}", mode: 'copy', overwrite: true

    input:
        tuple val(sample), file(report)
        tuple file(txt), file(db)
    output:
	   tuple val(sample), path("${sample}.bracken"), path("${sample}.breport"), emit: full
       tuple val(sample), path("${sample}.breport"), emit: report
       tuple val(sample), path("${sample}.bracken"), emit: bracken
       path("${sample}.bracken"), emit: bracken_only

    script:

    """
    mkdir krakendb
    mv $txt krakendb
    mv $db krakendb
    cd krakendb
    tar zxvf $db
    cd ..
    bracken -d krakendb -i ${report} -r 150 -l S -t 10 -o ${sample}.bracken -w ${sample}.breport
    """
}