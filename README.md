# README

In order to install necessary dependencies run:
bundle install

Set up the development database using:
rails db:create db:migrate

to start the application locally run:
rails s

To see the web page navigate to:
localhost:3000

Before running tests, reset the test database and clear any cached data:
RAILS_ENV=test rails db:drop db:create db:migrate

Run your tests with:
bundle exec rspec
