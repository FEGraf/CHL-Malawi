# title: "high resolution melting assay for cat genes"
# author: "NW and FEG"
# date: 16/11/23


########################
####  Figure S5 HRM ####
########################


# load packages

library(ggpubr)
library(scales)
library(tidyverse)
library(here)

# read in data

HRM <- read.csv(here("SFig5_HRM/HRM_final.csv"))

#

HRM <- HRM %>%
  mutate_if(is.character, as.factor)

sort(levels(HRM$Target)) # sorts levels alphabetically
HRM$Target <- fct_relevel(HRM$Target, c("CatA1", "IS5_CatA1", "CatB3", "CatB4"))
levels(HRM$Target)


a <- ggplot(filter(HRM, Target == "CatA1"), aes(x = factor(Name), y = TM, colour = Target)) +
  geom_boxplot(fill = "#6baed6", colour = "black") +
  facet_wrap(~Target) +
  theme_bw() +
  labs(y = "TM  [C°]\n") +
  scale_y_continuous(breaks = c(82.75, 83.0, 83.25), limits = c(82.75, 83.25)) +
  theme(
    axis.title.y = element_text(size = 12, colour = "black"),
    axis.text.x = element_text(size = 9, colour = "black", angle = 45, vjust = 0.5, hjust = 0.5),
    axis.text.y = element_text(size = 11, colour = "black"),
    axis.title.x = element_blank(),
    legend.position = (""),
    legend.title = element_text(size = 12, colour = "black"),
    strip.background = element_rect(fill = "#f7fcfd"),
    strip.text = element_text(colour = "black", size = 12)
  )

b <- ggplot(filter(HRM, Target == "IS5_CatA1"), aes(x = factor(Name), y = TM, colour = Target)) +
  geom_boxplot(fill = "#fec44f", colour = "black") +
  facet_wrap(~Target) +
  theme_bw() +
  labs(y = "TM  [C°]\n") +
  scale_y_continuous(breaks = c(78.75, 79.0, 79.25), limits = c(78.75, 79.25)) +
  theme(
    axis.title.y = element_text(size = 12, colour = "black"),
    axis.text.x = element_text(size = 9, colour = "black", angle = 45, vjust = 0.5, hjust = 0.5),
    axis.text.y = element_text(size = 11, colour = "black"),
    axis.title.x = element_blank(),
    legend.position = (""),
    legend.title = element_text(size = 12, colour = "black"),
    strip.background = element_rect(fill = "#f7fcfd"),
    strip.text = element_text(colour = "black", size = 12)
  )

c <- ggplot(filter(HRM, Target == "CatB3"), aes(x = factor(Name), y = TM, colour = Target)) +
  geom_boxplot(fill = "#238b45", colour = "black") +
  facet_wrap(~Target) +
  theme_bw() +
  labs(y = "TM  [C°]\n") +
  scale_y_continuous(breaks = c(84.75, 85.0, 85.25), limits = c(84.75, 85.25)) +
  theme(
    axis.title.y = element_text(size = 12, colour = "black"),
    axis.text.x = element_text(
      size = 9, colour = "black", angle = 45, vjust = 0.5, hjust = 0.5
    ),
    axis.text.y = element_text(size = 11, colour = "black"),
    axis.title.x = element_blank(),
    legend.position = (""),
    legend.title = element_text(size = 12, colour = "black"),
    strip.background = element_rect(fill = "#f7fcfd"),
    strip.text = element_text(colour = "black", size = 12)
  )

d <- ggplot(filter(HRM, Target == "CatB4"), aes(x = factor(Name), y = TM, colour = Target)) +
  geom_boxplot(fill = "#005824", colour = "black") +
  facet_wrap(~Target) +
  theme_bw() +
  labs(y = "TM  [C°]\n") +
  scale_y_continuous(breaks = c(84.25, 84.5, 84.75), limits = c(84.25, 84.75)) +
  theme(
    axis.title.y = element_text(size = 12, colour = "black"),
    axis.text.x = element_text(
      size = 9, colour = "black", angle = 45, vjust = 0.5, hjust = 0.5
    ),
    axis.text.y = element_text(size = 11, colour = "black"),
    axis.title.x = element_blank(),
    legend.position = (""),
    legend.title = element_text(size = 12, colour = "black"),
    strip.background = element_rect(fill = "#f7fcfd"),
    strip.text = element_text(colour = "black", size = 12)
  )

SFig5 <- ggarrange(a, b, c, d)

ggsave(here("SFig5.png"), plot = SFig5, dpi = 300)
