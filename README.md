
<!-- README.md is generated from README.Rmd. Please edit that file -->

## Configuração inicial

#### Passo 1: Instalar pacotes

``` r
install.packages("remotes")

# instalar pacote da Curso-R
remotes::install_github("curso-r/CursoR")

# instalar pacotes que vamos usar durante o curso
CursoR::instalar_dependencias()
```

#### Passo 2: Criar um projeto do RStudio

Faça um projeto do RStudio para usar durante todo o curso e em seguida
abra-o.

``` r
install.packages("usethis")
usethis::create_package("caminho_ate_o_projeto/nome_do_projeto")
```

#### Passo 3: Baixar o material

Certifique que você está dentro do projeto criado no passo 2 e rode o
código abaixo.

**Observação**: Assim que rodar o código abaixo, o programa vai pedir
uma escolha de opções. Escolha o número correspondente ao curso de R
para Ciência de Dados 2\!

``` r
# Baixar ou atualizar material do curso
CursoR::atualizar_material()
```

## Slides

| slide                                   | link                                                                           |
| :-------------------------------------- | :----------------------------------------------------------------------------- |
| slides/01-introducao-ao-curso.html      | <https://curso-r.github.io/main-r4ds2/slides/01-introducao-ao-curso.html>      |
| slides/021-organizacao-de-projetos.html | <https://curso-r.github.io/main-r4ds2/slides/021-organizacao-de-projetos.html> |
| slides/022-exemplo-analise-projeto.html | <https://curso-r.github.io/main-r4ds2/slides/022-exemplo-analise-projeto.html> |
| slides/023-exemplo-analise-pacote.html  | <https://curso-r.github.io/main-r4ds2/slides/023-exemplo-analise-pacote.html>  |
| slides/031-dplyr.html                   | <https://curso-r.github.io/main-r4ds2/slides/031-dplyr.html>                   |
| slides/032-tidyr.html                   | <https://curso-r.github.io/main-r4ds2/slides/032-tidyr.html>                   |
| slides/041-stringr.html                 | <https://curso-r.github.io/main-r4ds2/slides/041-stringr.html>                 |
| slides/042-lubridate.html               | <https://curso-r.github.io/main-r4ds2/slides/042-lubridate.html>               |
| slides/043-purrr.html                   | <https://curso-r.github.io/main-r4ds2/slides/043-purrr.html>                   |
| slides/05-ggplot2-plus.html             | <https://curso-r.github.io/main-r4ds2/slides/05-ggplot2-plus.html>             |
| slides/06-shiny.html                    | <https://curso-r.github.io/main-r4ds2/slides/06-shiny.html>                    |

## Scripts usados em aula

| script               | link                                                                    |
| :------------------- | :---------------------------------------------------------------------- |
| 01-import.R          | <https://curso-r.github.io/202004-r4ds-2/data-raw/01-import.R>          |
| 02-manip.R           | <https://curso-r.github.io/202004-r4ds-2/data-raw/02-manip.R>           |
| 03-bd.R              | <https://curso-r.github.io/202004-r4ds-2/data-raw/03-bd.R>              |
| 04-sep-un.R          | <https://curso-r.github.io/202004-r4ds-2/data-raw/04-sep-un.R>          |
| 05-pivot.R           | <https://curso-r.github.io/202004-r4ds-2/data-raw/05-pivot.R>           |
| 06-join.R            | <https://curso-r.github.io/202004-r4ds-2/data-raw/06-join.R>            |
| 07-nest.R            | <https://curso-r.github.io/202004-r4ds-2/data-raw/07-nest.R>            |
| 08-program.R         | <https://curso-r.github.io/202004-r4ds-2/data-raw/08-program.R>         |
| 09-strings.R         | <https://curso-r.github.io/202004-r4ds-2/data-raw/09-strings.R>         |
| 10-datas.R           | <https://curso-r.github.io/202004-r4ds-2/data-raw/10-datas.R>           |
| 11-iteracao.R        | <https://curso-r.github.io/202004-r4ds-2/data-raw/11-iteracao.R>        |
| 12-ggplot2.R         | <https://curso-r.github.io/202004-r4ds-2/data-raw/12-ggplot2.R>         |
| 13-htmlwidgets.R     | <https://curso-r.github.io/202004-r4ds-2/data-raw/13-htmlwidgets.R>     |
| 14-flexdashboard.Rmd | <https://curso-r.github.io/202004-r4ds-2/data-raw/14-flexdashboard.Rmd> |
| 15-shiny.R           | <https://curso-r.github.io/202004-r4ds-2/data-raw/15-shiny.R>           |
