process KRAKEN_BETADIV {
    label 'lowmem'
	container 'ebird013/braken:2.9'

    input:
        file(brackens)
    output:
	   path("beta_diversity.txt"), emit: txt
       path("versions.yml"), emit: versions

    script:

    """
    beta_diversity.py -i ${brackens} --type bracken >> beta_diversity.txt

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        KrakenTools: 1.2
    END_VERSIONS 
    """
}