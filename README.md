# My-YouTube-Usage
[video-netflix-online-media-player-youtube-1453909-pxhere com](https://github.com/Nero103/My-YouTube-Usage/assets/92405860/7937d2f6-1649-4db1-bdbf-7ad0a81a22dc)
Photo by Mohamed Hassan from PxHere

This is an end-to-end personal project. I was curious about my YouTube engagement and thought it would be fun to explore the usage and recommend ways to optimize my device's data usage and my viewing schedule.

# Business question
YouTube is a popular video-sharing platform. So, my question was how often do I use the app? Am I active at certain times when using the app? Are there any patterns or trends in my usage?

# Goal
I want to keep my YouTube usage down to around 3 hours on average per month. The reason why 3 hours is good is because it keeps my device data usage at a reasonable level, which would prevent it from slowing down and keep its high speed for that month.

# Data Analysis

## Obtain data
I collected the data from Google by requesting my usage, which came in a .zip file. After the file was extracted, I explored the file contents, I saw the data was a .json file. I loaded the JSON file into Jupyter Notebook to parse the data and load it into a Pandas data frame. I subsequently explored the data frame to understand the data, gathering descriptive statistics and the shape of the data.

## Data Cleaning
I formatted the variables (columns) and cleaned the data using descriptive statistics and functions. Columns were removed that were unnecessary for the analysis as well as renamed for comprehension. Data types were also changed and values were made more consistent (i.e., changing search activity from having list values in each cell to having strings values in each cell) to make analysis easier and more consistent

## Data Exploration
Once the data was cleaned and preliminarily explored, I loaded the data frame into Microsoft SQL Server for further analysis. Some of the analyses focused on grouping the data by years, seasons, and months. After the videos were aggregated according to the group, the data was broken down by weeks, days, and hours. A window function was then used on the hours to find the difference between hours based on the following day. This query produced a look at whether the hours of usage were consistent or not. The grouped data was then made into views or loaded into Tableau.

## Data Visualization
In Tableau Desktop, the data was visualized into a primary KPI and two secondary KPIs to track progress toward my usage goal. Other visuals were made - such as bar charts, time series analysis, tables, and others - to make a dashboard. A statistical analysis was also conducted on the seasons to find a meaningful trend in usage. A strong positive correlation was found, Autumn to Summer and Spring to Winter also had strong negative correlations. These findings provided useful insights into my usage.

## Insights
Autumn and Winter, and the respective months, were found to have average hours of 4 while Spring and Summer had 3 hours on average. this finding coincides with the search activity being highest during morning and night, especially in 2023. The hours of usage were also found to have an inverse relationship when comparing Autumn to Winter. Lastly, it appears in the music video category, official music videos were preferred from the percentages on the pie chart over lyric videos.

## Recommendations
Based on the insights, Autumn and Winter exceed the target goal. This level of usage might in part be from the viewing of online video lessons when I am learning and/or upscaling my skills. Nonetheless, usage activity in Autumn and Winter should be reduced to meet my target hours for optimal data usage. Since Spring and Summer appear to remain within the 3-hour range for usage, looking further into those seasonal usages could reveal a strategy that could then be applied to Autumn and Winter for an optimized schedule. Since my activities.
