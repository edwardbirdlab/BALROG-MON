process blastn {
    label 'lowmem'
	container 'ncbi/blast:2.14.0'
    publishDir "${params.project_name}/Pre_Processing/blastn", mode: 'copy', overwrite: false

    input:
        file(ref)
    output:
	    path('blastn_results.out'), emit: result


    script:


    """
    awk -F'\t' '$1 != "U" { print $0 }' "$input_file" > "$output_file"
    awk -F'\t' '{ for (i=2; i<=NF; i++) if (i != 5) printf "%s\t", $i; printf "\n" }' "$input_file" | cut -d$'\t' -f 1-3 > "$output_file"
    blastn -query ${ref} -db /scratch/edwardbird/blast_dbs/nr -outfmt "6 qseqid staxids bitscore std" -max_target_seqs 1 -max_hsps 1 -out blastn_results.out
    """
}