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

# pivot_wider ---

# Faça uma tabela da soma de vítimas por região
# no entanto, cada região deve ser uma coluna
da_contagem_vitimas <- da_sinesp %>%
  group_by(regiao) %>%
  summarise(vitima = sum(as.numeric(vitima))) %>%
  pivot_wider(names_from = regiao, values_from = vitima)

# dificil

# Faça uma tabela da quantidade e proporção de vítimas por região
# separar colunas de quantidade e proporção, para cada região

da_prop_vitimas <- da_sinesp %>%
  filter(mes_ano == "43101") %>%
  mutate(vitima = as.numeric(vitima),
         vitima = cut(vitima, c(0, 1, 10, 200), include.lowest = TRUE)) %>%
  group_by(regiao, vitima) %>%
  summarise(n = n()) %>%
  # note que aqui ainda está agrupado por regiao
  mutate(prop = n / sum(n)) %>%
  ungroup() %>%
  mutate(prop = scales::percent(prop)) %>%
  pivot_wider(
    names_from = vitima,
    values_from = c(n, prop),
    values_fill = c(n = 0, prop = "0%")
  )

# pivot_longer ---

da_contagem_vitimas %>%
  pivot_longer(everything())

da_prop_vitimas %>%
  select(regiao, starts_with("n")) %>%
  pivot_longer(
    starts_with("n"),
    names_to = "categoria",
    values_to = "quantidade"
  )

# you ---------------------------------------------------------------------

# Exercício 01 (apague os __________)

da_resultado <- da_sinesp %>%
# 1. Filtre para a região SUL e mes_ano em c("43101", "43132", "43160")
  __________ %>%
# 2. Transforme a coluna vítima para numérico
  __________ %>%
# 3. Agrupe por sigla_uf e mes_ano
  __________ %>%
# 4. Sumarise com o máximo de vítimas, usando a função max()
  __________ %>%
# 5. Jogue os estados para as colunas com pivot_wider()
  __________

da_resultado %>%
  # 6. Volte ao resultado de (4) com pivot_longer()
  __________ %>%
  # 7. Jogue mes_ano para as colunas com pivot_wider()
  __________ %>%
  # 8. limpe os nomes com clean_names()


# EXTRA: Pesquise as diferenças entre
# - spread() e pivot_wider()
# - gather() e pivot_longer()
#
# Dica: Pesquisar no help das funções e olhar esse link (ingles):
# https://www.tidyverse.org/blog/2019/09/tidyr-1-0-0/
