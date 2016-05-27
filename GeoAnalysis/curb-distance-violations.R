require(ggmap)
distance_violations = export_coords[export_coords$reason == "parked more than 18\" frm rt curb", ]
houston_map_data <- get_map("houston", zoom = 11, color="bw")
png("GeoAnalysis/curbviolations.png", width=800, height=700)
ggmap(houston_map_data, extent = "device", legend = "topleft")+
  stat_density2d(aes(x = long, y = lat, fill = ..level..), alpha=.35,
                 size = .1, bins = 15, data = distance_violations, geom = "polygon")+
  scale_fill_gradient(low = "green", high = "red")+
  ggtitle("Map of Houston Curb-distance Violations")+
  theme(legend.position = "none", plot.title = element_text(size=22))
dev.off()
