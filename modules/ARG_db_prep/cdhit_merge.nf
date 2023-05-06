process cdhit_merge {
    label 'lowmem'
    container 'ebird013/cdhit:4.8.1'
    publishDir "${params.project_name}/ARG_Database_Merge/cdhit_merge", mode: 'copy', overwrite: false

    input:
        tuple file(db_1), file(db_2), file(db_3), file(db_4), file(db_5)


    output:
        path('merged_db_95.fasta'), emit: cdhit_db
        path('merged_db_95.fasta.clstr'), emit: cdhit_cluster
        path('.command.out'), emit: cdhit_report



    
        
    script:

    """
    cat *.fasta > merged.fasta
    cd-hit-est -i merged.fasta -o merged_db_95.fasta -c 0.99 -n 8
    """
}