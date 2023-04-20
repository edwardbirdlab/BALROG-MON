process amrfinder_db {
   label 'lowmem'
    container 'library://edwardbird/bara/gtdbtk:1.5.0'
    publishDir "${params.project_name}/ARG_Databases/AMRFinder_db", mode: 'copy', overwrite: false

    input:

    output:
        tuple val('amrfinder'), path("amrfinderplus_db.fasta"), emit: amrfinder_db_cds
        path("amrfinderplus_db.fasta"), emit: only_fa
        tuple val('amrfinder'), path("ReferenceGeneCatalog.txt"), emit: amrfinder_db_reference
        tuple val('amrfinder'), path("amr_targets.fasta"), emit: amrfinder_db_targets
        tuple val('amrfinder'), path("version.txt"), emit: amrfinder_db_version

    script:

    """
    wget https://ftp.ncbi.nlm.nih.gov/pathogen/Antimicrobial_resistance/AMRFinderPlus/database/latest/AMR_CDS
    wget https://ftp.ncbi.nlm.nih.gov/pathogen/Antimicrobial_resistance/AMRFinderPlus/database/latest/ReferenceGeneCatalog.txt
    wget https://ftp.ncbi.nlm.nih.gov/pathogen/Antimicrobial_resistance/AMRFinderPlus/database/latest/amr_targets.fa
    wget https://ftp.ncbi.nlm.nih.gov/pathogen/Antimicrobial_resistance/AMRFinderPlus/database/latest/version.txt
    mv amr_targets.fa amr_targets.fasta
    mv AMR_CDS amrfinderplus_db.fasta
    """
}