process RENAME_READS {
    label 'ultralow'
    container 'ebird013/seqtk:1.4'

    input:
        tuple val(sample), file(fastq)
    output:
        tuple val(sample), path("${sample}_rename.fastq.gz"), emit: renamed_reads

    shell:

    '''
    zcat "!{fastq}" | awk '{print (NR%4 == 1) ? "@1_" ++i : $0}' | gzip -c > "!{sample}_rename.fastq.gz"
    echo "Conversion completed. Output saved to !{sample}_rename.fastq.gz"
    '''
}
