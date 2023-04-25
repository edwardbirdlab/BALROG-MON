process argdit_uniprot {
    label 'lowmem'
    container 'library://edwardbirdlab/bara/argdit:odseq.1.0'
    publishDir "${params.project_name}/ARG_Database_Merge/argdit_uniprot", mode: 'copy', overwrite: false

    input:
        tuple val(config_val), path(argdit_config)
        file(db_nt_fasta)


    output:
        path('converted_${db_nt_fasta}'), emit: converted_db
        path('*.log'), emit: db_check_log


    
        
    script:

    """
    cp -R /opt/ARGDIT .
    cd ARGDIT
    rm -rf config.ini
    cp ../config.ini .
    cd ..
    ./ARGDIT/convert_id_uniprot_to_ncbi.py ${db_nt_fasta} converted_${db_nt_fasta}
    """
}