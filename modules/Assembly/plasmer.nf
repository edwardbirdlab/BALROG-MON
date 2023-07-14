process plasmer {
    label 'medmem'
    container 'nekokoe/plasmer:23.04.20'
    publishDir "${params.project_name}/Assembly/plasmer", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
        tuple file(k2_db), file(main_db)
    output:
        tuple val(sample), path("platon_${sample}/*.tsv"), emit: report
        tuple val(sample), path("platon_${sample}/*.log"), emit: log
        tuple val(sm_gen), path("platon_${sample}/*.chromosome.fasta"), emit: predict_chr
        tuple val(sm_plas), path("platon_${sample}/*.plasmid.fasta"), emit: predict_plas
        
    script:


    """
    mkdir db
    cp ${k2_db} db
    cp ${main_db} db
    cd db
    tar -xf *
    cd ..
    Plasmer -g ${fasta} -p ${sample} -d db -t ${task.cpus} -m ${params.plasmer_min_len} -l ${params.plasmer_max_len} -o .
    """
}