## Trees annotated with genotypes and trunk substitutions

The code to generate Figures 2, 3, S1, S2, and S3.

1. Maximum-likelihood trees with 1000 trees were generated from phylip files of sequence alignments using RAxML.
As per GISAID terms and conditions, we have not made the sequence alignments available. However the ML trees are available in Dryad repository: https://doi.org/10.5061/dryad.s1d37

2. BEAST maximum clade credibility trees were generated for each gene using renaissance counting to reconstruct sequences
XMLs and output MCCTs are available in the Dryad repository

3. ML tree nodes were annotated with clade categories in FigTree v1.4.3

4. The following script was then used to summarise the clade category of each gene for every virus to output a genotype summary table.
`genotype_builder.py <out_prefix>`

i.e. `genotype_builder.py fluB` —> outputs: genotypes_fluB.txt

5. MCC trees were annotated with genotype constellations using ggtree in R:
`ggtree_genotype_consetllations.R`

6. Amino acid changes occurring on trunk branches (and estimated dates)were summarised from the BEAST posterior trees:
`trees_annotation_parser_cpvals_farm_mcct.py <beast_tree_file> <annotation_prefix> `

i.e. `trees_annotation_parser_cpvals_farm_mcct.py yam.HA.mcc.tre yam.HA.` —> outputs: annotated_yam.HA.mcc.tre & yam.HA.trunk_subs_dates.csv

7. Tree figures with trunk substitutions annotated were generated using ggtree in R:
`ggtree_clades_and_trunk_subs_segments.R`