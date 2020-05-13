library(tidyverse)



# US ----------------------------------------------------------------------

# Exemplo básico
mtcars %>%
  ggplot(aes(x = disp, y = mpg)) +
  geom_point()

# Mais de uma geometria
housing <- filter(txhousing, city %in% c("Dallas", "Austin"))

housing %>%
  ggplot(aes(x = date, y = sales)) +
  geom_point()

housing %>%
  ggplot(aes(x = date, y = sales, color = city)) +
  geom_point()

housing %>%
  ggplot(aes(x = date, y = sales, color = city)) +
  geom_line()

housing %>%
  ggplot(aes(x = date, y = sales, color = city)) +
  geom_point() +
  geom_line()

housing %>%
  ggplot(aes(x = date, y = sales, shape = city)) +
  geom_point()

housing %>%
  ggplot(aes(x = date, y = sales, linetype = city)) +
  geom_line()

housing %>%
  ggplot(aes(x = date, y = sales)) +
  geom_point(aes(shape = city)) +
  geom_line(aes(linetype = city))

# Gráfico bobo só para demonstrar
housing %>%
  mutate(month = as.character(month)) %>%
  ggplot(aes(x = date, y = sales)) +
  geom_point(aes(color = city)) +
  geom_line(aes(color = month))

# Níveis de um fator
levels(gss_cat$marital)
levels(gss_cat$relig)

gss_cat %>%
  count(relig)

gss_cat %>%
  mutate(relig = fct_lump(relig, 7, other_level = "OUTROS")) %>%
  count(relig)

# Reordenando níveis
relig <- gss_cat %>%
  mutate(relig = fct_lump(relig, 7)) %>%
  group_by(relig) %>%
  summarise(tvhours = mean(tvhours, na.rm = TRUE))

relig %>%
  ggplot(aes(tvhours, relig)) +
  geom_point()

relig %>%
  mutate(relig = fct_reorder(relig, tvhours)) %>%
  ggplot(aes(tvhours, relig)) +
  geom_point()

relig %>%
  mutate(relig = fct_reorder(relig, tvhours, .desc = TRUE)) %>%
  ggplot(aes(tvhours, relig)) +
  geom_point()



# YOU ---------------------------------------------------------------------

# A base que você deve utilizar
da_sinesp <- "data-raw/xlsx/indicadoressegurancapublicaufdez19.xlsx" %>%
  readxl::read_excel() %>%
  janitor::clean_names() %>%
  group_by(tipo_crime) %>%
  summarise(ocorrencias = sum(ocorrencias)) %>%
  dplyr::mutate(tipo_crime = factor(tipo_crime))

# Crie uma estética que reproduza o gráfico de horas de TV por religião, mas com
# ocorrências por tipo de crime. Ordene os tipos de crime por ordem decrescente
# de ocorrências.
da_sinesp %>%
  mutate(tipo_crime = fct_reorder(tipo_crime, ocorrencias, .desc = TRUE)) %>%
  ggplot(aes(ocorrencias, tipo_crime)) +
  geom_point()


