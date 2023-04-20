process argdit_checkdb_nt {
    label 'lowmem'
    container 'library://edwardbirdlab/bara/argdit:1.0'
    publishDir "${params.project_name}/argdit_checkdb_nt", mode: 'copy', overwrite: false

    input:
        tuple val(config_val), path(argdit_config)
        tuple val(db_source), file(db_nt_fasta)


    output:
        tuple val(db_check), path('*.log'), emit: db_check_log


    
        
    script:

    db_check = db_source + '_check'

    """
    cp -R /opt/ARGDIT .
    cd ARGDIT
    rm -rf config.ini
    cp ../config.ini .
    cd ..
    ./ARGDIT/check_arg_db.py -e ${db_nt_fasta}
    """
}