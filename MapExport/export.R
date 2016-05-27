library(jsonlite)
library(stringr)
#Get raw data from CSV
raw_2014_to_2015 = read.csv("GeoAnalysis/Parking Citations in T2 07-01-2014 to 06-30-2015 as of 05-01-2016.csv")
raw_2015_to_2016 = read.csv("GeoAnalysis/Parking Citations in T2 07-01-2015 to 03-31-2016 as of 05-01-2016.csv")
#And combine
raw_data = rbind(raw_2014_to_2015, raw_2015_to_2016)
raw_data$Event_Date = format(as.POSIXct(raw_data$Event_Date, "", "%m/%d/%Y %H:%M:%S"), tz="America/Chicago", usetz=1)
raw_data$Event_Time = strftime(raw_data$Event_Date, format="%H:%M")
raw_data$Event_DoW = strftime(raw_data$Event_Date, format="%u")
ticket_coords = subset(raw_data, 1==1, c("VIC_LEGAL_DESCRIPTION", "Latitude", "Longitude", "Event_DoW", "Event_Time"))
colnames(ticket_coords) = c("reason", "lat", "long", "DoW", "time")
prop_missing_coords = round(100*sum(is.na(ticket_coords[,"lat"]))/length(ticket_coords[,"lat"]))
paste("Approximately ",prop_missing_coords,"% of coordinates are missing in this dataset.", sep="")
ticket_coords = ticket_coords[complete.cases(ticket_coords),]
#prep data for export
export_coords = ticket_coords
export_coords$reason = tolower(export_coords$reason)
export_coords$reason[export_coords$reason=="no parking anytimg"] = "no parking anytime";
export_coords$reason = as.factor(export_coords$reason)
level_frame = as.data.frame(t(levels(export_coords$reason)))
colnames(level_frame) = 1:ncol(level_frame)
#Export data
write(toJSON(level_frame), "MapExport/violation_index.json")
export_coords$reason = as.numeric(export_coords$reason)
write(toJSON(export_coords), "MapExport/ticket_coords.json")
