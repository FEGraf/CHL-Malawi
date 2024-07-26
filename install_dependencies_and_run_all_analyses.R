# This script will check if you have the needed packages installed
# And if not, install them
# And will then run all the different analyses in the repo

check_package_and_install <- function(package) {
  if (!require(package, character.only = TRUE, quietly = TRUE)) {
    print(paste0(package, " not installed - installing"))
    install.packages(package)
  } else {
    print(paste0(package, " installed - loaded"))
  }
}

dependencies <-
  c(
    "tidyverse",
    "ggpubr",
    "igraph",
    "readr",
    "cooccur",
    "reshape2",
    "pheatmap",
    "RColorBrewer",
    "here",
    "rmarkdown",
    "janitor",
    "lemon",
    "quarto",
    "devtools",
    "scales"
  )

# Check and install

for (package in dependencies) {
  check_package_and_install(package)
}

# to plot SFig2 also need the blantyreESBL package for DASSIM study metadata
# which is installed from github

if (!require("blantyreESBL")) {
  devtools::install_github("https://github.com/joelewis101/blantyreESBL")
}

# Run the scripts
library(here)

source(here("Fig1/code_Fig1.R"))
source(here("Fig2_rCAT/code_Fig2_rCAT.R"))
quarto::quarto_render("Fig4_and_SFig7_Co_occurence_analysis/Co-occurrence analysis of AMR genes.Rmd")
quarto::quarto_render("Fig5_cat_genes_ST/Fig5__ST_Malawi_vs_100ST.qmd")
source(here("SFig1/code_SFig1.R"))
source(here("SFig3/catb3ax_SFig3a.R"))
source(here("SFig3/plot_catb3_assembled_length_all_SFig3b.R"))
source(here("SFig5_HRM/SFig5_code_final.R"))
source(here("SFig8_catB_frequency/code_FigS8_microbiggE_catB.R"))
source(here("SFig9_ST/code_FigS9_ST.R"))
