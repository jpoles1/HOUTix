#Required libs
require(RSQLite)
require(ggplot2)
require(grid)
require(gridExtra)
#Config
projectRoot = ""
#Quick function for querying the SQLite DB
queryDB = function(query, dbPath="ticket_data.sqlite"){
  #connect to database
  dbcon = dbConnect(SQLite(), dbname=paste(projectRoot, dbPath, sep=""))
  #Send query to db
  res <- dbSendQuery(dbcon, query)
  #and retreive the response if there is one (otherwise, a warning is sent, and an empty frame returned)
  data <- suppressWarnings(fetch(res, -1))
  #Clear cache
  dbClearResult(res)
  #disconnect and return dataframe
  dbDisconnect(dbcon)
  return(data)
}
#Standardizes the data on a scale from 0 to 1
standardize = function(x){(x-min(x))/(max(x)-min(x))}
#Create appropriate views
queryDB("CREATE VIEW IF NOT EXISTS tickets_by_make AS SELECT Vehicle_Make, COUNT(*) as ct FROM ticket_data WHERE Vehicle_Make!='' GROUP BY Vehicle_Make ORDER BY ct DESC")
queryDB("CREATE VIEW IF NOT EXISTS tickets_by_officer AS SELECT Citation_Officer, COUNT(*) as ct FROM ticket_data GROUP BY Citation_Officer ORDER BY ct DESC")