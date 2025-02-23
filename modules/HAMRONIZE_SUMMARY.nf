process HAMRONIZE_SUMMARY {
   label 'lowmemnk'
    container 'ebird013/hamronization:1.1.8'

    input:
        file(reports)

    output:
        path("all_amr_summary.tsv"), emit: tsv
        path("all_amr_summary.html"), emit: html
        path("versions.yml"), emit: versions

    script:

    """
    hamronize summarize -t tsv -o all_amr_summary.tsv ${reports}
    hamronize summarize -t interactive -o all_amr_summary.html ${reports}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        hamronization: \$(hamronize -v 2>&1 | sed -e "s/hamronize //g")
    END_VERSIONS  
    """
}