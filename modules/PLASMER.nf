process PLASMER {
    label 'plasmer'
    container 'nekokoe/plasmer:23.04.20'

    input:
        tuple val(sample), file(fasta)
        tuple file(k2_db), file(main_db)
    output:
        tuple val(sample), path("*.shorterM.fasta"), emit: too_short, optional: true
        tuple val(sample), path("*.Plasmids.fa"), emit: pred_plasmids, optional: true
        tuple val(sample), path("*.predClass.tsv"), emit: pred_class
        tuple val(sample), path("*.predProb.tsv"), emit: probability, optional: true
        tuple val(sample), path("*.predPlasmids.taxon"), emit: pred_taxon, optional: true

        
    script:


    """
    mkdir db
    cp ${k2_db} db
    cp ${main_db} db
    cd db
    tar -xf ${k2_db}
    tar -xf ${main_db}
    cd ..
    /scripts/Plasmer -g ${fasta} -p ${sample} -d db -t ${task.cpus} -m ${params.plasmer_min_len} -l ${params.plasmer_max_len} -o .
    cd results
    cp * ..
    cd ..
    """
}