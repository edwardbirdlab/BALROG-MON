process VIRSORTER2 {
    label 'lowmemlong'
    container 'ebird013/virsorter2:2.2.4'

    input:
        tuple val(sample), file(fasta)
        path(DB)
    output:
        path("${sample}.out"), emit: result
        path("versions.yml"), emit: versions

    script:

    """
    virsorter config --init-source --db-dir=./${DB}
    virsorter run -w ${sample}.out -i ${fasta} --include-groups "dsDNAphage" --min-length 1000 -j 4 all

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        Virsorter2: \$(virsorter --version 2>&1 | grep "VirSorter" | sed -E "s/.*VirSorter //g")
    END_VERSIONS 
    """
}