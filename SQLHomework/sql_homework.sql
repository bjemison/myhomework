Use sakila;
# Display first and last name of all actors from actor table 
select
first_name,
last_name
from actor;
# Join first and last name together in one column
select upper(concat(first_name, ' ', last_name)) as 'Actor Name' 
from actor;

# Find id, first and last name of an actor named Joe
select
actor_id,
first_name,
last_name
from actor
where first_name = 'Joe';

# Find all actors whose last name contains GEN
select
*
from actor
where last_name like '%Gen%' ;

# Find all actors whose last name contains LI, order rows by first name and last name
select
*
from actor
where last_name like '%LI%' 
order by first_name, last_name;

# Display country_Id and country for Afghanistan, Bangladesh and China.
select
country_id,
country
from country
where country in ('Afghanistan', 'Bangladesh', 'China')
;

# Add a column for middle name 
alter table actor

add column middle_name varchar(50) null after first_name;

# Change middle name column to Blobs
alter table actor 

modify column middle_name blob;

# Delete middle_name column
alter table actor
drop column middle_name;

#List the last name of actors and number of actors with that last name
select
last_name,
count(*) as 'Count of Actors'
from actor
group by 1;

#Last name shared by at least 2 actors
select
last_name,
count(*) as 'Count of Actors'
from actor
group by 1
having 'Count of Actors' >2;

# Change Groucho Williams to Harpo
update actor
set first_name = 'HARPO'
where first_name = 'GROUCHO'
and last_name = 'WILLIAMS';

# Change back to Groucho
update actor 
set first_name= 'GROUCHO'
where first_name='HARPO' and last_name='WILLIAMS';

#schema for address 
describe sakila.address;

# first name, last name and address of all staff members
select
s.first_name,
s.last_name,
a.address
from staff s
left join address a
on s.address_id = a.address_id;

# Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment
select
s.first_name,
s.last_name,
sum(p.amount) as 'total'
from staff s 
left join payment p on s.staff_id = p.staff_id 
group by 1,2; 

# List each film and number of actors in film using film_actor and film tables. Use inner join
select
f.title,
count(fa.actor_id) as 'total'
from film f 
left join film_actor fa on f.film_id = fa.film_id
group by 1; 

# Number of copies of Hunchback Impossible in inventory system
select 
f.title, 
count(i.inventory_id) as 'Copies Available'
from film f
inner join
inventory i 
on f.film_id = i.film_id
where
title = 'Hunchback Impossible';

# Using the payment and customer tables and join command list the total paid by each customer. Lat names in alphabetical order
select c.first_name, 
c.last_name, sum(p.amount) AS 'total'
from customer c 
left join payment p 
on c.customer_id = p.customer_id
group by 1,2
order by 2;

# Movies starting with K or Q whose language is English.
select title
from film
where (title like 'K%' or title like 'Q%') 
and language_id=(select 
language_id from language where name='English');

# Using subqueries to display names of all actors who appeared in Alon Trip
select first_name, 
last_name
from actor
where actor_id
in (select 
actor_id 
from film_actor 
where film_id 
in (select 
film_id 
from film 
where title='ALONE TRIP'));

# Names and email address for all Canadian customers. Use joins

select first_name, 
last_name, 
email 
from customer c
inner join address a 
on c.address_id = a.address_id
inner join city 
on (a.city_id=city.city_id)
inner join country  
on (city.country_id= country.country_id);

# Identify all movies categorized as family films
select 
title
from film
where
film_id in (
select 
film_id
from film_category
where
category_id in (
select
category_id
from
category
where
name = 'Family'));

# Most frequently rented films in descening order
select f.title, 
count(f.film_id) as 'Number of Rentals'
from film f
inner join inventory i 
on f.film_id= i.film_id
inner join rental r 
on i.inventory_id= r.inventory_id
group by 1 
order by 'Number of Rentals' desc;

#How much business in dollars each store brought in 
select
s.store_id, 
sum(p.amount) 
from payment p
inner join staff s 
on s.staff_id = p.staff_id
group by 1;

# Write a query to display for each store its store ID, city, and country.
select store_id, 
city, 
country 
from store s
inner join address a 
on s.address_id = a.address_id
inner join city ci 
on a.city_id = ci.city_id
inner join country cnt
on ci.country_id = cnt.country_id;

# List top 5 genres in gross revenue 
create view top_5 as 
select c.name , 
sum(p.amount) as 'Gross Revenue' 
from category c
inner join film_category fc 
on c.category_id = fc.category_id
join inventory i 
on fc.film_id = i.film_id
inner join rental r 
on i.inventory_id=r.inventory_id
inner join payment p 
on r.rental_id = p.rental_id
group by 1
order by 2  
limit 5;

# Delete view
drop view top_5;