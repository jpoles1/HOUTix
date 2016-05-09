source("initial.R")
#Examine the most commonly ticketed automobile makes
rawdata = queryDB("SELECT * FROM ticket_by_make LIMIT 20")
a = ggplot(rawdata, aes(x=reorder(rawdata$Vehicle_Make, rawdata$ct), y=ct))+
  geom_bar(stat="identity")+coord_flip()+
  xlab("Manufacturer")+ylab("Number of Tickets\n")+
  ggtitle("Do certain makes of car receive more tickets?")
#Examine the most commonly ticketed automobile makes by market share
ticket_by_make = queryDB("SELECT * FROM tickets_by_make INNER JOIN market_share USING (Vehicle_Make)")
ticket_by_make$adjusted_tix = standardize(ticket_by_make$ct/ticket_by_make$MarketShare)
b = ggplot(ticket_by_make, aes(x=reorder(Vehicle_Make, adjusted_tix), y=adjusted_tix))+
  geom_bar(stat="identity")+coord_flip()+
  xlab("Manufacturer")+ylab("Standardized Ticket Frequency\n(# Tickets/2016 Market Share)")+
  ggtitle("Do certain makes of car receive proportionally more tickets?")
grid.arrange(a, b, ncol=2)
