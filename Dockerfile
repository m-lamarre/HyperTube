FROM ruby:2.4.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs imagemagick
RUN mkdir /hypertube
WORKDIR /hypertube
ADD Gemfile /hypertube/Gemfile
ADD Gemfile.lock /hypertube/Gemfile.lock
ENV RAILS_ENV docker
ENV RACK_ENV docker
RUN bundle install
ADD . /hypertube
