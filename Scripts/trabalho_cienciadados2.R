# Ler bibliotecas ---------------------------------------------------------
library(dplyr)
library(ggplot2)
library(ggridges)
library(geobr)
library(sf)
library(leaflet)
library(viridis)
library(ggpubr)

# Carregar dados ---------------------------------------------------------
load('Dados/indicadores_vulclim.Rdata')

# Visualização Avançada 1 ----------------------------------------------------
### Fazer um gráfico de densidade para cada UF, separando por região para visualizar 
#a distribuição do indicador de vulnerabilidade climática relacionada à estiagem hídrica (IND_VULC_ESTRE_HIDR) por região (REGIAO).
g1 <- ggplot(dados_completos, aes (x = IND_VULC_ESTRE_HIDR, y = UF, fill = REGIAO)) +
  geom_density_ridges(alpha = 0.7) +
  facet_wrap(REGIAO ~ ., scales = "free_y", space = "free_y") +
  labs(x = "Indicador de Vulnerabilidade Climática",
       y = NULL) +
  theme_minimal() +
  theme(
    strip.text.y = element_text(angle = 270, face = "bold"), 
    panel.spacing = unit(0.1, "lines"),                     
    legend.position = "none",                               
    axis.text.y = element_text(size = 10)
  )
g1  


# Visualização Avançada 2 -------------------------------------------------
# Criando o gráfico avançado com correlação estatística automática
g2 <- ggscatter(dados_completos, x = "IND_VULC_ESTRE_HIDR", y = "IND_RISCO_ARB",
          color = "REGIAO", palette = "Dark2",
          shape = "REGIAO",
          size = 1.5, alpha = 0.4,
          add = "reg.line",                                  # Adiciona linha de regressão
          add.params = list(color = "black", fill = "lightgray"),
          conf.int = TRUE,                                   # Intervalo de confiança
          cor.coef = TRUE,                                   # MOSTRA O COEFICIENTE DE CORRELAÇÃO (R)
          cor.method = "spearman",                           # Ideal para indicadores
          cor.coeff.args = list(method = "spearman", label.x = 0.05,
                                label.y= 0.9, label.sep = "\n", size = 3.5)) +
  stat_stars(aes(color = REGIAO), alpha = 0.1) +             # Cria "estrelas" conectando pontos ao centro regional
  labs(
    title = "Análise de correlação entre Vulnerabilidade ao Estresse Hídrico e \n Risco de Arboviroses por municípios brasileiros",
    y = "Indicador de Risco de Arboviroses",
    x = "Indicador de Vulnerabilidade ao Estresse Hídrico",
    color = "Região", shape = "Região"
  ) +
  theme_bw() +
  facet_wrap(~REGIAO) +
  theme (legend.position = "none")

g2

# Visualizar num gráfico interativo ---------------------------------------
### Criar um mapa interativo usando a biblioteca leaflet para visualizar 
#a distribuição do indicador de vulnerabilidade climática relacionada à estiagem hídrica (IND_VULC_ESTRE_HIDR) por município.

# Carregar os dados geográficos dos municípios
municipios <- read_municipality(code_muni = "all", year = 2020)
municipios$code_muni <- as.character(municipios$code_muni)

saveRDS(municipios, "Dados/municipios.rds")#salavr em RDS para evitar ler o shapefile toda vez no Rmarkdown
municipios <- readRDS("Dados/municipios.rds")
# Juntar os dados de vulnerabilidade climática com os dados geográficos
dados_municipios <- municipios %>%
  left_join(dados_completos, by = c("code_muni" = "CD_MUN"))
# ajustar a projeçao para o Leaflet
dados_municipios <- st_transform(dados_municipios, crs = 4326)

# Criar o mapa interativo
pal_viridis <- colorNumeric(
  palette = viridis(n = 256, option = "magma", direction = -1), 
  domain = dados_municipios$IND_VULC_ESTRE_HIDR, 
  na.color = "transparent"
)

g3 <- leaflet(dados_municipios) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(fillColor = ~pal_viridis(IND_VULC_ESTRE_HIDR),
              fillOpacity = 0.85,
              opacity = 1,
              color = "white",
              weight = 0.2,
              popup = ~paste("Município:", NM_MUNICIPIO, "<br>",
                             "Vulnerabilidade:", round(IND_VULC_ESTRE_HIDR, 3))) %>%
  addLegend(pal = pal_viridis, values = ~IND_VULC_ESTRE_HIDR, title = "Vulnerabilidade Climática <br> ao Estresse Hídrico", position = "bottomright", opacity = 0.8)
g3





