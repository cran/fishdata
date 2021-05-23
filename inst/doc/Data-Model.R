## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- setup, echo=FALSE, message=FALSE----------------------------------------
library(fishdata)
library(dm)
library(DiagrammeR)
data("adult_growth")
data("adult_metrics")
data("adults")
data("juvenile_growth")
data("juvenile_metrics")
data("juveniles")

## ---- echo=FALSE, message=FALSE-----------------------------------------------
fish_base_dm <- dm(adults,
              juveniles)
dm_draw(fish_base_dm, view_type = "all")

## -----------------------------------------------------------------------------
fish_dm <- dm(adult_metrics,
              adults,
              juvenile_metrics,
              juveniles)

fish_dm_pk <-
  fish_dm %>%
  dm_add_pk(table = adults, columns = fish_code) %>%
  dm_add_pk(juveniles, fish_code)

fish_dm_all_keys <-
  fish_dm_pk %>%
  dm_add_fk(adult_metrics, fish_code, adults) %>%
  dm_add_fk(juvenile_metrics, fish_code, juveniles)

dm_draw(fish_dm_all_keys, view_type = "all")

## ---- echo=FALSE, message=FALSE-----------------------------------------------

fish_dm <- dm(adult_growth,
              adult_metrics,
              adults,
              juvenile_growth,
              juvenile_metrics,
              juveniles)

fish_dm_pk <-
  fish_dm %>%
  dm_add_pk(table = adults, columns = fish_code) %>%
  dm_add_pk(juveniles, fish_code)

fish_dm_all_keys <-
  fish_dm_pk %>%
  dm_add_fk(table = adult_growth, columns = fish_code, ref_table = adults) %>%
  dm_add_fk(adult_metrics, fish_code, adults) %>%
  dm_add_fk(juvenile_growth, fish_code, juveniles) %>%
  dm_add_fk(juvenile_metrics, fish_code, juveniles)

dm_draw(fish_dm_all_keys, view_type = "all")


