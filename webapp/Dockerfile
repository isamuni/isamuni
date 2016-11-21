FROM ruby:2.3

# Adding recent nodejs repositories
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
        libpq-dev \
        sqlite3 \
        nodejs \
        tmux byobu\
    && rm -rf /var/lib/apt/lists/*


# installing some gems manually
# (either because they shouldn't be in bundler or for caching purposes)

RUN gem install tmuxinator foreman rails

# copying in Gemfile and running bundle install, so that we only do that when
# Gemfile changes

WORKDIR /app
COPY Gemfile* ./
RUN bundle install

COPY package.json ./
RUN npm install

# copying in the rest of the application
COPY . .

# precompiling assets
RUN RAILS_ENV=production rake assets:precompile
RUN npm run build

# running the server in production mode by default
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
