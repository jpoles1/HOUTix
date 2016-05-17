Began by converting XLSX files from the [City of Houston Data Portal](http://data.houstontx.gov/dataset/city-of-houston-parking-citations) to CSV using the LibreOffice command-line conversion tool:
libreoffice --headless --convert-to csv $filename

###Overview of the Data
The main dataset used in this analysis consists of 550,755 citations handed out in Houston, Texas over the course of the period from 7/1/12 to 3/31/15. It was sourced from the [Houston Data Portal](http://data.houstontx.gov/dataset/city-of-houston-parking-citations) on 5/7/16. Additional datasets included in this analysis are as follows:
 - [Market Share by Make](http://www.edmunds.com/industry-center/data/market-share-by-make.html)

A second round of analysis was subsequently performed using a new version of the data which included lat/long positional data for each ticket (though certain records are missing this information due to technical issues). This data was downloaded on 5/17/16, again from the [Houston Data Portal](http://data.houstontx.gov/dataset/city-of-houston-parking-citations). In this subsequent analysis, the ggmap tool was used courtesy of [D. Kahle and H. Wickham](http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf)

Without further ado, let's take a look at some analysis of the data!

###Reason for Citation (Infractions)
It behooves us to begin with an examination of what the most common reasons are for folk in Houston to receive a ticket. The following chart shows the top 20 infractions, the most common of which are parking in a tow-away zone, and parking at an expired meter.

![Top reasons for citation](https://raw.githubusercontent.com/jpoles1/HOUTix/master/top_citations.png)

###Tickets by Location
Using [ggmap](http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf), and the positional information provided in the updated dataset, we can examine the locations where tickets were most frequently assigned. The below map has the density of parking tickets overlaid, with green representing few tickets, and red indicating a large number of tickets were assigned in the area. This analysis indicates that there are several ticketing hotspots in Houston including the Downtown, Montrose, and Rice Village areas.

![Ticket map](https://raw.githubusercontent.com/jpoles1/HOUTix/master/GeoAnalysis/ticket_density.png)

###Tickets by Model Year

The below figure depicts the number of tickets assigned to cars manufactured in various years. We show that there is a steep increase in ticketing in cars manufactured after the 1990s, followed by a sharp decrease in the year 2008 (as highlighted by the red dotted line). This may be a result of the United States financial crisis, and resultant failure/bailout of the American automotive industry. Newer cars are likely to be less common on the roads, and therefore receive fewer overall tickets.

![Tickets by Model Year](https://raw.githubusercontent.com/jpoles1/HOUTix/master/tickets_by_modelyear.png)

###Tickets by Automotive Make

The below charts illustrate the number of tickets and ticket rate by automotive make respectively. The top plot shows the raw number of tickets given per vehicle make, while the bottom plot attempts to normalize these values by dividing the number of tickets by the vehicle make's market share (as determined by the edmunds.com team) and transforming the values of the top 20 manufacturers to lie on a 0 to 1 scale.

![Tickets by Automotive Make](https://raw.githubusercontent.com/jpoles1/HOUTix/master/make_tickets.png)

![Ticket Rate by Automotive Make](https://raw.githubusercontent.com/jpoles1/HOUTix/master/make_rate.png)


###Top Ticketers

This plots shows the volume of tickets provided by various officers. The plot highlights the fact that only a small proportion of the officers who have registered citations in the system are responsible for the majority of the tickets.

![Top Ticketers](https://raw.githubusercontent.com/jpoles1/HOUTix/master/top_250_ticketers.png)
