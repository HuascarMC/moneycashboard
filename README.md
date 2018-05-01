## Description

Simple expenses tracking application using PosgreSQL and Sinatra.

## How to run

- Clone this repo.

- Bundle install:
```
bundle install
```
- Run:
```
ruby transaction_controller
```

The app should be running on localhost/4567

## To run tests

Test suite needs improvement. The unit tests work for transaction and checks that the data input is correctly added to db.
A database called 'moneycashboard' should be created.

- To drop/create tables:
```
psql -d moneycashboard -f db/moneycashboard
```

- Seed pre-set data:
```
ruby seeds.rb
```
