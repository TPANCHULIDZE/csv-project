# README

## SETUP

**install ruby 3.2.0 version**

### RUN 

``  bundle install ``

``  cp config/database.example.yml config/database.yml ``

**fill database.yml file with your credential**

``  rails db:create db:migrate ``

`` bin/dev ``


### DOCS
	***in public/csv_files there is first.csv file, you can use this for testing or create new csv file with same configuration, please use ``;`` for separator in csv file.
	there is column names [name: String, amount: Integer, price: Float, company: String, deadline: DateTime(%d/%m/%y), description: String] ***