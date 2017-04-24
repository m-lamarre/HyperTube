FROM ruby:2.4.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /hypertube
WORKDIR /hypertube
ADD Gemfile /hypertube/Gemfile
ADD Gemfile.lock /hypertube/Gemfile.lock
RUN bundle install
ADD . /hypertube