/*
#######################################
############# Needed Params ###########
#######################################

params.lrbinner_kmmer_size      # k value for k-mer frequency vector. Choose between 3 and 5 (default=3)
params.lrbinner_bin_size        # Bin Size for coverage histogram (default=10)
params.lrbinner_bin_count       # Bin Count for coverage histogram (default=32)
params.lrbinner_min_bin_size    # Minimum number of reads a bin should have (default=10000)
params.lrbinner_bin_itterations # Number of iterations for cluster search. Use 0 for exhaustive search (default=1000)

*/




process LRBINNER_READS {
    label 'midmemlong'
    container 'ebird013/lrbinner:1.0'

    input:
        tuple val(sample), file(reads)
    output:
        tuple val(sample), path("./${sample}_lrbinner"), emit: bins

    script:

    """
    gunzip ${reads}
    mkdir ${sample}_lrbinner
    lrbinner.py reads --reads-path ${sample}.fastq --output ${sample}_lrbinner --k-size ${params.lrbinner_kmmer_size} --bin-size ${params.lrbinner_bin_size} --bin-count ${params.lrbinner_bin_count} --threads ${task.cpus} --separate --min-bin-size ${params.lrbinner_min_bin_size} --bin-iterations ${params.lrbinner_bin_itterations}
    
    """
}

process LRBINNER_CONTIGS {
    label 'midmemlong'
    container 'ebird013/lrbinner:1.0'

    input:
        tuple val(sample), file(reads), file(scaffolds)
    output:
        tuple val(sample), path("./${sample}_lrbinner"), emit: bins

    script:

    """

    mkdir ${sample}_lrbinner
    lrbinner.py reads --reads-path ${reads} --output ${sample}_lrbinner --k-size ${params.lrbinner_kmmer_size} --bin-size ${params.lrbinner_bin_size} --bin-count ${params.lrbinner_bin_count} --threads ${task.cpus} --separate --min-bin-size ${params.lrbinner_min_bin_size} --bin-iterations ${params.lrbinner_bin_itterations}

    """
}