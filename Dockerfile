FROM ruby:2.6.5

RUN apt-get update && apt-get install build-essential && apt-get install libc6-dev && apt-get install freetds-dev -y

WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN gem install bundler

RUN bundle install
ADD . /app

CMD ./rails db:setup db:migrate

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]