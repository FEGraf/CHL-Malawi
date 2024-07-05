library(tidyverse)
library(here)
library(pheatmap)
library(ggpubr)
library(ggplotify)

chl_all <- read.csv(here("Fig1/suppl.table1.csv"))

pl <-
  chl_all |>
  mutate(CHL = case_when(
    CHL == "R" ~ 1,
    CHL == "S" ~ 0,
    TRUE ~ NA
  )) |>
  select(matches("CHL|Cat|Flo|Cml")) |>
  filter(!is.na(CHL)) |>
  pheatmap(show_rownames = FALSE, legend = FALSE)

pl <- ggplotify::as.ggplot(pl)
ggsave(here("SFig9.pdf"), pl, width = 5, height = 5)
