library(tidyverse)

# us ----------------------------------------------------------------------

library(readxl)
library(janitor)

path_muni <- "data-raw/xlsx/indicadoressegurancapublicamunicdez19.xlsx"

# Lê e empilha (MUNI)
da_sinesp_muni <- path_muni %>%
  excel_sheets() %>%
  map_dfr(read_xlsx, path = path, col_types = "text") %>%
  clean_names()

# Quero que minha função receba um nome sem aspas

contar_sem_aspas <- function(da, coluna) {
  da %>%
    summarise(contagem = n_distinct({{coluna}}))
}

da_sinesp_muni %>%
  contar_sem_aspas(regiao)

# Quero que minha função receba uma string

contar_com_aspas <- function(da, coluna) {
  da %>%
    summarise(contagem = n_distinct(.data[[coluna]]))
}

da_sinesp_muni %>%
  contar_com_aspas("regiao")

# Quero que minha função crie uma coluna com nome variável

contar_novo_nome <- function(da, novo_nome) {
  da %>%
    summarise({{novo_nome}} := n_distinct(regiao))
}

da_sinesp_muni %>%
  contar_novo_nome("minha_coluna_muito_louca")

da_sinesp_muni %>%
  contar_novo_nome(minha_coluna_muito_louca)













