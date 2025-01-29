# Airline-Booking-Analysis-Project

## Project Overview
Used SQL to analyze and compare booking trends between short haul and long haul flights and suggest marketing strategies to increase sales. Tableau was used for creating dashboard.

## How to Set up
This project was done on mySQL and Tableau with no additional extensions.
Instructions to set up mySQL can be found here:
https://dev.mysql.com/doc/mysql-getting-started/en/

## Data
This project used the Airlines_Bookings.csv dataset on Kaggle.
Link: https://www.kaggle.com/datasets/anandshaw2001/airlines-booking-csv
### Description
Attributes used from original file:
* num_passengers: The amount of passengers listed in one booking
* trip_type: Round trip, circle trip or one way
* purchase_lead: Number of days between booking and flight
* length_of_stay: How long each person stays at the destination (in days)
* departure_time: Time of the day (in hours) of departure
* flight_day: Day of the week of departure
* flight_duration: length of flight in hours
* wants_extra_baggage: Whether a passenger wants extra bags
* wants_in_flight_meals: Whether a passenger wants in flight meals
* wants_preferred_seat: Whether a passenger pre-booked a seat
### Data Preprocessing
List of modifications made to original file:
```sql
case when flight_duration >= 8 then 'long haul'
			when flight_duration < 8 then 'short to medium haul'
			else 'no data'
		end as long_haul,
```
added long_haul column to check whether a flight was long haul or short haul (long haul if flight is 8 hours or longer)
```sql
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
```
modified wants_extra_baggage, wants_in_flight_meals and wants_preferred_seat column from original file from containing 1 and 0 to yes and no for tableau visualization, as well as changing the column names.

## Results
In general, long haul and short haul passengers exhibit similar booking patterns, with some notable exceptions.
![Departure Time](https://github.com/user-attachments/assets/7c448bbb-334f-4548-b35d-a38987df3a3c)

When looking at the trends in departure time (with green indicating short haul and blue indicating long haul), we can see that short haul passenger bookings increased from 12 pm to 2 pm whereas long haul bookings decreased.

![Wants Extra Bag](https://github.com/user-attachments/assets/54b85b58-a661-4e5f-ae0e-751a3f2bb954)
![Wants In Flight Meal](https://github.com/user-attachments/assets/fa4e9531-e2ee-431d-9a0f-77f031ca8131)
![Wants Preferred Seat](https://github.com/user-attachments/assets/26835f0a-a845-4fe2-9f9a-d770ab98d566)

In general, long haul passengers are more likely to book additional services such as extra bags and in-flight meals.
