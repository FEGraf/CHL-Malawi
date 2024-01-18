# CHL_Malawi_test2

Data and code for the 'Molecular mechanisms of re-emerging chloramphenicol susceptibility in extended-spectrum beta-lactamase producing Enterobacterales' manuscript.
<https://www.biorxiv.org/content/10.1101/2023.11.16.567242v1>

The code will generate the figures from the manuscript. The repo is organised
into folders, each of which contain data and code to generate one of the
figures. 

To run the code on your machine first clone the repo i.e.

```
git clone https://github.com/FEGraf/CHL_Malawi_test2
```
On mac and linux.

Then navigate to the directory corresponding to the analysis you want to and run
the script there which will generate the figure.

The co-occurance analysis is wrapped in an Rmarkdown document, which, when
rendered will reproduce the analysis and figures from the manuscript. This can
be rendered with the `rmarkdown` package by running

```

rmarkdown::render("Fig4_and_SFig6_Co_occurence_analysis/Co-occurrence analysis of AMR genes.Rmd")
```

Alternatively the script `install_dependencies_and_run_all_analyses.R` will
install the needed R packages if they are not installed on your system, and run
all the analyses in turn to generate the plots and the Rmarkdown output.


