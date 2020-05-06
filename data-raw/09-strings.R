library(tidyverse)
library(readxl)



# US ----------------------------------------------------------------------

# Strigs de exemplo
frutas <- c("banana", "TANGERINA", "maçã", "lima")
ois <- c("oi", "oii", "oiii!")

# Regex básico
str_subset(frutas, "na")  # Texto
str_subset(frutas, "NA")  # Maiúscula
str_subset(frutas, "^ma") # Início
str_subset(frutas, "ma$") # Final
str_subset(frutas, ".a")  # Qualquer

# Regex com quantidades
str_extract(ois, "i+")     # 1 ou mais
str_extract(ois, "i+!*")   # 0 ou mais
str_extract(ois, "i{1,2}") # Entre m e n

# Regex com conjuntos
str_extract(ois, "[i!]$") # Algum
str_extract(ois, "[i!]+") # Algum
str_extract(ois, "(oi)+") # Tudo

# Regex com escapados
str_replace("Bom dia.", "\\.", "!")      # Escapando
str_replace_all("Bom. Dia.", "\\.", "!") # Lembrar do _all
str_remove_all("Bom \"dia\"", "\\\"")    # Escapando escape

# Para um filter()
str_detect(frutas, "ma$")



# YOU ---------------------------------------------------------------------

# A base que você deve utilizar
da_sinesp <- "data-raw/xlsx/indicadoressegurancapublicaufdez19.xlsx" %>%
  read_excel() %>%
  janitor::clean_names()

# Filtre (mantenha na base) apenas as linhas cujo crime começa com "Roubo"
filter(da_sinesp, ???)

# Remova todos os parênteses "(...)" da coluna tipo_crime
mutate(da_sinesp, tipo_crime = ???)


