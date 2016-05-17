source("initial.R")
#Examine the most commonly ticketed automobile makes
rawdata = queryDB("SELECT * FROM tickets_by_make LIMIT 20")
a = ggplot(rawdata, aes(x=reorder(rawdata$Vehicle_Make, rawdata$ct), y=ct))+
  geom_bar(stat="identity")+coord_flip()+
  xlab("Manufacturer\n")+ylab("\nNumber of Tickets\n")+
  ggtitle("Do certain makes of car receive more tickets?")+
  theme(axis.text=element_text(size=16), axis.title=element_text(size=18), plot.title=element_text(size=22))
#Examine the most commonly ticketed automobile makes by market share
ticket_by_make = queryDB("SELECT * FROM tickets_by_make INNER JOIN market_share USING (Vehicle_Make) LIMIT 20")
ticket_by_make$adjusted_tix = standardize(ticket_by_make$ct/ticket_by_make$MarketShare)
b = ggplot(ticket_by_make, aes(x=reorder(Vehicle_Make, adjusted_tix), y=adjusted_tix))+
  geom_bar(stat="identity")+coord_flip()+
  xlab("Manufacturer\n")+ylab("\nStandardized Ticket Frequency\n(# Tickets/2016 Market Share)")+
  ggtitle("Do certain makes of car receive proportionally more tickets?")+
  theme(axis.text=element_text(size=16), axis.title=element_text(size=18), plot.title=element_text(size=22))
png("make_tickets.png", width=800, height=600)
a
dev.off()
png("make_rate.png", width=800, height=600)
b
dev.off()