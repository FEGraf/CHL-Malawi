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
    "janitor"
  )

# Check and install

for (package in dependencies) {
  check_package_and_install(package)
}

# Run the scripts

source(here("Fig1/code_Fig1.R"))
source(here("Fig2_rCAT/code_Fig2_rCAT.R"))
rmarkdown::render("Fig4_and_SFig6_Co_occurence_analysis/Co-occurrence analysis of AMR genes.Rmd")
source(here("SFig7_catB_frequency/code_FigS7_microbiggE_catB.R"))
source(here("SFig8_ST/code_FigS8_ST.R"))
