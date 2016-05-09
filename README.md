---
output: pdf_document
---
Began by converting XLSX files from the [City of Houston Data Portal](http://data.houstontx.gov/dataset/city-of-houston-parking-citations) to CSV using the LibreOffice command-line conversion tool:
libreoffice --headless --convert-to csv $filename

###Overview of the Data
The main dataset used in this analysis consists of 550,755 citations handed out in Houston, Texas over the course of the period from 7/1/12 to 3/31/15. It was sourced from the [Houston Data Portal](http://data.houstontx.gov/dataset/city-of-houston-parking-citations) on 5/7/16. Additional datasets included in this analysis are as follows:
 - [Market Share by Make](http://www.edmunds.com/industry-center/data/market-share-by-make.html) (data useage pending approval by the Edmunds team)

Without further ado, let's take a look at some analysis of the data!

###Tickets by Model Year

The below figure depicts the number of tickets assigned to cars manufactured in various years. We show that there is a steep increase in ticketing in cars manufactured after the 1990s, followed by a sharp decrease in the year 2008 (as highlighted by the red dotted line). This may be a result of the United States financial crisis, and resultant failure/bailout of the American automotive industry.

![Tickets by Model Year](https://raw.githubusercontent.com/jpoles1/HOUTix/master/tickets_by_modelyear.png)

