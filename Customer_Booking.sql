create database customer_booking;
use customer_booking;

select * from customer_booking;

-- to remove unused columns
-- adds long haul column that checks whether flight is long haul
-- long haul flight is any flight 8 hours or longer based on ICAO
-- add ':00' to flight_hour to convert to time
-- converted 3 columns to "yes" and "no" to make tableau visualization easier
select num_passengers, trip_type, purchase_lead, length_of_stay, concat(flight_hour, ':00') as departure_time, flight_day, flight_duration,
case when flight_duration >= 8 then 'long haul'
			when flight_duration < 8 then 'short to medium haul'
			else 'no data'
		end as long_haul,
case when wants_extra_baggage = 1 then 'yes'
			else 'no'
            end as extra_bags,
case when wants_in_flight_meals = 1 then 'yes'
			else 'no'
            end as in_flight_meals,
case when wants_preferred_seat = 1 then 'yes'
			else 'no'
            end as preferred_seats
        from customer_booking
        limit 50000;

-- long haul passengers table
select num_passengers, trip_type, purchase_lead, length_of_stay, concat(flight_hour, ':00') as departure_time, flight_day, flight_duration,
case when wants_extra_baggage = 1 then 'yes'
			else 'no'
            end as extra_bags,
case when wants_in_flight_meals = 1 then 'yes'
			else 'no'
            end as in_flight_meals,
case when wants_preferred_seat = 1 then 'yes'
			else 'no'
            end as preferred_seats
	from customer_booking
	where flight_duration >= 8
    limit 50000;

-- short haul passengers table        
select num_passengers, trip_type, purchase_lead, length_of_stay, concat(flight_hour, ':00') as departure_time, flight_day, flight_duration,
case when wants_extra_baggage = 1 then 'yes'
			else 'no'
            end as extra_bags,
case when wants_in_flight_meals = 1 then 'yes'
			else 'no'
            end as in_flight_meals,
case when wants_preferred_seat = 1 then 'yes'
			else 'no'
            end as preferred_seats
	from customer_booking
	where flight_duration < 8
	limit 50000;
    
-- data summary by long haul vs short haul
select long_haul, 
	count(*) as number_of_travellers, 
	100.0*(count(*)/(select count(*) from customer_booking)) as proportion_of_travellers,  
	avg(purchase_lead) as average_purchase_lead,
	avg(length_of_stay) as average_length_of_stay,
	avg(flight_duration) as average_flight_time,
    sum(wants_extra_baggage)/count(*) as extra_bags_percent,
    sum(wants_preferred_seat)/count(*) as preferred_seat_percent,
    sum(wants_in_flight_meals)/count(*) as extra_meal_percent
-- long_haul column subquery
from (
	select *,
		case when flight_duration >= 8 then 'long haul'
			when flight_duration < 8 then 'short to medium haul'
			else 'no data'
		end as long_haul
        from customer_booking
) as bookings_summary
group by long_haul;

-- break down day of the week by flight type
select long_haul, 
sum(case when flight_day = 'Mon' then 1 else 0 end) as Monday,
sum(case when flight_day = 'Tue' then 1 else 0 end) as Tuesday,
sum(case when flight_day = 'Wed' then 1 else 0 end) as Wednesday,
sum(case when flight_day = 'Thu' then 1 else 0 end) as Thursday,
sum(case when flight_day = 'Fri' then 1 else 0 end) as Friday,
sum(case when flight_day = 'Sat' then 1 else 0 end) as Saturday,
sum(case when flight_day = 'Sun' then 1 else 0 end) as Sunday
from (
		select *,
		case when flight_duration >= 8 then 'long haul'
			when flight_duration < 8 then 'short to medium haul'
			else 'no data'
		end as long_haul
        from customer_booking
) as bookings_summary
group by long_haul;

