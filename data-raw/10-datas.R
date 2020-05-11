library(tidyverse)
library(readxl)
library(lubridate)



# US ----------------------------------------------------------------------

# Convertendo data-hora
dmy_hms("06/05/2020 02:25:00") # Data-hora
dmy("06/05/2020")              # Data
hms::as_hms("02:25:00")        # Hora
dmy_hm("06/05/2020 02:25")     # Sem segundo
as_date(18388)                 # Numérico
as_datetime(1349534985875)
make_date(2020, 5, 6)          # Componentes
make_datetime(2020, 5, 6, 2, 25, 0)

# Outros formatos
dmy_hm("06/05/20 2:25 PM") # AM/PM
mdy_hm("05/06/20 2:25 PM") # Americano
dmy("6 of may of 2020")    # Texto
dmy("6/may/2020")          # Texto
dmy("6 de maio de 2020", locale = "pt_BR.UTF-8")

# Componentes
second("2020-05-06 02:25:00") # Segundo
minute("2020-05-06 02:25:00") # Minuto
hour("2020-05-06 02:25:00")   # Hora
day("2020-05-06")             # Dia
month("2020-05-06")           # Mês
year("2020-05-06")            # Ano
wday("2020-05-06")            # Dia da semana
wday("2020-05-06", label = TRUE, abbr = FALSE, locale = "pt_BR.UTF-8")
month("2020-05-06", label = TRUE, abbr = FALSE, locale = "pt_BR.UTF-8") # Mês (sem abrev.)

data <- dmy("6 de maio de 2020", locale = "pt_BR.UTF-8")
day(data)
wday(data)

# Somas
today() + 2        # Dia
now() + 5          # Segundo
now() + seconds(5) # Segundo
now() + minutes(5) # Minuto
now() + hours(5)   # Hora
now() + days(5)    # Dia

# Diferenças
dif <- dmy("06/05/2020") - dmy("04/05/2020")
dif                         # Padrão
as.period(dif) / minutes(1) # Na unidade desejada

# Fuso horário
# OlsonNames()
t1 <- dmy_hms("06/05/2020 02:25:00", tz = "America/Sao_Paulo")
t2 <- dmy_hms("06/05/2020 02:25:00")
t3 <- dmy_hms("06/05/2020 02:25:00", tz = "Europe/London") # dst(t3)
now() - t1 # Correto (estou em -03)
now() - t2 # Errado

now(tzone = "America/Sao_Paulo")
now(tzone = "Europe/London")



# YOU ---------------------------------------------------------------------

# A base que você deve utilizar
da_sinesp <- "data-raw/xlsx/indicadoressegurancapublicaufdez19.xlsx" %>%
  read_excel() %>%
  janitor::clean_names()

# Crie uma coluna com a data em que começa o ano-mês da linha
mutate(da_sinesp, data = dmy(str_c("01/", mes, "/", ano), locale = "pt_BR.UTF-8"))

