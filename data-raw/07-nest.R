library(tidyverse)

# us ----------------------------------------------------------------------

library(readxl)
library(janitor)

path_muni <- "data-raw/xlsx/indicadoressegurancapublicamunicdez19.xlsx"

# Lê e empilha (MUNI)
da_sinesp_muni <- path_muni %>%
  excel_sheets() %>%
  map_dfr(read_xlsx, path = path_muni, col_types = "text") %>%
  clean_names()

# nest

da_aninhado <- da_sinesp_muni %>%
  group_by(regiao) %>%
  nest() %>%
  ungroup()

da_aninhado$data[[2]]

# unnest

da_aninhado %>%
  unnest(data)

# nest e unnest foram refatorados recentemente.
# As funções antigas ainda estão disponíveis

# nest

da_aninhado <- da_sinesp_muni %>%
  group_by(regiao) %>%
  nest_legacy() %>%
  ungroup()

# unnest

da_aninhado %>%
  unnest_legacy(data)
