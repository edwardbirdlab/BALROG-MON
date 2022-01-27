process prokka {
    container 'staphb/prokka:1.14.5'
    containerOptions = "--user root"
    publishDir "${params.project_name}/prokka", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
    output:
        path("${sample}.tar.gz"), emit: prokka_results

    script:

    """
    prokka --outdir ${sample} --prefix ${sample} ${fasta} --cpus 19 --centre X --compliant
    tar -zcvf ${sample}.tar.gz ./${sample}
    """
}