                       ####   kpi"s ########
select count(restaurantid) AS TOTAL_RESTAURANTS from ZOMATO11;   #TOTAL RESTAURANTS KPI
select COUNT(DISTINCT COUNTRYCODE) AS TOTAL_COUNTRYCODE from ZOMATO11; #TOTAL COUNTRY KPI 
select COUNT(DISTINCT CITY) AS TOTAL_CITIES from ZOMATO11;        #TOTAL CITIES KPI
select round(AVG(RATING)   OVER () , 1) as Average_rating from zomato11;   #AVG RATING 2.9
SELECT 
    ROUND(AVG(DISTINCT Rating), 2) AS Average_Rating            #AVG RATING 3
FROM zomato11;



############CITY-Wise Restaurant Distribution#########################
select count(restaurantid) AS TOTAL_RESTAURANTS , city from zomato11 #CITY WISE COUNT RESTAURANTS
group by city;


select * from country;
select * from currency_s;
select * from zomato11;

############Find the Numbers of Resturants based on Country.#########################
SELECT 
    COUNT(z.restaurantid) AS Restaurant_Count, 
    c.countryname AS Country_Name
 
FROM 
    zomato11 AS z
LEFT JOIN 
    country AS c
ON 
    z.countrycode = c.countryid
GROUP BY 
    c.countryname
ORDER BY 
    c.countryname DESC;
    
    
   ##################  NO OF RESTAURANTS BASED ON COUNTRY AND CITY############ 
    SELECT 
    COUNT(z.restaurantid) AS Restaurant_Count, 
    c.countryname AS Country_Name, 
    z.city AS City
FROM 
    zomato11 AS z
LEFT JOIN 
    country AS c
ON 
    z.countrycode = c.countryid
GROUP BY 
    c.countryname, z.city
ORDER BY 
    c.countryname DESC, z.city ASC;
    
    
    
  # Numbers of Resturants opening based on Year , Quarter , Month
  
 SELECT 
 distinct`year opening` AS Yearr,
`quarter` AS Quarterr,
 `month name` AS Monthhname,
    COUNT(restaurantid) AS total_restaurants
   
FROM
    zomato11
GROUP BY `year opening` , `quarter`,  `month name`
ORDER BY `year opening` DESC;

select * from zomato11;

 ############Numbers of Resturants opening based on Year###############
SELECT DISTINCT
    `year opening`, COUNT(restaurantid) AS total_restaurants
FROM
    zomato11
GROUP BY `year opening`
ORDER BY `year opening` ASC
;
 #######Numbers of Resturants opening based on month ############
 
SELECT DISTINCT
    `month name`,`month no`, COUNT(restaurantid) AS total_restaurants
FROM
    zomato11
GROUP BY `month name`,`month no`
ORDER BY `month no` ASC;

 ##############Numbers of Resturants opening based on quarter##########
 SELECT DISTINCT
    `QUARTER`, COUNT(restaurantid) AS total_restaurants
FROM
    zomato11
GROUP BY `QUARTER`
ORDER BY `QUARTER` ASC;



########Count of Resturants based on Average Ratings###########

SELECT 
    AVG(rating) AS avg_rating,  
    COUNT(restaurantid) AS total_restaurants  
FROM 
    zomato11
GROUP BY 
    rating  
ORDER BY 
    avg_rating DESC;  


SELECT 
    CASE 
        WHEN rating BETWEEN 1 AND 2 THEN '1-2'
        WHEN rating BETWEEN 2.1 AND 3 THEN '2.1-3'
        WHEN rating BETWEEN 3.1 AND 4 THEN '3.1-4'
        WHEN rating BETWEEN 4.1 AND 5 THEN '4.1-5'
        ELSE 'Unknown'
    END AS rating_range,
    COUNT(restaurantid) AS total_restaurants
FROM 
    zomato11
GROUP BY 
    rating_range
ORDER BY 
    rating_range;

###Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets

