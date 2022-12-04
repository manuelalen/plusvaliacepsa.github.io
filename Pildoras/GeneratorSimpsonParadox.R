#REF: https://github.com/abagaini/30DayChartChallenge/tree/main/2021/day_13

# LIBRERIAS ---------------------------------------------------------------
library(ggplot2)
library(correlation)
library(patchwork)
library(png)
library(cowplot)
library(magick)
library(plotly)
#font from:https://fonts.google.com/specimen/Pacifico


# DATOS --------------------------------------------------------------------

data <- simulate_simpson(n = 250, groups = 5, r = -0.45, difference = 2,group_prefix = "Grupo_")

# GRAFICAMOS --------------------------------------------------------------------

## Primero por separado y sin anotaciones
a1 <- ggplot(data, aes(x = V1, y = V2)) +
  geom_point(fill = "#D6E69F", shape = 21, size = 2.75, alpha = 0.95, colour = "black", stroke = 1.5) +
  geom_smooth(method = "lm", color = "black", size = 2) +
  theme_void() +
  labs( x = "Variable A", y = "Variable B") +
  theme(axis.line = element_line(color = "black", size = 1.5)) +
  theme(plot.margin = unit(c(t = 2,b = 2, r = 2,l = 2), "cm"),
        axis.title.x = element_text(hjust = 0.5,size = 18, color = "black", family = "Pacifico Regular", margin = margin(t = 20)),
        axis.title.y = element_text(hjust = 0.5,size = 18, angle = 90, color = "black", family = "Pacifico Regular", margin = margin(r = 20)))

a1

ggsave(a1, file="GraficoSimpson1.png", device="png",dpi = 500, width = 50, height = 30, units = "cm")
# Gráfico con la anotación
a <- ggplot(data, aes(x = V1, y = V2)) +
  geom_point(fill = "#D6E69F", shape = 21, size = 2.75, alpha = 0.95, colour = "black", stroke = 1.5) +
  geom_smooth(method = "lm", color = "black", size = 2) +
  theme_void() +
  labs( x = "Variable A", y = "Variable B") +
  theme(axis.line = element_line(color = "black", size = 1.5)) +
  theme(plot.margin = unit(c(t = 2,b = 2, r = 2,l = 2), "cm"),
        axis.title.x = element_text(hjust = 0.5,size = 18, color = "black", family = "Pacifico Regular", margin = margin(t = 20)),
        axis.title.y = element_text(hjust = 0.5,size = 18, angle = 90, color = "black", family = "Pacifico Regular", margin = margin(r = 20))) +
  annotate(
    geom = "curve", x = 3, y = 6, xend = 8, yend = 16, size = 1.15, colour = "black",
    curvature = -.3, arrow = arrow(length = unit(2, "mm"))
  ) +  annotate(geom = "text", x = 8.1, y = 16.1, label = "¡Cuidado con no atender\n a los subgrupos!", hjust = "left", family = "Pacifico Regular", size = 5) 

a

# Gráfico con los grupos
b <- ggplot(data, aes(x = V1, y = V2)) +
  geom_point(aes(fill = Group), shape = 21, size = 2.75, alpha = 0.85, colour = "black", stroke = 1.5) +
  geom_smooth(aes(color = Group), method = "lm") +
  theme_void() +
  labs( x = "Variable A", y = "Variable B") +
  theme(axis.line = element_line(color = "black", size = 1.5)) +
  theme(plot.margin = unit(c(t = 2,b = 2, r = 2,l = 2), "cm"),
        axis.title.x = element_text(hjust = 0.5,size = 18, color = "black", family = "Pacifico Regular", margin = margin(t = 20)),
        axis.title.y = element_text(hjust = 0.5,size = 18, angle = 90, color = "black", family = "Pacifico Regular", margin = margin(r = 20))) +
  scale_colour_manual(values = c("#FED41D", "#009DDC", "#F14E28", "#00947E", "#ff499e")) +
  scale_fill_manual(values = c("#FED41D", "#009DDC", "#F14E28", "#00947E", "#ff499e")) +
  guides(fill = guide_legend(override.aes = list(size = 5)))+
  guides(fill=guide_legend(override.aes=list(fill=NA)))

b


#Guardamos nuestra leyenda
legend <- get_legend(
  # create some space to the left of the legend
  b + theme(legend.box.margin = margin(0, 0, 0, 12)))


# Hacemos una pequeña composición
c <- plot_grid(a, b + theme(legend.position = "none", plot.title = element_blank(), plot.subtitle = element_blank()), align = "v")
c <- plot_grid(c, legend, rel_widths = c(3, .4))

#Carga de imágenes
img <- readPNG("bart.png", native = T) # from https://www.pngitem.com/middle/
img2 <- readPNG("Homer.png", native = T) # from 
img3 <- readPNG("Lisa.png", native = T) # from


# añadimos títulos
patchwork <- c
d <- patchwork + plot_annotation(
  title = "Paradoja Simpson",
  caption = "Author: Manuel Alén Sánchez con la adaptación del código de @a_bagaini",
  theme = theme(plot.background = element_rect("#ffd90f"))) & 
  theme(plot.title = element_text(size = 85, face = "bold", margin = margin(b = 20, t = 30), hjust = 0.5, family = "Pacifico Regular", color = "#107DC0"),
        plot.subtitle = element_text(lineheight = 1.25, size = 15, margin = margin(b = 20, t = 20),hjust = 0.5, family = "Pacifico Regular", colour = "black"),
        plot.caption = element_text(size = 9, hjust = 0.99, margin = margin(b =10), family = "Pacifico Regular", colour = "black"))

# añadimos las imágenes
p <- ggdraw() + 
  draw_plot(d) +
  draw_image(
    img, x = 1, y = 1, hjust = 3, vjust = 1.3, halign = 0.25, valign = 0.5,
    width = 0.22
  ) + # bart
  draw_image(
    img2, x = 1, y = 1, hjust = 1, vjust = 0.95, halign = 1, valign = 1,
    width = 0.22
  )+ # homer
  draw_image(
    img3,x = 1, y = 1, hjust = 10, vjust = 0.65, halign = 0.25, valign = 0.5,
    width = 0.1
  ) # lisa


p


# save
ggsave(p, file="cParadojaSimpson.png", device="png",dpi = 500, width = 50, height = 30, units = "cm") # can adjust resolution
