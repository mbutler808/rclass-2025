library(maps)
library(ggplot2)
library(ggmap)
# https://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html

states <- map_data("state")
dim(states)

ggplot(data = states) + 
  geom_polygon(aes(x = long, y = lat, fill = region, group = group), color = "white") + 
  coord_fixed(1.3) +
  guides(fill="none")  # do this to leave off the color legend

west_coast <- subset(states, region %in% c("california", "oregon", "washington", "hawaii"))

ggplot(data = west_coast) + 
  geom_polygon(aes(x = long, y = lat), fill = "palegreen", color = "black") 

ggplot(data = west_coast) + 
  geom_polygon(aes(x = long, y = lat, group = group), fill = "palegreen", color = "black") + 
  coord_fixed(1.3)

ca_df <- subset(states, region == "california")

head(ca_df)
counties <- map_data("county")
ca_county <- subset(counties, region == "california")

ca_base <- ggplot(data = ca_df, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = "gray")
ca_base + theme_nothing()

ca_base + theme_nothing() + 
  geom_polygon(data = ca_county, fill = NA, color = "white") +
  geom_polygon(color = "black", fill = NA)  # get the state border back on top


library(sf)
library(rnaturalearth)
library(dplyr)
library(magrittr)
library(ggplot2)
library(ggspatial)
library(grid)

# https://r-spatial.org/r/2018/10/25/ggplot2-sf.html




world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)


class(world)
print(world)
names(world)
class(world_map)

world_map <- world %>% ggplot() + 
			geom_sf()

world_map + 
	xlab("Longitude") + ylab("Latitude") +
    ggtitle("World map", subtitle = paste0("(", length(unique(world$name)), " countries)"))
    

world_map + 
	xlab("Longitude") + ylab("Latitude") +
    ggtitle("World map", subtitle = paste0("(", length(unique(world$name)), " countries)")) + 
    geom_sf(aes(fill = pop_est), show.legend="point") +
    scale_fill_viridis_c(option = "plasma", trans = "sqrt")
    
world %>% ggplot() + 
			geom_sf(color = "black", fill = "lightgreen")
			
			    
usa <- ne_states(country="United States of America", returnclass = "sf")
head(usa)

hi <- usa %>% 
		filter(name %in% "Hawaii")

ggplot(hi) + geom_sf()

ggplot(data=usa) + 
	geom_sf()
	
plants_sf <- read_sf("Threatened-Endangered_Plants/Threatened-Endangered_Plants.shp")

print(plants_sf)
st_geometry(plants_sf)
old_sf <- read_sf("USGS_Quads_(Old_Hawaiian_Datum)/USGS_Quads_(Old_Hawaiian_Datum).shp")

print(old_sf)
plot(old_sf)

## NG map

ng_sf <- ne_countries(country = 
						c(
						  "Papua New Guinea", 
						  "Indonesia", 
						  "Philippines"
						), 
						scale=50, 
						returnclass="sf")
print(ng_sf)
nrow(ng_sf)
plot(ng_sf$geometry)

ngp <- ggplot(ng_sf) +
	geom_sf(color = "grey80", fill = "#f2f2f2", linewidth = 0.25) +
	coord_sf(xlim = c(120, 154), ylim = c(-12, 10)) +
  theme( axis.title = element_blank(),
         panel.background = element_rect(fill = "lightblue", colour = NA)
       )

# Add points to map - first get data

d <- read.csv("https://raw.githubusercontent.com/mbutler808/rclass-2025/refs/heads/main/posts/2025-05-01-spatial/metadata.csv")

odat <- d %>% filter(genus=="Oreophryne")
adat <- d %>% filter(genus=="Auparoparo"|genus=="Aphantophryne")

# convert to sf
osf <- st_as_sf(odat, coords=c("longitude", "latitude"))
asf <- st_as_sf(adat, coords=c("longitude", "latitude"))

