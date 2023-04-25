process argannot_db {
    label 'small'
    publishDir "${params.project_name}/ARG_Databases/argannot_db", mode: 'copy', overwrite: false

    output:
        tuple val('argannot'), path("argannot_nt_v6_db.fasta"), emit: argannot_fasta
        path("argannot_nt_v6_db.fasta"), emit: only_fa


    script:

    """
    wget https://www.mediterranee-infection.com/wp-content/uploads/2019/09/ARG-ANNOT_NT_V6_July2019.txt
    sed -i 's/:/|/g' ARG-ANNOT_NT_V6_July2019.txt
    cat ARG-ANNOT_NT_V6_July2019.txt > argannot_nt_v6_db.fasta
    """
}