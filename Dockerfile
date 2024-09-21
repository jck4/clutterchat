FROM ruby:3.3.4

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn

# Set the working directory
WORKDIR /clutterchat

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install Ruby dependencies
RUN bundle install
RUN gem install foreman
# Copy the rest of the app's source code
COPY . .

RUN mkdir -p tmp/cache tmp/pids tmp/sockets log 