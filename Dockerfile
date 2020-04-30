FROM ruby:2.6.5
MAINTAINER Nathan McCallum <hello@nathan-mccallum.com>

#
# Update bundler
#
RUN gem install bundler --version 1.17.3

#
# Install node
#
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

#
# Throw errors if Gemfile has been modified since Gemfile.lock
#
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock .ruby-version ./
RUN bundle install

COPY . .
