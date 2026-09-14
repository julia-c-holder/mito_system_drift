#SAMPLES = ["8", "9"]
rule all:
    input: "../results/snakemake/within/unnorm_{sample}_collected.csv"

rule collect_raw:
    input:
    params:
        repnum="{wildcard.sample}"
    output:
        out="../results/snakemake/within/unnorm_{sample}_collected.csv"
    shell:
        "Rscript collect_var_big.R"

#rule normal_maker:

#rule within_pop_var:

#rule collect_final:
