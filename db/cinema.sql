
DROP TABLE  if exists screenings;
drop table if exists tickets;
DROP TABLE  if exists customers;
DROP TABLE  if exists films;



CREATE TABLE customers  (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  -- genre VARCHAR(255),
  funds int
);

CREATE TABLE films(
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  price int
);

create table  tickets  (
  id serial primary key,
  customer_id int references customers(id) on delete cascade,
  film_id int references films(id) on delete cascade

);

create table  screenings  (
  id serial primary key,
  film_time  TIME (0) NOT NULL,
  tickets_per_screening int references tickets(id) on delete cascade,
  max_seats int

);
