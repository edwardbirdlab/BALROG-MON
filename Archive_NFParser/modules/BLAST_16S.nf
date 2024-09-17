process BLAST_16S {
    label 'lowmem'
    container 'library://edwardbird/bara/ncbi_blast:1.0'

    input:
        tuple val(sample), path(fasta)
        path(db)

    output:
        path("results.out.tsv"), emit: results_16s

    script:

    """
    blastn -query $fasta -db ./${db}/16S_ribosomal_RNA -outfmt 6 -max_target_seqs 1 -out results.out.tsv
    """
}