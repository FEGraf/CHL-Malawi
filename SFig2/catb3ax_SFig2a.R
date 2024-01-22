#title: "cat assemblies"
#author: "JL"
#date: 13/09/23


#load packages
library(tidyverse)
library(blantyreESBL)
library(here)

# ariba using both srst2 and card on the dassim and musciha e coli
# it aims to look at what cat genes were identfied using each database
# UPDATE 13 Sept 2023 - added klebs to ax

df_srst2_ecoli <-
  read_csv(here("ariba_srst2_summary07092022.csv"))

df_srst2_kleb <-
  read_csv(here("~ariba-srst2-summary-dassim-musciha-kleb.csv"))



included_studies_df <-
  bind_rows(
    btESBL_sequence_sample_metadata |>
      transmute(
        lane = lane,
        lab_id = supplier_name,
        study = "ESBL",
        species = case_when(
          species == "E. coli" ~ "E. coli",
          grepl("Kleb", species) ~ "KpSC",
          TRUE ~ NA_character_
        )
      ),
    btESBL_ecoli_musicha_metadata |>
      transmute(
        lane = lane,
        study = "Bacteraemia",
        species = "E. coli"
      ),
    btESBL_kleb_global_metadata |>
      filter(study == "musciha") |>
      transmute(
        lane = name,
        study = "Bacteraemia",
        species = "KpSC"
      )
  )


left_join(
  included_studies_df,
  by = c("lane" = "name"),
  df_srst2_kleb |>
    select(contains("Cat") | contains("name")) |>
    mutate(
      name = gsub("^./|/report.tsv", "", name),
      name = gsub("#", "_", name)
    ) |>
  bind_rows(
  df_srst2_ecoli |>
    select(contains("Cat") | contains("name")) |>
    mutate(
      name = gsub("^./|/report.tsv", "", name),
      name = gsub("#", "_", name)
    )) |>
    mutate(across(matches("assembled|match"), ~ if_else(is.na(.x), "no",.x)))
) |>
  pivot_longer(-c(lane, study, species),
    names_to = c("cluster_name", ".value"),
    names_sep = "\\."
  ) |>
  filter(!is.na(ref_seq)) |>
  mutate(ref_seq = sapply(strsplit(ref_seq, split = "__"),
                          function(x) x[3])) |>
  group_by(study, species, ref_seq, assembled) |>
  tally() |>
  ggplot(aes(assembled, n, fill = species)) +
  geom_col() +
  facet_grid(study ~ ref_seq, scales = "free_y") +
  theme_bw() +
  theme(legend.text = element_text(face = "italic")) +
  theme(strip.background = element_rect(fill="#f7fcfd")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "ARIBA assembly flag for cat genes using SRST2") -> FigS2a

ggsave(here("ariba-srst2-assembly.pdf"), width = 8, height = 4)


### count genes
cat_count <- full_catB3 %>% count(X.Scientific.name, sort = TRUE)

##### NOT USED IN MS ######
# card

df_card_ecoli <-
  read_csv(here("data-raw/ariba_card_summary07092022.csv"))

df_card_kleb <-
  read_csv(here("data-raw/ariba-card-kleb-summary-dassim-musicha.csv"))


left_join(
  included_studies_df,
  by = c("lane" = "name"),
  df_card_kleb |>
    select((matches("cat|CAT") | 
      contains("name")) & !contains("Moraxella")) |>
    mutate(
      name = gsub("^./|/report.tsv", "", name),
      name = gsub("#", "_", name)
    ) |>
  bind_rows(
  df_card_ecoli |>
    select((matches("cat|CAT") | contains("name")) & !contains("Moraxella")) |>
    mutate(
      name = gsub("^./|/report.tsv", "", name),
      name = gsub("#", "_", name)
    )) |>
    mutate(across(matches("assembled|match"),
  ~ if_else(is.na(.x),
  "no",.x)))
) |>
  pivot_longer(-c(lane, lab_id, species, study),
    names_to = c("cluster_name", ".value"),
    names_sep = "\\."
  ) |>
  filter(!is.na(ref_seq)) |>
  group_by(study, ref_seq, assembled, species) |>
  tally() |>
  mutate(ref_seq = sapply(strsplit(ref_seq, split = "\\."),
                          function(x) x[1])) |>
  ggplot(aes(assembled, n, fill = species)) +
  geom_col() +
  facet_grid(study ~ ref_seq, scales = "free_y") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "ARIBA assembly flag for CAT genes using CARD") 


ggsave(here("plots/ariba-card-assembly.pdf"), width = 8, height = 4)


