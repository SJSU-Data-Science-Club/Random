setwd('C:\\Users\\terri\\OneDrive\\Documents\\DSC Datasets')
# Read in the data transit-stops.csv. Save it as df
df <- read.csv('transit-stops.csv', header = TRUE)

###########################################
# This first part is mostly data clean up #
###########################################

library(plyr)

# The counts function will count the frequency that each stop is visited
# We'll do this once for the start location and once for the destination.
df.counts.end <- count(df, vars = c("end.x", "end.y"))
df.counts.start <- count(df, vars = c("start.x", "start.y"))

# Order the start and end locations by most visited
start.order <- order(-df.counts.start$freq)
end.order <- order(-df.counts.end$freq)
most.visited.end <- df.counts.end[end.order,]
most.visited.start <- df.counts.start[start.order,]

# Take the top 50 visited start and end locations
df.start <- cbind(df[start.order, "mode"], most.visited.start)[1:50,]
df.end <- cbind(df[end.order, "mode"], most.visited.end)[1:50,]
colnames(df.start)[1] <- "mode"
colnames(df.end)[1] <- "mode"

##################################
# Now for the part with the maps #
##################################

# Let's make a simple map centered around San Francisco (where the data is from)
library(leaflet)

SFmap <- leaflet() %>%
	setView(lng = -122.4494, lat = 37.7649, zoom = 12.25) %>%
	addTiles()

# You can view your map by typing the name of the object in the R console
# The map will open in your default web browser

# Now let's add some markers
# For now we'll just look at top 50 bus destinations
SFmap <- leaflet() %>%
	setView(lng = -122.4494, lat = 37.7649, zoom = 12.25) %>%
	addTiles() %>%
	addMarkers(data = subset(df.end, mode == 'bus'), lng = ~end.x, lat = ~end.y)

# We can also add circles to view the frequency of arrivals. 
SFmap <- leaflet() %>%
	setView(lng = -122.4494, lat = 37.7649, zoom = 12.25) %>%
	addTiles() %>%
	addCircles(data = subset(df.end, mode == 'bus'), lng = ~end.x, lat = ~end.y,
		weight = 2, radius = ~30*sqrt(freq))

# What about adding more groups?

SFmap <- leaflet() %>%
	setView(lng = -122.4494, lat = 37.7649, zoom = 12.25) %>%
	addTiles() %>%
	# Overlay groups
		# Arrivals
	addCircles(data = subset(df.end, mode == 'bus'), lng = ~end.x, lat = ~end.y,
		weight = 2, radius = ~30*sqrt(freq), group = "Bus") %>%
	addCircles(data = subset(df.end, mode == 'subway'), lng = ~end.x, lat = ~end.y,
		weight = 1, radius = ~30*sqrt(freq), group = "Subway") %>%
	addCircles(data = subset(df.end, mode == 'tram'), lng = ~end.x, lat = ~end.y,
		weight = 1, radius = ~30*sqrt(freq), group = "Tram") %>%
	addCircles(data = subset(df.end, mode == 'cable_car'), lng = ~end.x, lat = ~end.y,
		weight = 1, radius = ~30*sqrt(freq), group = "Cable Car") %>%

	# Layers control
	addLayersControl(
    	overlayGroups = c("Bus", "Subway", "Tram", "Cable Car"),
    	options = layersControlOptions(collapsed = FALSE))

# Lastly, let's color code arrivals and departures.
SFmap <- leaflet() %>%
	setView(lng = -122.4494, lat = 37.7649, zoom = 12.25) %>%
	addTiles() %>%

	# Overlay groups
		# Arrivals
	addCircles(data = subset(df.end, mode == 'bus'), lng = ~end.x, lat = ~end.y,
		weight = 2, radius = ~30*sqrt(freq), group = "Bus") %>%
	addCircles(data = subset(df.end, mode == 'subway'), lng = ~end.x, lat = ~end.y,
		weight = 1, radius = ~30*sqrt(freq), group = "Subway") %>%
	addCircles(data = subset(df.end, mode == 'tram'), lng = ~end.x, lat = ~end.y,
		weight = 1, radius = ~30*sqrt(freq), group = "Tram") %>%
	addCircles(data = subset(df.end, mode == 'cable_car'), lng = ~end.x, lat = ~end.y,
		weight = 1, radius = ~30*sqrt(freq), group = "Cable Car") %>%
		
		# Departures
	addCircles(data = subset(df.start, mode == 'bus'), lng = ~start.x, lat = ~start.y,
		weight = 1, radius = ~30*sqrt(freq), group = "Bus", color = "red") %>%
	addCircles(data = subset(df.start, mode == 'subway'), lng = ~start.x, lat = ~start.y,
		weight = 1, radius = ~30*sqrt(freq), group = "Subway", color = "red") %>%
	addCircles(data = subset(df.start, mode == 'tram'), lng = ~start.x, lat = ~start.y,
		weight = 1, radius = ~30*sqrt(freq), group = "Tram", color = "red") %>%
	addCircles(data = subset(df.start, mode == 'cable_car'), lng = ~start.x, lat = ~start.y,
		weight = 1, radius = ~30*sqrt(freq), group = "Cable Car", color = "red") %>%

	# Layers control
	addLayersControl(
    	overlayGroups = c("Bus", "Subway", "Tram", "Cable Car"),
    	options = layersControlOptions(collapsed = FALSE))
SFmap