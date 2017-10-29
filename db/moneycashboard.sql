DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS users;

CREATE TABLE users(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  budget INT4
);

CREATE TABLE transactions(
  id SERIAL PRIMARY KEY,
  amount INT4,
  tag VARCHAR(255),
  shop VARCHAR(255),
  date DATE,
  user_id INT4 REFERENCES users(id)
);
