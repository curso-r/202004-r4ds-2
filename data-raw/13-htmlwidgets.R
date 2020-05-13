library(tidyverse)
library(plotly)
library(highcharter)
library(DT)
library(reactable)



# US ----------------------------------------------------------------------

# Demonstração plot_ly()
plot_ly(iris, x = ~Sepal.Length, y = ~Petal.Length, color = ~Species)
plot_ly(iris, x = ~Sepal.Length, y = ~Petal.Length, color = ~Species, type = "scatter", mode = "markers")

# Demonstração ggplotly()
housing <- filter(txhousing, city %in% c("Dallas", "Austin"))

pl <- housing %>%
  ggplot(aes(x = date, y = sales, color = city)) +
  geom_point() +
  geom_line()

ggplotly(pl)

# Demonstração hchart()
hchart(mpg, "scatter", hcaes(x = displ, y = hwy, group = class))

# Demonstração datatable()
datatable(iris)

datatable(iris, filter = 'top', options = list(
  pageLength = 5, autoWidth = TRUE
))

# Demonstração reactable()
reactable(iris)



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
  plot_ly(x = ~ocorrencias, y = ~tipo_crime, type = "scatter")


