library(tidyverse)

# us ----------------------------------------------------------------------

library(readxl)
library(janitor)

path_muni <- "data-raw/xlsx/indicadoressegurancapublicamunicdez19.xlsx"
path_uf <- "data-raw/xlsx/indicadoressegurancapublicaufdez19.xlsx"

# Lê e empilha (MUNI)
da_sinesp_muni <- path_muni %>%
  excel_sheets() %>%
  map_dfr(read_xlsx, path = path_muni, col_types = "text") %>%
  clean_names()

# Lê (UF)

da_sinesp_uf <- path_uf %>%
  read_xlsx("DNSP_VÍTIMAS") %>%
  clean_names()

glimpse(da_sinesp_uf)

# de_para de UF

# função nova: tribble!
da_depara_uf <- tibble::tribble(
  ~sigla_uf,              ~uf,
  "AC",                "Acre",
  "AM",            "Amazonas",
  "RR",             "Roraima",
  "AP",               "Amapá",
  "PA",                "Pará",
  "MA",            "Maranhão",
  "PI",               "Piauí",
  "CE",               "Ceará",
  "RN", "Rio Grande do Norte",
  "PB",             "Paraíba",
  "PE",          "Pernambuco",
  "AL",             "Alagoas",
  "SE",             "Sergipe",
  "BA",               "Bahia",
  "ES",      "Espírito Santo",
  "RJ",      "Rio de Janeiro",
  "SP",           "São Paulo",
  "PR",              "Paraná",
  "SC",      "Santa Catarina",
  "RS",   "Rio Grande do Sul",
  "MS",  "Mato Grosso do Sul",
  "MG",        "Minas Gerais",
  "GO",               "Goiás",
  "DF",    "Distrito Federal",
  "TO",           "Tocantins",
  "MT",         "Mato Grosso",
  "RO",            "Rondônia"
)

## OBS: não, eu não fiz essa tabela na mão
## se estiver curiosa(o) de como eu fiz,
## estude em casa o código abaixo:
#
# geobr::grid_state_correspondence_table %>%
#   distinct(name_uf, code_state) %>%
#   select(sigla_uf = code_state, uf = name_uf) %>%
#   datapasta::tribble_paste()

da_vitima_from_uf <- da_sinesp_uf %>%
  group_by(uf) %>%
  summarise(vitimas = sum(vitimas)) %>%
  inner_join(da_depara_uf, "uf")

da_vitima_from_muni <- da_sinesp_muni %>%
  mutate(vitima = as.numeric(vitima)) %>%
  filter(regiao == "NORTE") %>%
  group_by(sigla_uf) %>%
  summarise(vitima = sum(vitima)) %>%
  rename(minha_uf = sigla_uf) %>%
  inner_join(da_depara_uf, "sigla_uf")


da_sinesp_muni %>%
  mutate(vitima = as.numeric(vitima)) %>%
  filter(regiao == "NORTE") %>%
  group_by(sigla_uf) %>%
  summarise(vitima = sum(vitima)) %>%
  inner_join(da_depara_uf)

da_sinesp_muni %>%
  mutate(vitima = as.numeric(vitima)) %>%
  filter(regiao == "NORTE") %>%
  group_by(sigla_uf) %>%
  summarise(vitima = sum(vitima)) %>%
  rename(minha_uf = sigla_uf) %>%
  inner_join(da_depara_uf, c("minha_uf" = "sigla_uf"))

da_sinesp_muni %>%
  mutate(vitima = as.numeric(vitima)) %>%
  filter(regiao == "NORTE") %>%
  group_by(sigla_uf) %>%
  summarise(vitima = sum(vitima)) %>%
  rename(minha_uf = sigla_uf) %>%
  right_join(da_depara_uf, c("minha_uf" = "sigla_uf"))

# you ---------------------------------------------------------------------

## Exercício

# 1. faça o join de da_vitima_from_uf e da_vitima_from_muni

da_vitima_from_uf %>%
  inner_join(da_vitima_from_muni, c("uf", "sigla_uf"))

# 2. faça o join de da_vitima_from_uf e da_vitima_from_muni, escolhendo apenas "uf"
#    o que acontece com a coluna sigla_uf?

da_vitima_from_uf %>%
  inner_join(da_vitima_from_muni, c("uf"))


# 3. faça o join de da_vitima_from_uf e da_vitima_from_muni,
#    de modo que o resultado tenha 27 linhas

da_vitima_from_uf %>%
  left_join(da_vitima_from_muni, c("uf", "sigla_uf"))

da_vitima_from_uf %>%
  full_join(da_vitima_from_muni, c("uf", "sigla_uf"))

## EXTRA: Criar tabela com o número de vítimas por tipo de crime e por região
# 1. faça o join de da_sinesp_muni com o da_depara_uf
# 2. faça o distinct de região e uf, guardando numa tabela auxiliar da_aux

da_aux <- da_sinesp_muni %>%
  inner_join(da_depara_uf, "sigla_uf") %>%
  distinct(regiao, uf)

# 3. faça o join de da_sinesp_uf com da_aux, pela uf
# 4. agrupe por regiao e tipo_crime
# 5. sumarise com a soma de vítimas

da_sinesp_uf %>%
  inner_join(da_aux, "uf") %>%
  group_by(regiao, tipo_crime) %>%
  summarise(soma = sum(vitimas))

