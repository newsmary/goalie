FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

#set env vars to store gems in /bundle so they can be cached

#ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
#  BUNDLE_JOBS=2 \
#  BUNDLE_PATH=/bundle

RUN bundle install

ADD . $APP_HOME
