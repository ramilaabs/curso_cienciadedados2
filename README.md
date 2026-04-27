# curso_cienciadedados2
Este proejto é referente ao Curso de Ciência de Dados aplicada à Epidemiologia II ministrado pelos professores Dr.Oswaldo Cruz e Dra.Laís Freitas.

O obejtivo deste trabalho avaliativo era elaborar um gráfico avançado e um gráfico interativo utilizando algum banco de dados público, interpretá-los e disponizar no github utilizando comando do git integrados ao Rstudio, e inserir tais resultados na forma de relatórios em RMarkdown.

Para o trabalho utilizei dados obtidos da Plataforma AdaptaBrasil mantida pelo Ministério de Ciência, Tecnologia e Inovações (MCTI). Nesta análise incluiu-se dois indicadores: o **Índice de Vulnerabilidade ao Estresse Hídrico** e o **Índice de Risco de Arboviroses (Dengue, Zika e Chikungunya)**. O indicador de vulnerabilidade é definido pela plataforma como *"Grau de suscetibilidade de um sistema socioecológico aos efeitos das mudanças climáticas, especificamente aquelas que afetam os recursos hídricos"*. Já o indicador de risco de arboviroses é definido como *"Risco de impacto das mudanças climáticas em sistemas socioecológicos, considerando as seguintes arboviroses: dengue, zika e chikungunya"*. Ambos os indicadores são compostos por um conjunto de demais variáveis, possui valores entre 0 e 1, são classificados em cinco categorias: Muito Baixo, Baixo, Médio, Alto e Muito alto. O conjunto de dados é composto por 5570 municípios brasileiros, e os indicadores estão disponíveis para o ano de 2020.  
Mais informações sobre os indicadores podem ser encontradas através do link: https://adaptabrasil.mcti.gov.br/sobre/lista-de-indicadores. 

Utilizei ainda dados geográficos dos municípios brasileiro para elaboração do mapa interativo, obtidos com pacote geobr.

A estrtura do projeto é divido em pastas que facilitam a localização de cada parte deste projeto.
