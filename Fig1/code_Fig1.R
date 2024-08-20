#title: "Characteristics of isolates used in this study"
#author: "FEG"
#date: 16/11/23


##################
#### Figure 1 ####
##################


# load packages

library(tidyverse)
library(ggpubr)
library(here)

# set working directory and read in data table

CHL.all <- read.csv(here("Fig1/suppl.table1.csv"))

counts <- read.csv(here("Fig1/suppl.table1.counts.csv"))

#### Fig1A ####

fig1A_MS <- ggplot(CHL.all, aes(species))+
  theme_bw()+
  geom_bar(aes(fill=CHL))+
  scale_fill_manual(values = c("#225ea8", "#ffeda0", "#f5f5f5"), # first yellow color: #d8b365, #previous version ("#5ab4ac", "#feb24c", "#f5f5f5")
                    name = "CHL phenotype",
                    labels = c("resistant", "susceptible", "not determined")
  )+
  labs(y = "Number of isolates\n")+
  theme(axis.title.y = element_text(size=12, colour="black"),
        axis.title.x = element_blank(),
        axis.text.x  = element_text(size=12, colour="black", face="italic"),
        axis.text.y  = element_text(size=12, colour="black"),
        strip.text.x = element_text(colour="black", size=12, face="plain"),
        #legend.position = ("bottom"),
        legend.position = c(.8,.8),
        legend.title = element_text(size = 12, colour = "black"),
        legend.text = element_text(size = 12, colour = "black"),
  )+
  guides(fill=guide_legend(nrow=3, byrow=TRUE))


fig1A_MS


#### Fig1B ####

# select CHL susceptible isolates only 
chl.s <- 
  CHL.all %>% 
    filter(CHL == "S") %>%
    mutate(dummy = "nothing") %>% 
    droplevels() %>% 
    rowwise() %>%
    mutate(gene_category = case_when(
      sum(across(matches("Cat"))) > 0 & sum(across(matches("Cml|Flo"))) > 0 ~ "both",
      sum(across(matches("Cat"))) > 0  ~ "cat",
      sum(across(matches("Cml|Flo"))) > 0 ~ "other",
      TRUE ~ "no_R_gene")) %>%
    mutate_if(is.character, as.factor)

# reorder levels 

levels(chl.s$gene_category)
chl.s$gene_category <- fct_relevel(chl.s$gene_category,c("no_R_gene","both","other","cat"))

# plot
fig1B_MS <- ggplot(chl.s, aes(species))+
  theme_bw()+
  geom_bar(aes(fill=gene_category))+
  scale_fill_manual(values = c("#f0f0f0", "#2c7fb8", "#c7e9b4", "#7fcdbb"),
                    name = "CHL resistance \ngenes in \nsusceptible isolates",
                    labels= c("none", "cat + cmlA/floR", "cmlA/floR", "cat")
  )+
  labs(y = "Number of isolates\n")+
  theme(axis.title.y = element_text(size=12, colour="black"),
        axis.title.x = element_blank(),
        axis.text.x = element_text(size=12, colour="black", face = "italic"),
        axis.ticks.x = element_blank(),
        axis.text.y  = element_text(size=12, colour="black"),
        strip.text.x = element_text(colour="black", size=12, face="plain"),
        legend.position = c(.8,.7),
        legend.title = element_text(size = 12, colour = "black"),
        legend.text = element_text(size = 12, colour = "black", face = "italic"),
  )+
  guides(fill=guide_legend(nrow=4, byrow=TRUE))


fig1B_MS


####### Fig 1c #######


Fig1C_MS <- ggplot(data = counts, aes(fct_rev(fct_infreq(gene))))+
  geom_bar(aes(fill=gene))+
  theme_bw()+
  coord_flip()+
  #facet_grid("species")
  scale_fill_manual(values = c("#6baed6", "#2171b5", "#238b45", "#005824", "#fed98e", "#fe9929", "#969696"),
                    name = "")+
  labs(x = "",y = "\nNumber of genes" )+
  theme(axis.title.x = element_text(size=12, colour="black"),
        axis.text  = element_text(size=12, colour="black"),
        #axis.text.y = element_text(face = "italic"),
        legend.position = ("")
  )

Fig1C_MS

#### merge ####


Fig1_MS <- ggarrange(fig1A_MS, fig1B_MS, Fig1C_MS,
                     ncol = 2, nrow = 2, labels = c( "a", "b", "c"),
                     heights = c(5, 4, 4))

Fig1_MS


ggsave(here("Figure1.tiff"), plot = Fig1_MS, device = "tiff", scale =1, width = 25, height = 21, units = "cm", dpi = 300)

ggsave(here("Figure1.png"), plot = Fig1_MS, device = "png", scale =1, width = 25, height = 21, units = "cm", dpi = 300)

ggsave("Figure1.pdf", plot = Fig1_MS, device = "pdf", scale =1, width = 25, height = 21, units = "cm", dpi = 300)

ggsave("Figure1.svg", plot = Fig1_MS, device = "svg", scale =1, width = 25, height = 21, units = "cm")
