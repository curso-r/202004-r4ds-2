library(tidyverse)
library(readxl)
library(lubridate)

planilha <- "data-raw/xlsx/indicadoressegurancapublicamunicdez19.xlsx"

vitimas <- excel_sheets(planilha) %>%
  map_dfr(read_excel, path = planilha)

# us ----------------------------------------------------------------------

# you ---------------------------------------------------------------------

# Exercícios:
# Use a tibble `vitimas` para os exercícios abaixo.

# 1. crie uma base `vitimas_por_regiao` em que cada linha é a
# soma de vítimas por ano/mês de cada Região.
# Dica: group_by(), summarise(), sum(na.rm = TRUE)

# 2. atualize a tabela `vitimas_por_regiao` de modo que ela
# fique ordenada por Região e por `Mês/Ano`.
# Dica: arrange()

# 3. Crie duas colunas novas na tabela `vitimas_por_regiao`:
# - coluna do mês; e
# - coluna do ano.
# e depois retire a coluna original `Mês/Ano`
# Dica: mutate(), month(), year(), select().

# 4. Remova as linhas com NA no mês.
# Dica: filter(), !is.na()

# EXTRA: faça um gráfico ggplot() com mês no eixo x, ano nas cores,
# vítimas no eixo y e Região nas facets.

vitimas %>%
  group_by(Região, `Mês/Ano`) %>%
  summarise(
    Vítima = sum(Vítima, na.rm = TRUE)
  ) %>%
  arrange(Região, `Mês/Ano`) %>%
  mutate(
    mes = month(`Mês/Ano`),
    ano = factor(year(`Mês/Ano`))
  ) %>%
  select(-`Mês/Ano`) %>%
  filter(!is.na(mes)) %>%
  ggplot(aes(x = mes, y = Vítima, colour = ano)) +
  geom_point() +
  geom_point() +
  facet_wrap(~Região)
