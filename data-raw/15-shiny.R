# me ----------------------------------------------------------------------

library(shiny)

ui <- fluidPage(
  h1("Olá, mundo :)")
)

server <- function(input, output, session) {

}

shinyApp(ui, server)

# us ----------------------------------------------------------------------

library(tidyverse)
library(readxl)
library(janitor)
library(shiny)

path <- "data-raw/xlsx/indicadoressegurancapublicamunicdez19.xlsx"

# Lê e empilha
da_sinesp <- path %>%
  excel_sheets() %>%
  map_dfr(read_xlsx, path = path, col_types = "text") %>%
  clean_names()


ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("regiao", "Região", unique(da_sinesp$regiao))
    ),
    mainPanel(
      plotOutput("grafico")
    )
  )
)

server <- function(input, output, session) {

  output$grafico <- renderPlot({
    da_sinesp %>%
      filter(regiao %in% input$regiao) %>%
      group_by(sigla_uf) %>%
      summarise(soma = sum(as.numeric(vitima))) %>%
      ggplot(aes(x = sigla_uf, y = soma)) +
      geom_col()
  })

}

shinyApp(ui, server)


# you ---------------------------------------------------------------------

# 1. Permita que o usuário possa selecionar várias UFs
# 2. Inclua o agrupamento por região no `group_by()`
# 3. No gráfico, use facet_wrap() para dividir os resultados por região
# 4. Ordene as barras por quantidade de vítimas
