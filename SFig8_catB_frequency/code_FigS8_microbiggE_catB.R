#title: "assess proportions of catB3 and truncated variants from MicroBIGG-E
#download: 4 August 2023 from MicroBIGG-E
#authors: FEG and JL
#date: 



# use here() instead with Rstudio projects!
# see https://www.tidyverse.org/blog/2017/12/workflow-vs-script/
library(here)
library(tidyverse)
library(ggpubr)

### load data

full_catB3 <- read.csv(here("SFig8_catB_frequency/microbigge_catB3_230804.csv"))


### FigS7a  - counts of catB3 vs coverage of reference, n = 46667

FigS8a <- ggplot(full_catB3, aes(x=X..Coverage.of.reference))+
  geom_bar()+
  #scale_y_log10()+
  #facet_wrap(vars(X.Scientific.name), scales = "free_y", shrink = TRUE)+
  theme_bw()+
  theme(strip.background =element_rect(fill="#f7fcfd"))+
  theme(strip.text = element_text(face = 'italic'))+
  labs(x = "Coverage of reference (%)", y = "Counts")

FigS8a

# Code from Joe Lewis from here ---------------------------------------------------
# janitor package  to clean var names
library(janitor)

FigS8b <- full_catB3 %>%
  janitor::clean_names() %>% # tidies up your var names
  mutate(
    year = str_extract(collection_date, "^\\d{4}"),
    year = as.numeric(year)
  ) %>%
  mutate(cat_gene_category = case_when( # make a new category variable
    x_coverage_of_reference == 100 ~ "wild type",
    x_coverage_of_reference == 70 ~ "IS26 truncated mutant",
    TRUE ~ "other"
  )) %>%
  # will do year here %>%
  group_by(year) %>%
  summarise(
    n_IS26_mutant = sum(cat_gene_category == "IS26 truncated mutant"),
    n_samples = length(cat_gene_category)
  ) %>%
  # add CI for each row - need a rowwise to tell the pipe to work on row
  rowwise() %>%
  mutate(
    IS26_mutant_prop = n_IS26_mutant / n_samples,
    lci = binom.test(n_IS26_mutant, n_samples)$conf.int[[1]],
    uci = binom.test(n_IS26_mutant, n_samples)$conf.int[[2]]
  ) %>%
  # restrict to years with at least 100 samples
  filter(n_samples > 100) %>%
  # then plot
  ggplot(aes(year, IS26_mutant_prop, ymin = lci, ymax = uci)) +
  geom_line(colour = "#005824") +
  geom_ribbon(color = NA, # this makes the CI band not have a thick outer line
  alpha = 0.3) + # this makes it a bit seethrough
theme_bw() +
labs(title = "Proportion of samples with IS26 truncated catB3",
     subtitle = "Defined by 70% coverage in genome assembly")+
  xlab("Year")+
  ylab("Proportion of IS26 truncated catB3")

FigS8b

# species ------------------------------------------------------

FigS8c <- full_catB3 %>%
  janitor::clean_names() %>% # tidies up your var names
  mutate(
    year = str_extract(collection_date, "^\\d{4}"),
    year = as.numeric(year)
  ) %>%
  mutate(cat_gene_category = case_when( # make a new category variable
    x_coverage_of_reference == 100 ~ "wild type",
    x_coverage_of_reference == 70 ~ "IS26 truncated mutant",
    TRUE ~ "other"
  )) %>%
  # then do what ya like with it
  # will do year here %>%
  group_by(x_scientific_name) %>%
  summarise(
    n_IS26_mutant = sum(cat_gene_category == "IS26 truncated mutant"),
    n_samples = length(cat_gene_category)
  ) %>%
  rowwise() %>%
  mutate(
    IS26_mutant_prop = n_IS26_mutant / n_samples,
    lci = binom.test(n_IS26_mutant, n_samples)$conf.int[[1]],
    uci = binom.test(n_IS26_mutant, n_samples)$conf.int[[2]]
  ) %>%
  # restrict to vars with at least 100 samples
  filter(
    n_samples > 100,
    x_scientific_name != ""
  ) %>%
  # then plot
  ggplot(aes(fct_reorder(x_scientific_name, IS26_mutant_prop), # fct_reorder as before
             IS26_mutant_prop,
             ymin = lci, ymax = uci
  )) +
  geom_point() +
  geom_errorbar(width = 0) +
  theme_bw() +
  labs(title = "Bacterial species")+
  xlab("")+
  ylab("Proportion of truncated catB3")+
  theme(axis.text.y = element_text(face = "italic"))+
  coord_flip()

FigS8c


