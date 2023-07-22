process argdit_schema_check {
    label 'lowmem'
    container 'library://edwardbirdlab/bara/argdit:odseq.1.0'
    publishDir "${params.project_name}/ARG_Database_Merge/argdit_schema_check", mode: 'copy', overwrite: false

    input:
        tuple val(config_val), path(argdit_config)
        file(db_nt_fasta)


    output:
        path('*.log'), emit: schema_check_log


    
        
    script:

    """
    cp -R /opt/ARGDIT .
    cd ARGDIT
    rm -rf config.ini
    cp ../config.ini .
    cd ..
    ./ARGDIT/check_arg_db.py -e -f 3-4 ${db_nt_fasta}
    """
}