source("initial.R")
png("top_citations.png", width=1000, height=800)
top_citations = queryDB("SELECT VIC_LEGAL_DESCRIPTION as citation, COUNT(*) as ct FROM ticket_data GROUP BY citation ORDER BY CT DESC LIMIT 20")
ggplot(top_citations, aes(x=reorder(citation, ct), y=ct))+
  geom_bar(stat="identity")+coord_flip()+
  xlab("Reason for Citation")+ylab("\nNumber of Tickets\n")+
  ggtitle("Top 20 Infractions")+
  theme(axis.text=element_text(size=16), axis.title=element_text(size=18), plot.title=element_text(size=22))
dev.off()