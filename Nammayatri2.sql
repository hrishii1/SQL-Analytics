-- TOTAL NUMBER OF TRIPS
select count(*) from trips_details4; 
-- TO CHECK NULL VALUES 
SELECT tripid 
FROM trips_details4
WHERE tripid IS NULL 
   OR searches IS NULL ; 

-- TOTAL NUMBER OF DRIVERS 
select count(distinct driverid) drivers_numbers from trips; 

-- TOTAL EARNINGS 
select sum(fare)  fare from trips; 

-- TOTAL COMPLETED TRIPS 
select count(distinct tripid) completed_trips from trips; 

-- TOTAL NUMBER OF SEARCHES 
SELECT sum( searches) total_searches from trips_details4; 

-- TOTAL SEARCHES WHICH GOT ESTIMATE 
SELECT sum(searches_got_estimate) from trips_details4; 

-- TOTAL SEARCH FOR QUOTES 
SELECT sum(searches_got_QUOTES) from trips_details4; 

-- NO OF TRIPS CANCELLED BY DRIVERS 
SELECT count(*) - sum( driver_not_cancelled) cancelled_trips from trips_details4; 

-- TOTAL OTP ENTERED 
SELECT sum(otp_entered) from trips_details4; 

-- TOTAL NO OF END RIDES 
SELECT sum(end_ride) from trips_details4; 

-- AVERAGE DISTANCE PER TRIP 
select avg(distance) from trips; 

-- AVG FARE PER TRIP 
select avg(FARE) from trips; 

-- DISTANCE TRAVELLED 
SELECT SUM(DISTANCE) DISTANCE_KMS FROM TRIPS ; 

-- MOST USED PAYMENT METHOD 

select a.method  from payment a inner join 
(SELECT  FAREMETHOD, COUNT(distinct TRIPID) CNT FROM TRIPS 
group by FAREMETHOD 
ORDER BY COUNT(distinct TRIPID) DESC)  b 
on a.id = b.faremethod ; 

-- HIGHEST PAYMENT MADE THROUGH WHICH INSTRUMENT 
SELECT A.Method from payment a inner join 
(SELECT * FROM TRIPS
ORDER BY FARE DESC) b 
on a.id = b.faremethod; 

-- WHICH LOCATIONS HAD HIGHEST NO OF TRIPS 
SELECT * FROM TRIPS ; 
 SELECT LOC_FROM , LOC_TO , COUNT( DISTINCT TRIPID) FROM TRIPS 
 GROUP BY LOC_FROM, LOC_TO 
 ORDER BY COUNT( DISTINCT TRIPID)DESC  ; 
 
 -- TOP 5 EARNING DRIVERS 
 SELECT driverid, sum(fare) from trips
 group by driverid 
 order by sum(fare) desc
 limit 5; 
 
 -- TOP 5 EARNING DRIVERS USING WINDOWS FUNCTION (DESNSE_RANK) 
 SELECT * FROM
 (SELECT *, dense_rank() OVER(ORDER BY fare DESC) RNK FROM 
 (SELECT driverid, sum(fare) fare from trips
 group by driverid )A) B
 WHERE RNK <6; 
 
-- WHICH DURATION HAD MORE TRIPS 
select * from trips; 
select * from 
(select * , rank() over (order by cnt) rnk from
(select duration, count(distinct tripid) cnt from trips
group by duration) b) c
where rnk = 1; 

-- WHICH DRIVER, CUSTOMER PAIR HAD MORE ORDERS 
select * from 
(select *, rank() over (order by cnt desc) rnk from 
(select driverid, custid, count(distinct tripid) cnt from trips
group by driverid, custid)b ) c
where rnk = 1; 

-- SEARCH TO ESTIMATE RATE 

select sum(searches_got_estimate) / sum(searches) * 100 from trips_details4; 

-- ESTIMATE TO SEARCH FOR QUOTE RATES 

select sum(searches_for_quotes)/ sum(searches_got_estimate)  * 100 from trips_details4; 

-- QUOTE ACCEPT RATE 
select  sum(searches_got_quotes) / 100 from trips_details4; 

-- WHICH AREA GOT HIGHEST TRIPS IN DURATION 
select * from trips; 
select * from 
(select *, rank() over (partition by duration order by cnt desc) rnk from 
(select duration, loc_from , count(distinct tripid) cnt from trips
group by duration, loc_from) b) c
where rnk = 1;  

-- WHICH AREA GOT HIGHEST FARES, CANCELLATION TRIPS; 
select  * from trips; 
select * from 
(select *,  rank() over (order by fare desc) rnk from 
(select  loc_from , sum(fare) fare from trips 
group by loc_from ) a) b
where rnk = 1; 


