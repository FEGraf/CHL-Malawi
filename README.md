# CHL_Malawi_test2

Data and code for the 'Molecular mechanisms of re-emerging chloramphenicol
susceptibility in extended-spectrum beta-lactamase producing Enterobacterales'
manuscript. <https://www.biorxiv.org/content/10.1101/2023.11.16.567242v1>

The R code in this repo will generate the figures from the manuscript. The repo
is organised into folders, each of which contain data and R script (or markdown
or quarto - see below) files to generate one of the figures. 

To run the code on your machine first clone the repo e.g.

```
git clone https://github.com/FEGraf/CHL_Malawi_test2
```

Then navigate to the directory corresponding to the analysis you want to and run
the R script in your favorite way which will generate the figure.

The co-occurrence analysis and *cat* gene ST distribution analyses are wrapped in
Rmarkdown/quarto documents document, which, when rendered will reproduce the
analysis and figures from the manuscript. These will need the `quarto` command
line tool to be installed, which can be downloaded at
<https://quarto.org/docs/get-started/>, and the R `quarto` package; from within
R these can then be rendered using

```
quarto::quarto_render("Fig4_and_SFig6_Co_occurence_analysis/Co-occurrence analysis of AMR genes.Rmd")
quarto::quarto_render("Fig5_cat_genes_ST/Fig5__ST_Malawi_vs_100ST.qmd")
```

Alternatively the script `install_dependencies_and_run_all_analyses.R` will
install the needed R packages if they are not installed on your system, and run
all the analyses in turn to generate the plots and the Rmarkdown/quarto output.