# isolate source (host) -------------------------------

FigS8d <-   
  full_catB3 %>%
  janitor::clean_names() %>% # tidies up your var names
  mutate(
    year = str_extract(collection_date, "^\\d{4}"),
    year = as.numeric(year)
  ) %>%
  mutate(cat_gene_category = case_when( # make a new category variable
    x_coverage_of_reference == 100 ~ "wild type",
    x_coverage_of_reference == 70 ~ "IS26 truncated mutant",
    TRUE ~ "other"
  )) %>%
  mutate(host = case_when(
    host == "dog" | host == "Canis lupus familiaris"  ~ "dog",
    host == "Felis catus" ~ "cat",
    host == "Bos taurus" ~ "cattle",
    host == "patient" ~ "human",
    host == "Gallus gallus" ~ "red junglefowl", 
    grepl("sapiens", host) ~ "human",
    grepl("Chroicocephalus", host) ~"gull",
    TRUE ~ host
  )) %>%
  filter(host 
         != "not available" 
         & host != "not collected"
         )%>%
  # then do what ya like with it
  group_by(host) %>%
  summarise(
    n_IS26_mutant = sum(cat_gene_category == "IS26 truncated mutant"),
    n_samples = length(cat_gene_category)
  ) %>%
  rowwise() %>%
  mutate(
    IS26_mutant_prop = n_IS26_mutant / n_samples,
    lci = binom.test(n_IS26_mutant, n_samples)$conf.int[[1]],
    uci = binom.test(n_IS26_mutant, n_samples)$conf.int[[2]]
  ) %>%
  # restrict to vars with at least 100 samples
  filter(
    n_samples >= 50,
    host != ""
  ) %>%
  # then plot
  ggplot(aes(fct_reorder(host, IS26_mutant_prop), # the fct_reorder function
    # orders isolation_source by IS26_mutant prop to make the plot nice
    IS26_mutant_prop,
    ymin = lci, ymax = uci
  )) +
  geom_point() +
  geom_errorbar(width = 0) +
  theme_bw() +
  labs(title = "Host")+
  xlab("")+
  ylab("Proportion of truncated catB3")+
  coord_flip()

FigS8d



# country ------------------------------------------------------

FigS8e <- full_catB3 %>%
  janitor::clean_names() %>% # tidies up your var names
  mutate(
    year = str_extract(collection_date, "^\\d{4}"),
    year = as.numeric(year)
  ) %>%
  mutate(cat_gene_category = case_when( # make a new category variable
    x_coverage_of_reference == 100 ~ "wild type",
    x_coverage_of_reference == 70 ~ "IS26 truncated mutant",
    TRUE ~ "other"
  )) %>%
  filter(
    location 
         != "not collected"
  )%>%
  # then do what ya like with it
  # will do year here %>%
  group_by(location) %>%
  summarise(
    n_IS26_mutant = sum(cat_gene_category == "IS26 truncated mutant"),
    n_samples = length(cat_gene_category)
  ) %>%
  rowwise() %>%
  mutate(
    IS26_mutant_prop = n_IS26_mutant / n_samples,
    lci = binom.test(n_IS26_mutant, n_samples)$conf.int[[1]],
    uci = binom.test(n_IS26_mutant, n_samples)$conf.int[[2]]
  ) %>%
  # restrict to vars with at least 100 samples
  filter(
    n_samples > 100,
    location != ""
  ) %>%
  # then plot
  ggplot(aes(fct_reorder(location, IS26_mutant_prop), # fct_reorder as before
    IS26_mutant_prop,
    ymin = lci, ymax = uci
  )) +
  geom_point() +
  geom_errorbar(width = 0) +
  theme_bw() +
  labs(title = "Location")+
  xlab("")+
  ylab("Proportion of truncated catB3")+
  coord_flip()

FigS8e

############## arrange figures ################

FigS8.final <- ggarrange(FigS8a, FigS8b, FigS8c, FigS8d, FigS8e,
                        ncol = 2, nrow = 3,  labels = c( "a", "b", "c", "d", "e"),
                        heights = c(8, 8, 16))

                        
FigS8.final

#save figures: 
ggsave(here("FigS8.final.pdf"), plot = FigS8.final, scale =1, width = 30, height = 42, units = "cm", dpi = 300)

ggsave(here("FigS8.final.png"), plot = FigS8.final, device = "png", scale =1, width = 30, height = 42, units = "cm", dpi = 300)

ggsave(here("FigS8.final.tiff"), plot = FigS8.final, device = "tiff", scale =1, width = 30, height = 42, units = "cm", dpi = 300)


