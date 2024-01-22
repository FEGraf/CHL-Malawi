Files in this directory

ariba summary output files
==========================

data-raw/ariba_card_summary07092022.csv    summary of ariba output run on all dassim and musicha e coli using                                             card db
data-raw/ariba_srst2_summary07092022.csv    as above but using srst2

data-raw/ariba-card-kleb-summary-dassim-musicha.csv  as above but for kleb
data-raw/ariba-srst2-summary-dassim-musciha-kleb.csv

detailed ariba output from card to generate catB assembly stats
=================================================================

data-raw/ariba-card-output-kleb/    dir containing detailed outputfiles from
                                      ariba using card for kleb
data-raw/ariba-card-output-ecoli/    dir containing detailed outputfiles from
                                      ariba using card for e coli

data-raw/ariba-card_reports.txt       list of filenames of ariba output using card
                                     for e coli and kleb
					the above  files
scripts/parse_ariba_card_op.R   summarise the detailed card OP to generate the
                                        file data-processed/catb3_card_assembly_stats.csv

script to generate summaries of catB assemblies from srst2 and card
====================================================================

scripts/plot_catb3_assembled length.R   generate catB assembly length stats 

scripts/catb3ax.R    generate summary plots of ariba assembly flags
plots/ariba-card-assembly.pdf    summary plots of card catB assemblies
plots/ariba-srst2-assembly.pdf    as above but srst2

all dassim and musicha amr combined and script to generate
===========================================================

**these scripts only generate all amr for E coli - haven;t changed**

musciha_dassim_srst.R
data-processed/musicha_dassim_amr.csv