select count(Average_Cost_for_two) from zomato11;
SELECT 
    CASE 
        WHEN Average_Cost_for_two BETWEEN 0 AND 10000 THEN '0-10000'
         WHEN Average_Cost_for_two BETWEEN 10001 AND 200000 THEN '10001-200000'
         WHEN Average_Cost_for_two BETWEEN 200001 AND 600000 THEN '200001-600000'
         WHEN Average_Cost_for_two BETWEEN 600001 AND 800000 THEN '600001-800000'
        ELSE '0'
 END AS bucket_prize,
    COUNT(restaurantid) AS count_restaurants
FROM 
    zomato11
GROUP BY 
    bucket_prize
ORDER BY 
    bucket_prize;

#####Percentage of Resturants based on "Has_Table_booking"###########
select distinct Has_Table_booking ,count(restaurantid) as TOTAL_RESTAURANTS from zomato11 group by Has_Table_booking;


select distinct Has_Table_booking ,
count(restaurantid) as TOTAL_RESTAURANTS 
from zomato11 
group by Has_Table_booking;



#select distinct Has_Table_booking ,
#(COUNT(restaurantid) * 100.0) / SUM(COUNT(restaurantid)) OVER () AS Percentage_of_Restaurants 
#from zomato11 
#group by Has_Table_booking;

SELECT 
    Has_Table_booking,
    COUNT(restaurantid) AS Count_of_Restaurants,
    round((COUNT(restaurantid) * 100.0) / SUM(COUNT(restaurantid))  OVER (), 2)  AS Percentage_of_Restaurants
FROM zomato11
GROUP BY Has_Table_booking;

######Percentage of Resturants based on "Has_Online_delivery"###########

 select has_online_delivery,
 COUNT(restaurantid) AS Count_of_Restaurants,
    round((COUNT(restaurantid) * 100.0) / SUM(COUNT(restaurantid))  OVER (), 0)  AS Percentage_of_Restaurants 
    FROM zomato11
GROUP BY Has_Table_booking;

######Percentage of Resturants based on "is_delivering_now"###########

select is_delivering_now , 
count(restaurantid) as Restaurants_count,
round((count(restaurantid)*100.0) / sum(count(restaurantid)) over (),   1) as percentage_of_restaurants
from zomato11
group by is_delivering_now 
order by Is_delivering_now desc;

########Top Cuisines per Country########

SELECT distinct 
    z.cuisines AS cuisines,
    c.countryname AS country,
    COUNT(z.restaurantid) AS count_of_restaurants
FROM zomato11 z
LEFT JOIN country c
    ON z.countrycode = c.countryid
    group by cuisines,country
    order by count_of_restaurants desc
    limit 10;

#####################Top-Rated Restaurants#############
select DISTINCT `restaurant name` , RATING FROM ZOMATO11 GROUP BY RATING ,`restaurant name` ORDER BY RATING DESC  LIMIT 10;
select ROW_NUMBER() OVER (ORDER BY RATING DESC) AS ROW_NUM, `restaurant name` , RATING FROM ZOMATO11  ORDER BY RATING DESC  LIMIT 10;

###########Votes Distribution#########
SELECT 
row_number() OVER() AS ROW_NUM,
`RESTAURANT NAME`, VOTES
FROM ZOMATO11
ORDER BY VOTES DESC
LIMIT 10;

#############Top 3 Countries by Restaurants in QuarteRR############3
SELECT   Z.`FINANCIAL QUARTER` AS FINANCIAL_QUARTERS ,
		Z.`RESTAURANT NAME` AS RESTAURANTS,
        C.COUNTRYNAME AS COUNTRY
        FROM ZOMATO11 Z
        LEFT JOIN 
        COUNTRY C
        ON Z.COUNTRYCODE=C.COUNTRYID
        group by FINANCIAL_QUARTERS,COUNTRY,RESTAURANTS
        order by FINANCIAL_QUARTERS ASC
        LIMIT 3;

SELECT 
    `FINANCIAL QUARTER`, 
    c.countryname, 
    COUNT(z.restaurantid) AS count_of_restaurants
FROM zomato11 z
JOIN country c ON z.countrycode = c.countryid                #WITH RESTAURANT_COUNT
GROUP BY `FINANCIAL QUARTER`, c.countryname
ORDER BY `FINANCIAL QUARTER`, count_of_restaurants DESC
LIMIT 3;


      

