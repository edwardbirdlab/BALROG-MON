process amrfinder_db {
   label 'lowmem'
    container 'library://edwardbird/bara/gtdbtk:1.5.0'
    publishDir "${params.project_name}/AMRFinder_db", mode: 'copy', overwrite: false

    input:

    output:
        path("amr_finder_cds.fasta"), emit: amrfinder_db_cds
        path("ReferenceGeneCatalog.txt"), emit: amrfinder_db_reference
        path("amr_targets.fasta"), emit: amrfinder_db_targets
        path("version.txt"), emit: amrfinder_db_version

    script:

    """
    wget https://ftp.ncbi.nlm.nih.gov/pathogen/Antimicrobial_resistance/AMRFinderPlus/database/latest/AMR_CDS
    wget https://ftp.ncbi.nlm.nih.gov/pathogen/Antimicrobial_resistance/AMRFinderPlus/database/latest/ReferenceGeneCatalog.txt
    wget https://ftp.ncbi.nlm.nih.gov/pathogen/Antimicrobial_resistance/AMRFinderPlus/database/latest/amr_targets.fa
    wget https://ftp.ncbi.nlm.nih.gov/pathogen/Antimicrobial_resistance/AMRFinderPlus/database/latest/version.txt
    mv amr_targets.fa amr_targets.fasta
    mv AMR_CDS amr_finder_cds.fasta
    """
}