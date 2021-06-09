![Little Esty Shop](https://i.imgur.com/1lVAR44.png)



## Background and Description

"Little Esty Shop" is a e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Technology and Implementation

Little Esty Shop was built using the following technologies:
* Ruby on Rails
* Ruby
* Heroku

## Setup

This project requires Ruby 2.5.3.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
    * `rails db:migrate`
    * `rails csv_load:all`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements
- must use Rails 5.2.x
- must use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
- must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- must include a thorough README to describe the project
- must deploy completed code to Heroku

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)
