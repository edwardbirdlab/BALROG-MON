process KRAKEN_BETADIV {
    label 'lowmem'
	container 'ebird013/braken:2.9'
    publishDir "${params.project_name}/Kraken2_BETA_Diveristy/${task.process}", mode: 'copy', overwrite: true

    input:
        file(brackens)
    output:
	   path("beta_diversity.txt"), emit: txt

    script:

    """
    beta_diversity.py -i ${brackens} --type bracken >> beta_diversity.txt
    """
}