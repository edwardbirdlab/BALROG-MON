process LONGSTITCH {
    label 'midmemlong'
    container 'ebird013/longstitch:1.0.5'
    publishDir "${params.project_name}/Assembly/${task.process}", mode: 'copy', overwrite: true

    input:
        file(fastq)
        file(ref)
    output:
        tuple val(sample), path("scaffold.k32.w100.tigmint-ntLink.longstitch-scaffolds.fa"), emit: stitched_genome

    script:

    """
    mv ${ref} scaffold.fa
    mv ${fastq} reads.fq.gz
    longstitch run draft=scaffold reads=reads G=1e9
    """
}