library(tidyverse)
library(readxl)
library(stringr)



# US ----------------------------------------------------------------------

# Iteração simples
vec <- 1:10
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
# exemplo <- function(x) {
#   runif(1, x, x+1)
# }
vec %>%
  map_dbl(~runif(1, .x, .x+1)) %>%
  mean()

# Mais de uma entrada
strings <- c("oiii", "como vai", "tchau")
padroes <- c("i+",   "(.o){2}",  "[au]+$")
map2_chr(strings, padroes, str_extract)
map2_chr(strings, padroes, ~str_extract(.x, .y))

# _dfr
mtcars1 <- mtcars
mtcars2 <- mtcars
mtcars3 <- mtcars
list(mtcars1, mtcars2, mtcars3) %>%
  map(rownames_to_column, "car") %>%
  map_dfr(as_tibble)

# Walk
map(vec, soma_dez)
walk(vec, soma_dez) # Transparente



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
map2(da_sinesp, arquivos, readr::write_csv)


