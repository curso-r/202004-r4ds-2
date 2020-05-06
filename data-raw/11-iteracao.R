library(tidyverse)
library(readxl)
library(stringr)



# US ----------------------------------------------------------------------

# Iteração simples
soma_dez <- function(x) x + 10
map(vec, soma_dez)
map_dbl(vec, soma_dez)

# Todas as variações
map()     # Padrão (lista)
map_chr() # String
map_dbl() # Numérico
map_dfc() # Colunas de tabela
map_dfr() # Linhas de tabela
map_int() # Inteiros
map_lgl() # TRUE e FALSE
map_raw() # Binário

# Com mais argumentos
soma_n <- function(x, n) x + n
map(vec, soma_n, n = 3)
map_dbl(vec, soma_n, n = 3)

# Fórmulas
map(vec, ~3+.x)
map_dbl(vec, ~3+.x)
map_dbl(vec, ~runif(1, .x, .x+1))

# Mais de uma entrada
strings <- c("oiii", "como vai", "tchau")
padroes <- c("i+",   "(.o){2}",  "[au]+$")
map2_chr(strings, padroes, str_extract)



# YOU ---------------------------------------------------------------------

# A lista de bases que você deve utilizar
da_sinesp <- "data-raw/xlsx/indicadoressegurancapublicaufdez19.xlsx" %>%
  read_excel() %>%
  janitor::clean_names() %>%
  group_by(ano) %>%
  group_split()

# Os nomes dos arquivos a serem utilizados
arquivos <- da_sinesp %>%
  map_chr(~first(pull(.x, ano))) %>%
  as.integer() %>%
  str_c("data-raw/xlsx/", ., ".csv")

# Salve um CSV para cada sub-tabela de da_sinesp (use readr::write_csv())
???


