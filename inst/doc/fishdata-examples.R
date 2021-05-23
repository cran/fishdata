## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message=FALSE-----------------------------------------------------
library(fishdata)
library(dplyr)
library(tidyr)
library(ggplot2)

## -----------------------------------------------------------------------------
data("juveniles")
catches <- juveniles %>% 
  group_by(catch_date) %>% 
  summarise(num = n())

ggplot(catches, aes(x = catch_date, y = num)) +
  geom_col() +
  labs(y = "Number caught")

## ---- message=FALSE-----------------------------------------------------------
catches_site <- juveniles %>% 
  group_by(site, catch_date) %>% 
  summarise(num = n())

ggplot(catches_site, aes(x = catch_date, y = num)) +
  geom_col() +
  facet_wrap(~site)

## -----------------------------------------------------------------------------
data("juvenile_metrics")
juv <- juveniles %>% 
  left_join(juvenile_metrics, 'fish_code')

ggplot(juv, aes(x = age, fill = site)) +
  geom_density() +
  facet_wrap(~month)

## -----------------------------------------------------------------------------
data("juvenile_growth")

# Take random sample of fish
set.seed(123)
random_juvs <- juvenile_growth %>% 
  filter(fish_code %in% sample(unique(juvenile_growth$fish_code), 4, replace = F))

ggplot(random_juvs, aes(x = period, y = position)) +
  geom_line() +
  facet_wrap(~fish_code)

## -----------------------------------------------------------------------------
data("juvenile_metrics")
juv_mets <- select(juvenile_metrics, fish_code, growth_rate)

# Use left_join to add the growth rate data, summarise to get the average, then add some good text positions for the plot.
random_juvs_with_g_rate <- random_juvs %>%
  left_join(juv_mets, 'fish_code') %>% 
  group_by(fish_code) %>% 
  summarise(g_rate = mean(growth_rate)) %>% 
  mutate(y = 250,
         x = 45)

ggplot() +
  geom_line(data = random_juvs, aes(x = period, y = position)) +
  geom_text(data = random_juvs_with_g_rate, aes(x = x,
                                                y = y,
                                                label = paste0(round(g_rate, 2), " mm/day"))) +
  facet_wrap(~fish_code)

