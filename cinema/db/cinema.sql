DROP TABLE tickets;
DROP TABLE customers;
DROP TABLE films;

CREATE TABLE customers
(
  id SERIAL2 PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE films
(
  id SERIAL2 PRIMARY KEY,
  title VARCHAR(255),
  price INT
);

CREATE TABLE tickets
(
  id SERIAL2 PRIMARY KEY,
  customer_id INT2 REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT2 REFERENCES films(id) ON DELETE CASCADE
);
