#title: Number of ST of E. coli and KpSC in the Malawi collection
#author: FEG
#date: 

# load packages
library(tidyverse)
library(ggpubr)

# read data

CHL.all <- read.csv("~/data/suppl.table1.csv")

#### subset E. coli ####

EcoST <- CHL.all %>% 
  filter(species == "E. coli") %>%
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

