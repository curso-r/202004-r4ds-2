library(tidyverse)

# us ----------------------------------------------------------------------

library(readxl)
library(janitor)

path <- "data-raw/xlsx/indicadoressegurancapublicamunicdez19.xlsx"

# Lê e empilha
da_sinesp <- path %>%
  excel_sheets() %>%
  map_dfr(read_xlsx, path = path, col_types = "text") %>%
  clean_names()

# unite ---

da_sinesp %>%
  unite(uf_muni, sigla_uf, municipio, sep = "/")

da_sinesp %>%
  unite(uf_muni, sigla_uf, municipio, sep = "/", remove = FALSE)

# separate ---

da_sinesp %>%
  unite(uf_muni, sigla_uf, municipio, sep = "/") %>%
  separate(uf_muni, c("sigla_uf", "municipio"), sep = "/")

# o que é esse warning??
# bônus: slice

da_sinesp %>%
  slice(17312, 17343, 17374, 17405)

# hmmm, tem mais barras
da_sinesp %>%
  # spoiler da próxima aula!
  # filtra municípios que têm "/" em algum lugar
  filter(str_detect(municipio, "/")) %>%
  # bônus: tira duplicatas! .keep_all mantêm todas as colunas
  distinct(municipio, .keep_all = TRUE)

# sem warnings!
da_sinesp %>%
  unite(uf_muni, sigla_uf, municipio, sep = "/") %>%
  separate(uf_muni, c("sigla_uf", "municipio"), sep = "/", extra = "merge")

# o que aconteceu?
da_sinesp %>%
  filter(str_detect(municipio, "/")) %>%
  distinct(municipio, .keep_all = TRUE) %>%
  unite(uf_muni, sigla_uf, municipio, sep = "/") %>%
  separate(uf_muni, c("sigla_uf", "municipio"), sep = "/", extra = "merge")

# you ---------------------------------------------------------------------

# Exercício 01 (apague os __________)

da_resultado <- da_sinesp %>%
# 1. una as colunas região e vítima, com separador "_"
  __________ %>%
# 2. Separe as colunas para voltar à original.
  __________

# Exercício 02

# Refaça 1 e 2, mas no separate(), adicione o argumento convert = TRUE
# O que ocorreu com a coluna vitima?

# EXTRA:

# 1. filtre a base para região CENTRO-OESTE
# 2. crie uma coluna "uniao", unindo regiao e vítima com separador "-" (diferente de "_")
# 3. agora tente separar. Vai dar um warning! O problema, agora,
#    é que CENTRO-OESTE tem um "-" também. No entanto, se dermos
#    extra = "merge", o resultado será "CENTRO" e "OESTE-1"
#
# Desafio: como você faria para, a partir do resultado de (2),
# voltar à base original?
#
# Obs: existem 2 respostas à essa pergunta. Uma utiliza conhecimentos que você
# já tem, e outra utiliza expressões regulares, que vamos ver mais adiante.
