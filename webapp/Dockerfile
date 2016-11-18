FROM ruby:2.3

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
        libpq-dev \
        sqlite3 \
        nodejs \
    && rm -rf /var/lib/apt/lists/*

#installing some gems manually (either because they shouldn't be in bundler or for caching purposes)
RUN gem install foreman rails

WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .
RUN RAILS_ENV=production rake assets:precompile

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
