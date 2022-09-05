##Loading libraries
library(RMySQL)
library(ggplot2)
library(extrafont)
library(png)
library(cowplot)
library(magick)
library(patchwork)
library(countrycode)
library(ggimage)
library(metafor)

library(tidyverse)
library(skimr)
library(ggthemes)
library(showtext)
library(plotly)
library(performance)
library(metafor)
library(esc)

##Coding..

##ETL --> Extracting data
database <- dbConnect(MySQL(), user ="manuR",host="localhost", password="manuR", dbname="plusvalia")



##ETL --> Transforming Data
cepsa_2020 <- data.frame(capital_constante <- c(dbGetQuery(database,statement = "select aprovisionamientos+amortizaciones_y_deterioros+impuestos
                                                            from plusvalia.cepsa where fecha = 2020;")),
                          Plusvalia  <- dbGetQuery(database,statement = "select produccion-capital_variable-impuestos
                                                            from plusvalia.cepsa where fecha = 2020;")-capital_constante,
                          Tasa_plusvalia <- Plusvalia/((dbGetQuery(database,statement = "select capital_variable 
                                                          from plusvalia.cepsa where fecha = 2020;"))+capital_constante))

colnames(cepsa_2020) <- c("capital_constante","Plusvalia","Tasa_plusvalia")



empresas_plusvalia <- data.frame(
  empresas <- c("Cepsa","Cooperativas","Media Nacional"),
  TasaPlusvalia <- c(18.417,9.37,27.0504),
  PlusTrabajo_Dias <- c(18850020,2546.91,1454.38)
)

colnames(empresas_plusvalia) <- c("empresas","TasaPlusvalia","Plustrabajo_Dias")
(((27.0504*7.51/60)/12)/24)/365

#Meta-análisis

analisis_cepsa<- escalc(measure='SMD', m1i= 18.417,
                            m2i=9.37,
                            sd1i=runif(1,min = 0.85, max=3.55),
                            sd2i = runif(1,min = 0.85, max=3.55),
                            n1i=365*2,
                            n2i=365*2)
#Agregadura de los datos nuevos
df_cepsa  <- data.frame()
df_cepsa$Obtencion_D<-analisis_cepsa$yi
df_cepsa$Obtencion_V<-analisis_cepsa$vi




resultado_cepsa<-rma(yi=3.37, vi=0.006651277,
                         method = "DL",
                         weighted = TRUE,
                         level = 95,
                         digits = 3)

summary.rma(resultado_cepsa)



gg<- ggplot(empresas_plusvalia, aes(x = empresas, y = TasaPlusvalia, fill =TasaPlusvalia ))+
  geom_bar(stat = "identity")+
  labs(title = "Tasa de plusvalia por empresa",
       caption = "Author: Manuel Alén Sánchez",
       fill = "TasaPlusvalia",
       x = "Empresas", y="TasaPlusvalia")+
  theme_light()+
  theme(text = element_text(family = "Tahoma"),
        panel.background = element_rect(color = "white", # Border color
                                        size = 1, fill = "#FFFFFF"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.title = element_text(face = "bold",hjust = 0.5,size = 25),
        plot.subtitle = element_text(hjust = 0.5),
        plot.title.position = "plot" ,
        panel.border = element_blank())


ggplotly(gg, tooltip = c("x","y","fill"))