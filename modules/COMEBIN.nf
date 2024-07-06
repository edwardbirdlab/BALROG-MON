process COMEBIN {
    label 'midmemlong'
    container 'ebird013/combine:1.0.3'

    input:
        tuple val(sample), file(scaffolds), file(bam), file(bai)
    output:
        tuple val(sample), path("./${sample}_comebin_out"), emit: bins

    script:

    """
    cp -r /opt/COMEBin .
    mkdir ./COMEBin/COMEBin/${sample}_bams
    mv ${bam} ./COMEBin/COMEBin/${sample}_bams
    mv ${bai} ./COMEBin/COMEBin/${sample}_bams
    mkdir ./COMEBin/COMEBin/${sample}_comebin_out
    mv ${scaffolds} ./COMEBin/COMEBin/
    cd ./COMEBin/COMEBin/
    ./run_comebin.sh -a ${scaffolds} -p ${sample}_bams -o ${sample}_comebin_out -n ${params.comebin_num_views} -t ${task.cpus}
    """
}