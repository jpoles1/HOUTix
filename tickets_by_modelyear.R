source("initial.R")
tickets_by_age = queryDB("SELECT Vehicle_Year, COUNT(*) as ct from ticket_data WHERE Vehicle_Year NOT IN ('0', '') GROUP BY Vehicle_Year")
tickets_by_age$Vehicle_Year = as.Date(tickets_by_age$Vehicle_Year, "%Y")
ggplot(tickets_by_age, aes(x=Vehicle_Year, y=ct))+
  geom_point()+geom_line(group=1)+
  geom_vline(xintercept = as.numeric(as.Date("2009", "%Y")), linetype=4, color="red")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  ggtitle("Number of Tickets by Model Year")+
  xlab("\nModel Year")+ylab("Number of Ciations\n")
