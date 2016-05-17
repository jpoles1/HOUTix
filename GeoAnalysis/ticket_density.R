require(ggmap)
require(ggplot2)
source("initial.R")
raw_2014_to_2015 = read.csv("GeoAnalysis/Parking Citations in T2 07-01-2014 to 06-30-2015 as of 05-01-2016.csv")
raw_2015_to_2016 = read.csv("GeoAnalysis/Parking Citations in T2 07-01-2015 to 03-31-2016 as of 05-01-2016.csv")
raw_data = rbind(raw_2014_to_2015, raw_2015_to_2016)
ticket_coords = subset(raw_data, 1==1, c("VIC_LEGAL_DESCRIPTION", "Latitude", "Longitude"))
colnames(ticket_coords) = c("reason", "lat", "long")
prop_missing_coords = round(100*sum(is.na(ticket_coords[,"lat"]))/length(ticket_coords[,"lat"]))
paste("Approximately ",prop_missing_coords,"% of coordinates are missing in this dataset.", sep="")
ticket_coords = ticket_coords[complete.cases(ticket_coords),]
#Map raw ticket density
houston_map_data <- get_map("houston", zoom = 12, color="bw")
png("GeoAnalysis/ticket_density.png", width=800, height=700)
ggmap(houston_map_data, extent = "device", legend = "topleft")+
  stat_density2d(aes(x = long, y = lat, fill = ..level..), alpha=.35,
                 size = .1, bins = 15, data = ticket_coords, geom = "polygon")+
  scale_fill_gradient(low = "green", high = "red")+
  ggtitle("Where are you most likely to get a ticket in Houston?")+
  theme(legend.position = "none", plot.title = element_text(size=22))
dev.off()
#Map tickets by infraction.
most_common_infractions = queryDB("SELECT VIC_LEGAL_DESCRIPTION as reason, COUNT(*) as ct FROM ticket_data GROUP BY VIC_LEGAL_DESCRIPTION ORDER BY ct DESC LIMIT 6")
top_infraction_coords = subset(ticket_coords, reason %in% most_common_infractions$reason)
top_infraction_coords$reason = factor(top_infraction_coords$reason)
png("GeoAnalysis/ticket_density_by_infraction.png", width=1200, height=900)
ggmap(houston_map_data, extent = "device", legend = "topleft")+
  stat_density2d(aes(x = long, y = lat, fill = ..level..), alpha=.35,
                 size = .1, bins = 15, data = top_infraction_coords, geom = "polygon")+
  scale_fill_gradient(low = "green", high = "red")+
  facet_wrap(~reason)+
  ggtitle("Where are you most likely to get a ticket for a given infraction?")+
  theme(legend.position = "none", plot.title = element_text(size=22), strip.text= element_text(size=14))
dev.off()