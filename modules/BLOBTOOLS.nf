process BLOBTOOLS {
    label 'lowmem'
	container 'ebird013/blobtools:1.1'
    publishDir "${params.project_name}/Assembly_QC/blobtools/${sample}", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(ref), file(bam), file(bai), file(hits)

    output:
	    path('*png'), emit: graphs
        path('*.txt'), emit: stats

    script:


    """
    mkdir blob_out
    blobtools create -i ${ref} -b ${bam} -t ${hits} -o ./blob_out/${sample}
    blobtools view -i ./blob_out/${sample}.blobDB.json
    blobtools plot -i ./blob_out/${sample}.blobDB.json
    """
}