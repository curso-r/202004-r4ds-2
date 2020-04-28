library(tidyverse)

# us ----------------------------------------------------------------------

library(readxl)

path <- "data-raw/xlsx/indicadoressegurancapublicamunicdez19.xlsx"

da_ac <- read_excel(path)

# limpar os nomes
da_limpo <- da %>%
  janitor::clean_names()

# criar um diretório
# se não quiser usar o pacote {fs}, use dir.create()
fs::dir_create("data-raw/csv")

write_csv(da_ac, "data-raw/csv/sinesp_ac.csv")

read_csv("data-raw/csv/sinesp_ac.csv")

# o objeto cols()

colunas <- cols(
  Município = col_character(),
  `Sigla UF` = col_character(),
  Região = col_character(),
  `Mês/Ano` = col_character(),
  Vítima = col_double()
)

read_csv("data-raw/csv/sinesp_ac.csv", col_types = colunas)

# no excel é diferente!
# ler tudo como texto:
rep("text", 5)
da <- read_excel(path, col_types = rep("text", 5))

# atalho:
da <- read_excel(path, col_types = "text")

# ler outras abas:
da_ba <- read_excel(path, sheet = 5)
da_sp <- read_excel(path, sheet = "São Paulo")

# ler várias abas
# Veremos mais de purrr nas próximas aulas!
lista <- purrr::map(1:3, ~read_excel(path, .x))

dados_empilhados <- bind_rows(lista) %>%
  janitor::clean_names()

dados_empilhados %>%
  group_by(sigla_uf) %>%
  summarise(s = sum(vitima))

# you ---------------------------------------------------------------------

# Exercício:

# 1. Vá até a página http://dados.gov.br e pesquise pela base do SINESP.

# 2. Baixe a base de MUNICÍPIOS do SINESP, como vimos, salvando no local apropriado.

# 3. Leia todas as bases numa lista.
# Dica: utilize readxl::excel_sheets() e purrr::map()

# 4. Empilhe a base. Dica: utilize a função `dplyr::bind_rows()`.

# 5. [EXTRA] Salve cada aba da planilha (de cada estado) em um arquivo
# CSV diferente. Dica: primeiro crie um vetor com os caminhos desses arquivos,
# e depois use purrr::map2(lista, arquivos, write_csv)

