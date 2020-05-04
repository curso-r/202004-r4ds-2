# us ----------------------------------------------------------------------

library(tidyverse)
library(RPostgres)

# para adicionar isso, usamos usethis::edit_r_environ()!
senha_bd <- Sys.getenv("SENHA_BD")

# Conexão com o banco de dados
con <- dbConnect(Postgres(),
                 dbname = "sinesp",
                 host = "35.223.53.194",
                 port = 5432,
                 user = "admin",
                 password = senha_bd)

da_sinesp_bd <- tbl(con, "tab_sinesp")

# Trabalhe como se a base estivesse na sua máquina

da_resultado_remoto <- da_sinesp_bd %>%
  mutate(vitima = as.numeric(vitima)) %>%
  filter(sigla_uf == "AC") %>%
  group_by(municipio) %>%
  summarise(soma = sum(vitima, na.rm = TRUE))

# Observe o [??] no número de linhas!

# Por trás dos panos, ele gera uma query SQL!
da_resultado_remoto %>%
  show_query()

# use collect() para processar e obter os resultados

da_resultado_local <- da_resultado_remoto %>%
  collect()

# É possível rodar uma query SQL, se você quiser

query_db <- dbSendQuery(con, "SELECT * FROM tab_sinesp WHERE sigla_uf = 'AC'")
da_sinesp_ac <- dbFetch(query_db)

# you ---------------------------------------------------------------------

# Exercício:

# 1. Conecte com a base

# 2. Rode o mesmo script do exercício de 02-manip, armazenando
# no objeto `da_exercicio_remoto`

# 3. rode show_query(exercicio_remoto) e cole o resultado abaixo
# Dica: deixe o resultado na forma de comentário, selecionando todas
# as linhas e apertando Ctrl+Shift+C

# 4. Use o collect() para obter os resultados


