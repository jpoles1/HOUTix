source("initial.R")
library(stringr)
#Examine the officers who give the most tickets (prolific police)
all_ticketers = queryDB("SELECT * from tickets_by_officer")
#Select out officer name and ID
all_ticketers$Officer_Name = sapply(all_ticketers$Citation_Officer, function(raw){trimws(str_extract(raw, "[\\w, ]+[ ]*[^\\d-]")[1])})
all_ticketers$Officer_Id = sapply(all_ticketers$Citation_Officer, function(x){str_extract(x, "\\d+")[1]})
#all_ticketers$Citation_Officer = NULL
a = ggplot(all_ticketers[1:250,], aes(x=reorder(Officer_Id, ct), y=ct))+
  geom_density(stat="identity")+
  xlab("")+ylab("# Citations\n")+
  ggtitle("Top 250 Ticketers in HOU (of 2758 total officers)")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=0))
#Test if any officers have multiple ID # entries in the DB
officer_name_counts = as.data.frame(table(all_ticketers$Officer_Name))
num_duplicates = nrow(all_ticketers)-nrow(officer_name_counts)
print(paste("Number of duplicates:", num_duplicates))
#Top ticketers
top_ticketers = all_ticketers[1:40,]
b = ggplot(top_ticketers, aes(x=reorder(Officer_Id, ct), y=ct))+
  geom_bar(stat="identity", position=position_dodge(.1))+
  xlab("\nOfficer ID")+ylab("# Citations\n")+
  ggtitle("Top 40 Ticketers")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
grid.arrange(a,b)
