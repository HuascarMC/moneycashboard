DROP TABLE transactions;

CREATE TABLE transactions(
  id SERIAL PRIMARY KEY,
  amount INT4,
  tag VARCHAR(255),
  shop VARCHAR(255)
);
