#Required libs
require(RSQLite)
require(ggplot2)
require(grid)
require(gridExtra)
#Setup utility functions
projectRoot = ""
queryDB = function(query, dbPath="ticket_data.sqlite"){
  dbcon = dbConnect(SQLite(), dbname=paste(projectRoot, dbPath, sep=""))
  res <- dbSendQuery(dbcon, query)
  data <- fetch(res, -1)
  dbClearResult(res)
  dbDisconnect(dbcon)
  return(data)
}
standardize = function(x){(x-min(x))/(max(x)-min(x))}
#Create appropriate views
queryDB("CREATE VIEW IF NOT EXISTS ticket_by_make AS SELECT Vehicle_Make, COUNT(*) as ct FROM ticket_data WHERE Vehicle_Make!='' GROUP BY Vehicle_Make ORDER BY ct DESC")
#Examine the most commonly ticketed automobile makes
rawdata = queryDB("SELECT * FROM ticket_by_make LIMIT 20")
a = ggplot(rawdata, aes(x=reorder(rawdata$Vehicle_Make, rawdata$ct), y=ct))+
  geom_bar(stat="identity")+coord_flip()+
  xlab("Manufacturer")+ylab("Number of Tickets\n")+
  ggtitle("Do certain makes of car receive more tickets?")
#Examine the most commonly ticketed automobile makes by market share
ticket_by_make = queryDB("SELECT * FROM ticket_by_make INNER JOIN market_share USING (Vehicle_Make)")
ticket_by_make$adjusted_tix = standardize(ticket_by_make$ct/ticket_by_make$MarketShare)
b = ggplot(ticket_by_make, aes(x=reorder(ticket_by_make$Vehicle_Make, ticket_by_make$adjusted_tix), y=adjusted_tix))+
  geom_bar(stat="identity")+coord_flip()+
  xlab("Manufacturer")+ylab("Standardized Ticket Frequency\n(# Tickets/2016 Market Share)")+
  ggtitle("Do certain makes of car receive proportionally more tickets?")
grid.arrange(a, b, ncol=2)

