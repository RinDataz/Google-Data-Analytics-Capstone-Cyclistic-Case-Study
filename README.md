## Google-Data-Analytics-Capstone-Cyclistic-Case-Study

Course: [Google Data Analytics Capstone: Complete a Case Study](https://www.coursera.org/professional-certificates/google-data-analytics?)

**Background**
Cyclistic
Cyclistic, a bike-share program operating with over 5,800 bicycles and 600 docking stations, distinguishes itself by providing a variety of bike options, including reclining bikes, hand tricycles, and cargo bikes, catering to individuals with disabilities and those who prefer alternative bike designs. While the majority of users opt for traditional bikes, approximately 8% utilize assistive options. Cyclistic's user base primarily comprises leisure riders, although roughly 30% use the service for daily commutes.

Previously, Cyclistic's marketing strategy focused on raising overall awareness and appealing to broad consumer demographics, facilitated by flexible pricing plans such as single-ride passes, full-day passes, and annual memberships. Customers purchasing single-ride or full-day passes are classified as casual riders, while those opting for annual memberships are Cyclistic members.

Financial analysis reveals that annual members are significantly more profitable than casual riders. Consequently, Moreno, the marketing director, believes that driving annual membership subscriptions will drive future growth. Rather than targeting entirely new customers, Moreno aims to convert casual riders into members, leveraging their existing awareness of the Cyclistic program and their preference for the service.

Moreno has outlined a clear objective: Develop marketing strategies focused on transitioning casual riders into annual members. To achieve this goal, the marketing analyst team must gain a deeper understanding of the differences between annual members and casual riders, discern why casual riders might opt for a membership, and assess how digital media could influence marketing tactics. Moreno and her team intend to analyze historical bike trip data to uncover relevant trends.

**Scenario**
As a junior data analyst within Cyclistic's marketing team, my role involves assisting in the analysis of user behavior to inform the development of a new marketing strategy aimed at converting casual riders into annual members. Our recommendations must be supported by compelling data insights and professional data visualizations to secure executive approval.

**Ask**

**Business Task**
Devise marketing strategies to convert casual riders to members.

**Analysis Questions**
Three questions will guide the future marketing program:
1.	How do annual members and casual riders use Cyclistic bikes differently?
2.	Why would casual riders buy Cyclistic annual memberships?
3.	How can Cyclistic use digital media to influence casual riders to become members?
   
Moreno has assigned me the first question to answer: How do annual members and casual riders use Cyclistic bikes differently?

**Prepare**
**Data Source**

I will use Cyclistic’s historical trip data to analyze and identify trends from Jan 2023 to Dec 2023 which can be downloaded from [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html). The data has been made available by Motivate International Inc under this [license](https://divvybikes.com/data-license-agreement).
This is public data that can be used to explore how different customer types are using Cyclistic bikes. But note that data-privacy issues prohibit from using riders’ personally identifiable information. This means that we won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.

**Data Organization**
There are 12 files with naming convention of YYYYMM-divvy-tripdata and each file includes information for one month, such as the ride id, bike type, start time, end time, start station, end station, start location, end location, and whether the rider is a member or not. The corresponding column names are ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng and member_casual.

**Process**

**BigQuery** is used to combine the various datasets into one dataset and clean it.

**Reason:**
A worksheet can only have 1,048,576 rows in Microsoft Excel because of its inability to manage large amounts of data, MySQL Workbench couldn’t handle the data size as well. Since the Cyclistic dataset has more than 5.6 million rows, it is essential to use a platform like BigQuery that supports huge volumes of data.

**Combining the Data:**

SQL Query: [Data Combining](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/blob/main/Data%20Combining.sql)
12 csv files are uploaded as tables in the dataset 'GDA. Another table named `GDA.2023_combined_data` is created, containing 5719877 rows of data for the entire year.

**Data Exploration:**

SQL Query:[Data Exploration](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/blob/main/Data%20Exploration.sql) 

Before cleaning the data, I am familiarizing myself with the data to find the inconsistencies.

**Observations:**

1.	The table below shows the all column names and their data types. The ride_id column is our primary key.![image](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/assets/156121591/b9eba6a5-e59d-4ebf-af2e-e60f1b3a1633)

2.	The following table shows number of null values in each column. 
![image](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/assets/156121591/71c6a6f8-1362-4add-ab72-c3c7559757f5)


3.	We observed that certain columns exhibit identical numbers of missing values. This suggests a potential issue where entire rows might be missing specific data points. For example, a row might lack both the station name and ID for the starting station, or the latitude and longitude for the ending station.

As ride_id has no null values, let's use it to check for duplicates.
![image](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/assets/156121591/339634e4-9495-4979-ad7a-c1da931e1bf9)

There are no duplicate rows in the data.


4.	All ride_id values have length of 16 so no need to clean it.
![image](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/assets/156121591/073bab04-5da4-43d0-bd66-07ef7e35d28a)



5.	There are 3 unique types of bikes(rideable_type) in our data.
![image](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/assets/156121591/30a71e69-4798-4f5b-b797-b17f6ec08a18)



6.	Our data contains timestamps for the start (started_at) and end (ended_at) of each trip, both in YYYY-MM-DD hh:mm:ss UTC format. To analyze trip durations, we can create a new column named ride_length that calculates the difference between these timestamps. There are 6418 trips which has duration longer than a day and 151069 trips having less than a minute duration or having end time earlier than start time so need to remove them. Other columns day_of_week and month can also be helpful in analysis of trips at different times in a year.

![image](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/assets/156121591/8d4eebbc-2fb8-44ea-8e88-9d11ebaef5e8)


7.	Total of 875848 rows have both start_station_name and start_station_id missing which needs to be removed.
8.	Total of 929343 rows have both end_station_name and end_station_id missing which needs to be removed.
9.	Total of 6990 rows have both end_lat and end_lng missing which needs to be removed.
10.	member_casual column has 2 uniqued values as member or casual rider.

![image](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/assets/156121591/08e172b6-c757-450c-a4f7-45ab8321d30d)


11.	Columns that need to be removed are start_station_id and end_station_id as they do not add value to analysis of our current problem. 

**Data Cleaning**

SQL Query: [Data Cleaning](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/blob/main/Data%20Cleaning%20.sql)

1.	To ensure data accuracy, any rows with missing values were eliminated.

2.	Three new columns were added to enhance the analysis: ride_length to capture trip duration, day_of_week to understand usage patterns by day, and month to identify seasonal trends.

3.	Trips with unrealistic durations (less than a minute or longer than a day) were excluded as outliers. This step resulted in the removal of 1,476,445 rows.

**Analyze and Share**
**Data Visualization:** [Tableau](https://prod-uk-a.online.tableau.com/#/site/underblack187ef51dad00a/workbooks/822971?:origin=card_share_link)

Having thoroughly cleaned and organized the data, we're ready to dive into the analysis. By querying relevant datasets and visualizing them using Tableau, we can answer a key question:_ How does usage of Cyclistic bikes differ between annual members and casual riders?_

To begin, let's compare the types of bikes preferred by each user group. 

![image](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/assets/156121591/8b8aa792-a97a-4b27-aee8-d4619196f271)

 
Our data shows that members account for a significant portion of ridership, at 64.53% (2,738,451 trips). Casual riders make up the remaining 35.47% (1,504,981 trips). 

![image](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/assets/156121591/64a0c182-4e63-4ee5-9414-3b710945e686)



Each bike type chart shows percentage from the total. Most used bike is classic bike followed by the electric bike. Docked bikes are used the least and by only casual riders.
To understand usage patterns better, we'll examine how trip volume is distributed across months, days of the week, and hours of the day.  

![image](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/assets/156121591/2f3becc7-6827-44ff-b947-c735e4f7a3ad)

![image](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/assets/156121591/0ae5520f-0907-451a-9c4c-c9b2fb9362d1)

![image](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/assets/156121591/f6b7aaf2-e459-4983-bf25-9daec0172d78)


**Monthly Trends:** Interestingly, both casual and member riders exhibit similar overall trip patterns across months. Notably, usage peaks in July and dips towards the year's end, likely due to seasonal temperature changes.

**Day of the Week Variations:** Casual and member riders demonstrate distinct day-of-week usage patterns. Casual riders show a surge in weekend trips, while members experience a decrease, suggesting members are likely workers and students using the program for weekday commutes. Casual riders, on the other hand, likely utilize the program for leisure activities on weekends.

**Hourly Ridership:** Member trips exhibit two distinct peaks: early mornings (6 am - 8 am) and evenings (4 pm - 8 pm), coinciding with typical commute times. Conversely, casual rider trips show a steady increase throughout the day, peaking in the evening before declining. This further reinforces the hypothesis that members prioritize commuting, while casual riders use the program for recreational purposes.

**Overall:** The data suggests members primarily use bikes for weekday work/school commutes, while casual riders utilize them for leisure activities throughout the day, particularly on weekends. Both user groups exhibit peak activity in spring and summer.

By comparing ride durations, we can understand the distinct behaviors of casual and member riders.

![image](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/assets/156121591/dac9e10f-599c-405a-adc3-20a6a07cc626)

![image](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/assets/156121591/18dd8f6a-cd37-4583-9f9e-fef7ff38515d)

![image](https://github.com/RinDataz/Google-Data-Analytics-Capstone-Cyclistic-Case-Study/assets/156121591/d7eb8e5b-2ffb-42f0-8249-b53b57a003d2)


**Ride Duration Analysis:**

**Casual Riders:** Interestingly, casual riders take significantly longer trips compared to members, with an average journey length roughly twice that of members. This duration, however, varies throughout the year, week, and day. Casual riders embark on their longest rides during weekends, spring, and summer months, and between 10 am and 2 pm. Conversely, their commutes during weekdays (particularly between 5-8 am) tend to be much shorter.

**Members:** In contrast, members exhibit consistent ride durations regardless of season, weekday/weekend, or time of day. Their trips are typically shorter in comparison to casual riders.


**Summary:
Usage Patterns**

**Casual Riders:** Favor riding throughout the day, with peak usage on weekends during spring and summer. These rides are typically for leisure activities and tend to be twice as long as member rides but occur less frequently.


**Members:** Primarily use bikes for commuting on weekdays, with peak activity during morning and evening commutes (around 8 am and 5 pm) in spring and summer. Members take more frequent rides, but their trip durations are roughly half that of casual riders.

**Act**

Understanding casual riders is key to attracting them as members. By analyzing the differences between casual and member riders, we can develop targeted marketing strategies to convert them.
**Here are some recommendations:**

1.	Seasonal Marketing: Focus marketing campaigns in spring and summer at popular tourist and recreational locations frequented by them.
2.	Flexible Membership Options: Since casual riders are most active on weekends and during warmer months, consider offering seasonal or weekend-only memberships to cater to their preferences.
3.	Ride-Time Incentives: We observed that casual riders use their bikes for longer durations. Offering discounts for longer rides can attract casual riders and encourage existing members to extend their trips.
4.	Targeted Discounts for Busy Riders: Knowing that members are likely to be workers and students, consider special discounts encouraging them to ride more, particularly on weekends.
5.	Off-Season Strategy: To address the sales drop during colder months, it's recommended to invest in promoting alternative transportation options suitable for those weather conditions.


