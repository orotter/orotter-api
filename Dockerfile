FROM ruby:2.2.4
MAINTAINER balmychan <ayumi.goto.0212@gmail.com>

RUN apt-get update -qq 
RUN mkdir /app
WORKDIR /app
RUN git clone https://github.com/balmychan/orotter-api.git .
RUN bundle install
ADD . /app
WORKDIR /app