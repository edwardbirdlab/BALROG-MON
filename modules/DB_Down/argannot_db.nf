process argannot_db {
    label 'small'
    publishDir "${params.project_name}/argannot_db", mode: 'copy', overwrite: false

    output:
        path("argannot_nt_v6.fasta"), emit: argannot_fasta


    script:

    """
    wget https://www.mediterranee-infection.com/wp-content/uploads/2019/09/ARG-ANNOT_NT_V6_July2019.txt
    cat ARG-ANNOT_NT_V6_July2019.txt > argannot_nt_v6.fasta
    """
}