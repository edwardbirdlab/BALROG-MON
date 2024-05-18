process VIRSORTER2 {
    label 'lowmemlong'
    container 'ebird013/virsorter2:2.2.4'

    input:
        tuple val(sample), file(fasta)
        path(DB)
    output:
        path("${sample}.out"), emit: result

    script:

    """
    virsorter config --init-source --db-dir=./${DB}
    virsorter run -w ${sample}.out -i ${fasta} --include-groups "dsDNAphage" --min-length 1000 -j 4 all
    """
}