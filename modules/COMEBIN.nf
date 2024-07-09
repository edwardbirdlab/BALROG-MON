process COMEBIN {
    label 'midmemlong'
    container 'ebird013/comebin:1.0.4_cpu'

    input:
        tuple val(sample), file(scaffolds), file(bam), file(bai)
    output:
        tuple val(sample), path("./${sample}_comebin_out"), emit: bins

    script:

    """
    conda init bash
    conda activate comebin_env
    cp -r /home .
    mkdir ./home/COMEBin/COMEBin/${sample}_bams
    mv ${bam} ./home/COMEBin/COMEBin/${sample}_bams
    mv ${bai} ./home/COMEBin/COMEBin/${sample}_bams
    mkdir ./home/COMEBin/COMEBin/${sample}_comebin_out
    mv ${scaffolds} ./home/COMEBin/COMEBin/
    cd ./home/COMEBin/COMEBin/
    ./run_comebin.sh -a ${scaffolds} -p ${sample}_bams -o ${sample}_comebin_out -n ${params.comebin_num_views} -t ${task.cpus}
    """
}