process SYLPH_PROFILE_SE {
    label 'sylph_profile'
    container 'ebird013/sylph:0.5.1_exec'

    input:
        tuple val(sample), file(fastq), file(db)
    output:
        path("${sample}_profile.tsv"), emit: profile
        path("versions.yml"), emit: versions

    script:

    """
    sylph sketch ${fastq} -S ${sample}_sketch
    sylph profile ${sample}_sketch.sylsp ${db} -t ${task.cpus} -o ${sample}_profile.tsv

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        sylph: \$(sylph --version 2>&1 | grep "sylph" | sed -e "s/sylph //g")
    END_VERSIONS 
    """
}