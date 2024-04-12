process SYLPH_PROFILE_SE {
    label 'sylph_profile'
    container 'ebird013/sylph:0.5.1_exec'
    publishDir "${params.project_name}/Identificaion/${task.process}", mode: 'copy', overwrite: true

    input:
        tuple val(sample), file(fastq), file(db)
    output:
        path("${sample}_profile.tsv"), emit: profile

    script:

    """
    sylph sketch ${fastq} -S ${sample}_sketch
    sylph profile ${sample}_sketch.sylsp ${db} -t ${task.cpus} -o ${sample}_profile.tsv
    """
}