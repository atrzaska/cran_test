# Welcome to SonarHome test app

## Technical Stack

- Ruby 3 (https://www.ruby-lang.org/en/)
- Rails 6 (https://rubyonrails.org/)
- Docker (https://www.docker.com/)
- docker-compose (https://docs.docker.com/compose/)
- Postgres (https://www.postgresql.org/)
- Redis (https://redis.io/)
- git (https://git-scm.com/)

## Setup

### Required software

- ruby
- git
- docker
- docker-compose

## Importing the packages with raketask

    bundle
    docker-compose up -d
    bundle exec rake db:setup
    bundle exec sidekiq
    bundle exec rake packages:refresh

## Running the tests

    bundle
    docker-compose up -d
    RAILS_ENV=test rake db:setup
    bundle exec rspec
