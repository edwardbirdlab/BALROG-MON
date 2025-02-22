process FLYE_META {
    label 'midmem'
    container 'ebird013/flye:2.9.3'

    input:
        tuple val(sample), file(fastq)
    output:
        tuple val(sample), path("${sample}_fly/assembly.fasta"), emit: metagenome
        path("versions.yml"), emit: versions

    script:

    """
    mkdir ${sample}_fly
    flye --nano-hq ${fastq} --meta -o ${sample}_fly -t ${task.cpus}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        flye: \$(flye --version 2>&1)
    END_VERSIONS 
    """
}