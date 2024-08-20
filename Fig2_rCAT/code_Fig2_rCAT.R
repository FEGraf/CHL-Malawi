#title: "rapid CAT assay"
#author: "FEG"
#date: 16/11/23

###################
####  Figure 2 ####
###################

# load packages

library(tidyverse)
library(here)

# read in data table

rCAT_MS <- read.csv(here("Fig2_rCAT/rCATfinal_MS.csv"))

# plot

Fig2_final <- rCAT_MS %>% ggplot (aes(x = Abs405, y = as.character(supplier_name)))+
  facet_grid(rows = "cat_genes", 
             switch = "y", 
             scales = "free_y",
             space = "free",
  )+
  geom_point(aes(colour=R.S, shape=species), size = 5)+
  scale_color_manual(values = c("#225ea8", "#ffeda0"))+
  theme_classic()+
  theme(strip.background =element_rect(fill="#f7fcfd"))+
  theme(strip.text.y.left = element_text(face = 'italic', size = 10, angle = 0))+
  xlim(-0.2,3.2)+
  geom_vline(xintercept = 0, linetype = "dotted", colour = "black")+
  xlab("∆ absorbance (405 nm)")+
  ylab("isolate")+
  theme(axis.title.x = element_text(size=12, colour="black"),
        axis.text  = element_text(size=10, colour="black"),
        axis.title.y  = element_blank(),
        legend.position = c(0.9, 0.15),
        legend.title = element_blank(),
        legend.text = element_text(size = 12, colour = "black", face = 'italic'),
        legend.background = element_blank(),
        legend.box.background = element_rect(linewidth = 2, size = 0.5, colour = "grey"),
  )

Fig2_final


ggsave(here("Figure2.pdf"), plot = Fig2_final, device = "pdf", scale =1, width = 20, height = 25, units = "cm", dpi = 300)

ggsave(here("Figure2.svg"), plot = Fig2_final, device = "svg", scale =1, width = 20, height = 25, units = "cm")
