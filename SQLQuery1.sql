/*Cyclistic is bike-share company launched in 2016,
the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across chicago.
This dataset is from hire in 2019
Cyclistic's business need is to figure out how to get casual riders (customers) to become annual members (Subscribers)
This dataset will be used for additional analysis in order to improve the business.
1.What are the differences in how annual members and casual riders use bicycles?
a. how clients ride their bikes on different days of the week b. how long they spend on trips
c. How customers hire based on their age (particularly casual riders).
d. Does a customer's age influence their decision?
2. Why would a non-cyclist purchase a cyclistic annual membership*/




WITH cte AS (
SELECT * FROM first_quater
UNION ALL
SELECT * FROM second_quater
UNION ALL
SELECT * FROM third_quater
UNION ALL
SELECT * FROM fourth_quater
)
--COMBIME ALL QUATERS INTO A TABLE
SELECT *
INTO Hires_2019
FROM cte

--The total number of userstype
SELECT COUNT(*)
FROM Hires_2019


--The total number of users type(customers)
SELECT COUNT(*)
FROM Hires_2019
WHERE usertype='customer'

--The total number of users type(subscribers)
SELECT COUNT(*)
FROM Hires_2019
WHERE usertype='subscriber'

--Assessing hires in weekdays to know how why bikes are hired based on the customer categories
--Days of the week compared to usertype (customer)
SELECT day_of_week
	,COUNT(day_of_week) AS count
	,usertype
FROM Hires_2019
WHERE usertype='customer'
GROUP BY day_of_week
	,usertype
ORDER BY 1 DESC

--Days of the week compared to usertype (subscriber)
SELECT day_of_week
	,COUNT(day_of_week) AS count
	,cte.usertype
FROM Hires_2019
WHERE usertype='subscriber'
GROUP BY day_of_week
	,usertype
ORDER BY 2 DESC

/*And from our above Query it shows that customers have a higher hiring rate in the weekends
And subscribers around week days*/

-- Ages of customer, according to higher hiring rate
SELECT cte.birthyear
	,COUNT(*) AS count
FROM Hires_2019
WHERE usertype ='customer'
AND day_of_week IN (1,7)
GROUP BY birthyear
ORDER BY 2 DESC

--From the query above it shows customers age with hires above 1000 fall into the Millennials and Gen Z 

--Ages of subscriber, according to higher hiring rate
SELECT birthyear
	,COUNT(*) AS count
FROM Hires_2019
WHERE usertype ='subscriber'
AND day_of_week IN (2,3,4,5,6)
GROUP BY birthyear
ORDER BY 2 DESC

--From the query above subscribers are all from Boomers ll to Gen Z with hires above 1000


--To see customer born under specific years
SELECT birthyear
	,usertype
	,COUNT(*)
FROM Hires_2019
WHERE usertype='customer'
GROUP BY birthyear
	,usertype
ORDER BY 1 DESC

--To see subscriber born under specific years
SELECT birthyear
	,usertype
	,COUNT(*)
FROM Hires_2019
WHERE usertype='subscriber'
GROUP BY birthyear
	,usertype
ORDER BY 1 DESC

The most profitable month
SElECT EXTRACT('Month' FROM Start_time) as Month
	,COUNT(Trip_id) AS Trip_count
FROM Hires_2019
GROUP BY EXTRACT('Month' FROM Start_time) as Month
ORDER BY Trip_count
	
--To see stations and how many customers they have
SELECT from_station_id
	,from_station_name
	,usertype
	,COUNT(usertype)
FROM Hires_2019
WHERE usertype='customer'
GROUP BY from_station_id
	,from_station_name
	,usertype
ORDER BY 1 DESC
--NOTE from the above query,once you know how many users a station has you also see how profitable the station is

--Stations with number of customers that hires according to the days of the week
--For weekends
SELECT from_station_id
	,from_station_name
	,usertype
	,COUNT(usertype) as count_of_user
FROM Hires_2019
WHERE usertype ='customer'
AND day_of_week in(1,7)
GROUP BY from_station_id
	,from_station_name
	,usertype
ORDER BY 4 DESC
--This query shows the number of each customers who make hires from each stations on weekends

--For week_day
SELECT from_station_id
	,from_station_name
	,usertype
	,COUNT(usertype)
FROM Hires_2019
WHERE usertype ='customer'
AND day_of_week in(2,3,4,5,6)
GROUP BY from_station_id
	,from_station_name
	,usertype
ORDER BY 4 DESC
--This query shows the number of each customers who make hires from each stations on weekdays


--Bikes that are frequently used incase of maintainance 
SELECT bikeid	
	,COUNT(bikeid)
FROM Hires_2019
GROUP BY bikeid
ORDER BY 2 DESC
--The above query shows how many times a bike has been used for the cause of this year

--BestPerfroming Month
SELECT  COUNT(*) AS Count
	,EXTRACT(MONTH FROM start_time) as Month
FROM Hires_2019
GROUP BY EXTRACT(MONTH FROM start_time)
ORDER BY 2 DESC

--In case our business wants to reward our customers with higher ride_length
SELECT *
FROM Hires_2019
WHERE ride_length>(
	SELECT AVG(ride_length)
	FROM Hires_2019)
AND day_of_week IN(1,7)






/*INSIGHTS
1.We have a total of 2.99 million riders, 525,830 are customers and 2.46 million are subscribers.
2.Cyclistic records shows subscribers hiring rate is higher during the week and customers during the weekend.
3.Going further, observed our customers (casual riders) fall more under the ages of 19-36.
4.Summer months ( June, July, August, September), experience higher hire consider to other months.


RECOMMENDATION
1.Since customers(casual riders) are more on the weekend. I would recommend, Cyclistic promoting weekend activities as biking racing, exercise for members.
2.Promoting summer activities such as bike competition for members, during the summer period.
3.Discovered Gen Z and Minnellas (those born between 1975 and 2000) have more weekend hires than any other age group under the customer category. For optimum reach, the advertisement should be run on social media.
4.Stations with more customers hiring rate, I recommend should be the target.
*/
		

		 