ngpdat <- ngp +
  geom_point(data=adat, 
  	aes(x=longitude, y=latitude), 
  	colour="red", 
    pch="+", 
    size=8, 
    alpha=.75) +
  geom_point(data=odat, 
    aes(x=longitude, y=latitude), 
    colour="grey50", 
    fill="blue", 
    pch=24, 
    size=2, 
    alpha=.75) 

# Want to make a zoomed-in inset - identify coordinates
ngpdat +
  geom_hline(yintercept = -8.75, lty = 2, colour = "red") +
  geom_hline(yintercept = -12, lty = 2, colour = "red") +
  geom_vline(xintercept = 147, lty = 2, colour = "red") +
  geom_vline(xintercept = 155, lty = 2, colour = "red") 

# Annotate plot with a rectangle using the coordinates    
ngpdat <- ngpdat +
  annotate("rect", xmin = 149, xmax = 154.5, ymin = -12, ymax = -8.75, color = "grey50", fill = NA) +
  theme_void() +
  theme(axis.title = element_blank(),
        panel.background = element_rect(fill = "lightblue", colour = NA)
        )
    
inset <-  
  ggplot(ng_sf) + 
	geom_sf(color = "grey70", fill = "#f2f2f2", linewidth = 0.25) +
	coord_sf(xlim = c(149, 154.5), ylim = c(-12, -8.75), expand=FALSE) + #expand=F prevents ggplot from expanding slightly beyond the limits
  filter(d, genus=="Auparoparo" & (latitude > -12 &
  	latitude < -8.75 &
  	longitude > 149 & 
  	longitude < 154.5) 
  	) %>% geom_point( 
  		mapping = aes(x=longitude, y=latitude), 
	  	color="red", 
	    pch="+", 
	    size=8, 
	    alpha=.75) +
  filter(d, genus=="Oreophryne" & (latitude > -12 &
  	latitude < -8.75 &
  	longitude > 149 & 
  	longitude < 154.5) 
  	) %>%geom_point(
    		mapping = aes(x=longitude, y=latitude), 
    		colour="grey50", 
	    fill="blue", 
	    pch=24, 
	    size=3, 
	    alpha=.75) +
  annotate("rect", xmin = 149, xmax = 154.5, ymin = -12, ymax = -8.75, color = "grey50", fill=NA, linewidth=1.5) +
  labs(x = NULL, y = NULL) + 
  xlim(149, 154.5) +
  ylim(-12, -8.75) +
  theme_void() +
  theme(axis.title = element_blank(),
        panel.background = element_rect(fill = "lightblue", colour = NA)) +
  guides(size = "none") 

baseplot <- ngpdat + 
	geom_sf_text(aes(label=name_en),
		size = 3,
		fontface = "bold",
		family = "serif",
		color = "grey30",
		nudge_x = c(0,0,25),
		nudge_y = c(0,0,-4)) +
	#Add scale bar to bottom left from ggspatial
  	annotation_scale(location = "bl", 
  		height = unit(.25, "cm"), 
   		pad_x = unit(0.3, "in"), 
  		pad_y = unit(0.3, "in")) +
  	#Add north arrow to bottom left from ggspatial
  	annotation_north_arrow(height = unit(1, "cm"), 
  		width = unit(1, "cm"),
  		which_north = "true", 
  		location = "bl", 
  		pad_x = unit(2, "in"), 
  		pad_y = unit(0.5, "in")) 

vp <- viewport(	x=0.75,   # from grid package
				y=0.75,
                width=unit(3, "inches"),
                height=unit(2,"inches"))
grid.show.viewport(vp)

print(baseplot)
print(inset, vp = viewport(0.75, 0.78, width = 0.4, height = 0.4))  

height=6
width=9

png(file="map.png", height=height, width=width, units="in", res=300)
      print(baseplot)
      print(inset, vp = viewport(0.75, 0.78, width = 0.4, height = 0.4))  
dev.off()


# Cool tip! 

scales::show_col(c("#9DBF9E", "#A84268", "#FCB97D", "#C0BCB5", "#4A6C6F", "#FF5E5B"))

