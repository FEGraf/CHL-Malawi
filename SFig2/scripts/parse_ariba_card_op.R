
library(tidyverse)
library(blantyreESBL)
library(here)

# get the metadata in sanger lane IDs

included_studies_df <-
  bind_rows(
    btESBL_sequence_sample_metadata |>
      transmute(
        lane = lane,
        lab_id = supplier_name,
        study = "DASSIM",
        species = case_when(
          species == "E. coli" ~ "E. coli",
          grepl("Kleb", species) ~ "KpSC",
          TRUE ~ NA_character_
        )
      ),
    btESBL_ecoli_musicha_metadata |>
      transmute(
        lane = lane,
        study = "musicha",
        species = "E. coli"
      ),
    btESBL_kleb_global_metadata |>
      filter(study == "musciha") |>
      transmute(
        lane = name,
        study = "musicha",
        species = "KpSC"
      )
  )

# get the raw ariba output

file_list <- read_lines("data-raw/ariba-card-reports.txt")

# This file is a list of the ariba output files to include 
# in the analysis
# you can generte (on linux/mac) by doing
# find . -name "report.tsv" > ariba-card-reports.txt at the 
# command line

# get the files and make a dataframe

list_out <- list()
for (i in seq_along(file_list)) {
  cat(paste0("Loading file ", i, " of ", length(file_list)))
  df <- read_tsv(file_list[i], show_col_types = FALSE)
  df$lane <- file_list[i]
  list_out[[i]] <- df
}

dfout <- do.call(rbind, list_out) 



# restrict to  catB3 and save

left_join(
  included_studies_df,
  by = "lane",
  dfout |>
    filter(grepl("catB3", `#ariba_ref_name`)) |>
    mutate(
      lane =
        gsub(
          "^./data-raw/ariba-card-output_(kleb|ecoli)/|/report.tsv",
          "",
          lane
        ),
      lane = gsub("#", "_", lane)
    )
) -> catb3_df

write_csv(catb3_df, here("data-processed/catb3_card_assembly_stats.csv"))
