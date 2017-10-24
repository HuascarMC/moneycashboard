DROP TABLE transactions;
DROP TABLE users;

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
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
