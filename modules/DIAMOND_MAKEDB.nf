process DIAMOND_MAKEDB {
    label 'lowmem'
    container 'buchfink/diamond:version2.0.13'
    publishDir "${params.project_name}/ARG_Database_Merge/diamond_db", mode: 'copy', overwrite: false

    input:
        file(fasta)

    output:
        path("arg_diamond_db"), emit: db

    script:

    """
    diamond makedb --in ${fasta} -d arg_diamond_db
    """
}