#!/usr/bin/env nextflow

genomes = "../scaffolds"
out_dir = "./nextflow_out"
project_name = "card_genome4"

genome = Channel.fromPath("${genomes}/*fa").map  { file -> tuple(file.baseName, file) }

process database{
    tag { "${project_name}.database.${sample}" }
    publishDir "${out_dir}/${project_name}/database", mode: 'copy', overwrite: false


    output:
        file("localDB.tar") into database_ch

    script:

    """
    mkdir localDB
    cd localDB
    wget https://card.mcmaster.ca/latest/data
    tar -xvf data ./card.json
    cd ..
    tar -cvf localDB.tar localDB
    """
}

genome_database = genome.combine(database_ch)

process card{
	container 'quay.io/biocontainers/rgi:5.1.1--py_0'
    tag { "${project_name}.card.${sample}" }
    publishDir "${out_dir}/${project_name}/card", mode: 'copy', overwrite: false

    input:
        set sample, file(fasta), file(database) from genome_database


    output:
        set sample, file("${sample}_dir.tar") into outdata

    script:

    """
    tar -xvf localDB.tar
    mkdir $sample
    rgi main --input_sequence $fasta --output_file ./${sample}/${sample}_out --input_type contig --local --clean
    tar -cvf ${sample}_dir.tar ${sample}
    """
}


workflow.onComplete {

    println ( workflow.success ? """
        Pipeline execution summary
        ---------------------------
        Completed at: ${workflow.complete}
        Duration    : ${workflow.duration}
        Success     : ${workflow.success}
        workDir     : ${workflow.workDir}
        exit status : ${workflow.exitStatus}
        """ : """
        Failed: ${workflow.errorReport}
        exit status : ${workflow.exitStatus}
        """
    )
}
