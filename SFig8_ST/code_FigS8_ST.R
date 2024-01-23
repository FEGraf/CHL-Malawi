#title: Number of ST of E. coli and KpSC in the Malawi collection
#author: FEG
#date: 

# load packages
library(tidyverse)
library(ggpubr)

# read data

CHL.all <- read.csv(here("Fig1/suppl.table1.csv"))

#### subset E. coli ####

EcoST <- CHL.all %>% 
  filter(species == "E. coli") %>%
  mutate(ST = as.character(ST)) |>
  droplevels()

# plot
FigST.a <- ggplot(data = EcoST, aes(fct_rev(fct_infreq(ST))))+
  geom_bar()+
  #geom_bar(aes(fill=ST))+
  theme_bw()+
  theme(legend.position = (""),
        axis.title.x = element_text(size=12, colour="black"),
        axis.text  = element_text(size=12, colour="black"),
        plot.title = element_text(face = "italic"),
        axis.text.x = element_text(size = 7, angle = 45, hjust = 1))+
  labs(title = "E. coli", x = "ST",y = "\nCounts" )

FigST.a

#### subset KpSC ####

KpSCST <- CHL.all %>% 
  filter(species == "KpSC") %>%
  mutate(ST = as.character(ST)) |>
  droplevels()

# plot
FigST.b <- ggplot(data = KpSCST, aes(fct_rev(fct_infreq(ST))))+
  geom_bar()+
  #geom_bar(aes(fill=ST))+
  theme_bw()+
  theme(legend.position = (""),
        axis.title.x = element_text(size=12, colour="black"),
        axis.text  = element_text(size=12, colour="black"),
        plot.title = element_text(face = "italic"),
        axis.text.x = element_text(size = 7, angle = 45, hjust = 1))+
  labs(title = "KpSC", x = "ST", y = "\nCounts" )

FigST.b
# arrange figure


FigS_STbw <- ggarrange(FigST.a, FigST.b,
                     ncol = 1, nrow = 2, labels = c( "a", "b"))

FigS_STbw


ggsave(here("FigS8.pdf"), plot = FigS_STbw, device = "pdf", scale =1, width = 25, height = 15, units = "cm", dpi = 300)

