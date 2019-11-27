<span style="color:blue">**How to retrieve and process realtime catch data for Pacific Hake from FOS**</span>

The reason this method uses the FOS Internet reports and not the GFFOS database is because at certain times,
we need the most current catch data to show in public meetings. GFFOS is not a realtime
database and the most recent catch is not included in it. It is only re-populated once a week or so.
This method gets the realtime data from FOS directly.

 - Open Internet Explorer (no other browsers work for this) and go to http://paccfprodin/fos2/index.cfm (or http://10.112.10.29/fos2/index.cfm)
   - Enter Username and Password, and login
   - Enter the current year and click **Set Default Preferences** and **Set Session Preferences**
   - Click red "Reports" button

 - **For the DMP landings:**
   - Click "Landings by species by date (DMP)"
   - Type or select "Pacific Hake" from the species dropdown box.
   - Set Start date to April 1, 2007 (Before that catch data were in PacHarvTrawl not FOS).
   - Set End date to today's date.
   - Leave everything else blank.
   - Click "Run Report".
   - It will take a couple of minutes. There is no visible sign that it is doing anything.
   Once finished, the screen will change, giving you a link to open the new file.
   Click the link then Save As.. **data/LandingsSpeciesDateDMP.csv**.

 - **For the LOGS landings:**
   - On the FOS website, also run the 'Catch by species by Date (LOGS)' report.
   - Note you can only do 1 year at a time due to size restrictions on output data.
   - Leave all areas checked.
   - Select January 1 for the year to the end date for that year, usually December 31. The end date will be earlier for the current year, just before the JTC meeting.
   - Make sure 'Fishing/ASOP logs' is checked, not 'Video Catch logs'
   - It will take a couple of minutes. There is no visible sign that it is doing anything.
   Click the link then Save As.. **data/LogCatchReportXXXX.csv** where **XXXX** is the year.

 - Open R and source the R script:
   ```source("generate-data.R")```

 - 
 - Open R and source the process-catch-data.r script. This will generate a file called **'Landings_Fleet_Year_Month.csv'**
   which has the landings and discard totals and counts for each fishery type by year and month from 2007-present.

 - To make the plots for cumulative catch and histograms of number of tows by area,
   go to ../CumulativeCatch and read the Readme.md file.
