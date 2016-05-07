#Required libs
require(RSQLite)
require(ggplot2)
require(grid)
require(gridExtra)
#Config
projectRoot = ""
#Quick function for querying the SQLite DB
queryDB = function(query, dbPath="ticket_data.sqlite"){
  dbcon = dbConnect(SQLite(), dbname=paste(projectRoot, dbPath, sep=""))
  res <- dbSendQuery(dbcon, query)
  data <- suppressWarnings(fetch(res, -1))
  dbClearResult(res)
  dbDisconnect(dbcon)
  return(data)
}
#Standardizes the data on a scale from 0 to 1
standardize = function(x){(x-min(x))/(max(x)-min(x))}
#Create appropriate views
queryDB("CREATE VIEW IF NOT EXISTS ticket_by_make AS SELECT Vehicle_Make, COUNT(*) as ct FROM ticket_data WHERE Vehicle_Make!='' GROUP BY Vehicle_Make ORDER BY ct DESC")