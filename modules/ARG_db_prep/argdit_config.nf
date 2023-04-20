process argdit_config {
    label 'lowmem'
    container 'library://edwardbirdlab/bara/argdit:odseq.1.0'
    publishDir "${params.project_name}/ARG_Database_Merge/argdit_config", mode: 'copy', overwrite: false

    output:
        tuple val('config'), path('config.ini'), emit: config
        
    script:

    fhfs = 'FastaHeaderFieldSeparator = ' + params.argdit_FastaHeaderFieldSeparator
    ofs = 'OperationalFieldSeparator = ' + params.argdit_OperationalFieldSeparator
    msc = 'MinSequenceCount = ' + params.argdit_MinSequenceCount
    bsf = 'BootstrapFactor = ' + params.argdit_BootstrapFactor
    email = 'Email = ' + params.argdit_Email
    dgc = 'DefaultGeneticCode = ' + params.argdit_DefaultGeneticCode

    """
    cp /opt/ARGDIT/config.ini .
    sed -i 's/FastaHeaderFieldSeparator = |/${fhfs}/g' config.ini
    sed -i 's/OperationalFieldSeparator = __/${ofs}/g' config.ini
    sed -i 's/MinSequenceCount = 3/${msc}/g' config.ini
    sed -i 's/BootstrapFactor = 1000/${bsf}/g' config.ini
    sed -i 's/Email = /${email}/g' config.ini
    sed -i 's/DefaultGeneticCode = 11/${dgc}/g' config.ini
    """
}