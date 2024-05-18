process KRAKEN_BETADIV {
    label 'lowmem'
	container 'ebird013/braken:2.9'

    input:
        file(brackens)
    output:
	   path("beta_diversity.txt"), emit: txt

    script:

    """
    beta_diversity.py -i ${brackens} --type bracken >> beta_diversity.txt
    """
}