/*Cyclistic is bike-share company launched in 2016,
the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across chicago.
This dataset is from hire in 2019
Cyclistic's business need is to figure out how to get casual riders (clients) to become annual members (Subscribers)
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
--Assessing hires in weekdays to know how why bikes are hired based on the customer categories
--Days of the week compared to usertype (customer)
/*SELECT cte.day_of_week
	,COUNT(day_of_week) AS count
	,cte.usertype
FROM cte
WHERE cte.usertype='customer'
GROUP BY day_of_week
	,usertype
ORDER BY 1 DESC*/

--Days of the week compared to usertype (subscriber)
/*SELECT cte.day_of_week
	,COUNT(day_of_week) AS count
	,cte.usertype
FROM cte
WHERE cte.usertype='subscriber'
GROUP BY day_of_week
	,usertype
ORDER BY 2 DESC*/

/*And from our above Query it shows that customers have a higher hiring rate in the weekends
And subscribers around week days*/

-- Ages of customer, according to higher hiring rate
/*SELECT cte.birthyear
	,COUNT(*) AS count
FROM cte
WHERE cte.usertype ='customer'
AND day_of_week IN (1,7)
GROUP BY cte.birthyear
ORDER BY 2 DESC*/

--From the query above it shows customers age with hires above 1000 fall into the Millennials and Gen Z 

--Ages of subscriber, according to higher hiring rate
/*SELECT cte.birthyear
	,COUNT(*) AS count
FROM cte
WHERE cte.usertype ='subscriber'
AND day_of_week IN (2,3,4,5,6)
GROUP BY cte.birthyear
ORDER BY 2 DESC*/

--From the query above subscribers are all from Boomers ll to Gen Z with hires above 1000


--The total number of users type(customer)
/*SELECT COUNT(*)
FROM cte
WHERE usertype='customer'*/

--The total number of users type(subscriber)
/*SELECT COUNT(*)
FROM cte
WHERE usertype='subscriber'*/

--To see customer born under specific years
/*SELECT cte.birthyear
	,cte.usertype
	,COUNT(*)
FROM cte
WHERE usertype='customer'
GROUP BY cte.birthyear
	,cte.usertype
ORDER BY 1 DESC*/

--To see subscriber born under specific years
/*SELECT cte.birthyear
	,cte.usertype
	,COUNT(*)
FROM cte
WHERE usertype='subscriber'
GROUP BY cte.birthyear
	,cte.usertype
ORDER BY 1 DESC*/


--To see stations and how many customers they have
/*SELECT cte.from_station_id
	,cte.from_station_name
	,cte.usertype
	,COUNT(cte.usertype)
FROM cte
WHERE usertype='customer'
GROUP BY cte.from_station_id
	,cte.from_station_name
	,cte.usertype
ORDER BY 1 DESC*/
--NOTE from the above query,once you know how many users a station has you also see how profitable the station is

--Stations with number of customers that hires according to the days of the week
--For weekends
/*SELECT cte.from_station_id
	,cte.from_station_name
	,cte.usertype
	,COUNT(cte.usertype) as count_of_user
FROM cte
WHERE usertype ='customer'
AND day_of_week in(1,7)
GROUP BY cte.from_station_id
	,cte.from_station_name
	,cte.usertype
ORDER BY 4 DESC*/
--This query shows the number of each customers who make hires from each stations on weekends

--For week_day
/*SELECT cte.from_station_id
	,cte.from_station_name
	,cte.usertype
	,COUNT(cte.usertype)
FROM cte
WHERE usertype ='customer'
AND day_of_week in(2,3,4,5,6)
GROUP BY cte.from_station_id
	,cte.from_station_name
	,cte.usertype
ORDER BY 4 DESC*/
--This query shows the number of each customers who make hires from each stations on weekdays


--Bikes that are frequently used incase of maintainance 
/*SELECT cte.bikeid	
	,COUNT(bikeid)
FROM cte
GROUP BY cte.bikeid
ORDER BY 2 DESC*/
--The above query shows how many times a bike has been used for the cause of this year

SELECT DISTINCT COUNT(bikeid)
FROM cte



/*RECOMMENDATION
1. A marketing plan will be to promote additional weekend activities such as biking and racing (marathon)
2. After a certain number of hiring, you may be able to offer top casual riders free trips..
3. By making a promotion to target weekends, since weekends has greater hire from causal riders
4. We can observe from our study that our casual riders hire more on weekends.
   We also discovered that Gen Z and Minnellas (those born between 1975 and 2000) have more weekend hires than any other age group.
   For optimum reach, the advertisement should be run on social media.
5. Based on the results of the foregoing study, the stations with the most causal passengers should receive the greatest promotion attention.

*/ 
		

		 