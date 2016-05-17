require(ggmap)
raw_2014_to_2015 = read.csv("GeoAnalysis/Parking Citations in T2 07-01-2014 to 06-30-2015 as of 05-01-2016.csv")
raw_2015_to_2016 = read.csv("GeoAnalysis/Parking Citations in T2 07-01-2015 to 03-31-2016 as of 05-01-2016.csv")
raw_data = rbind(raw_2014_to_2015, raw_2015_to_2016)
ticket_coords = as.data.frame(cbind(raw_data$Latitude, raw_data$Longitude))
prop_missing_coords = round(100*sum(is.na(ticket_coords[,"lat"]))/length(ticket_coords[,"lat"]))
paste("Approximately ",prop_missing_coords,"% of coordinates are missing in this dataset.", sep="")
ticket_coords = ticket_coords[complete.cases(ticket_coords),]
colnames(ticket_coords) = c("lat", "long")
houston_map_data <- get_map("houston", zoom = 12, color="bw")
png("GeoAnalysis/ticket_density.png", width=800, height=700)
ggmap(houston_map_data, extent = "device", legend = "topleft")+
  stat_density2d(aes(x = long, y = lat, fill = ..level..), alpha=.35,
                 size = .1, bins = 15, data = ticket_coords, geom = "polygon")+
  scale_fill_gradient(low = "green", high = "red")+
  ggtitle("Where are you most likely to get a ticket in Houston?")+
  theme(legend.position = "none", plot.title = element_text(size=22))
dev.off()