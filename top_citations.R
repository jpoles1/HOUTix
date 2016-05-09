source("initial.R")
top_citations = queryDB("SELECT VIC_LEGAL_DESCRIPTION as citation, COUNT(*) as ct FROM ticket_data GROUP BY citation ORDER BY CT DESC LIMIT 30")
ggplot(top_citations, aes(x=reorder(citation, ct), y=ct))+
  geom_bar(stat="identity")+coord_flip()+
  xlab("Reason for Citation")+ylab("\nNumber of Tickets\n")+
  ggtitle("Top 30 Reasons for Citation")