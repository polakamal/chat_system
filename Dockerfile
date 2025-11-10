FROM ruby:3.4

# Set working directory inside the container
WORKDIR /chat_system

# Install dependencies needed to build native gems (mysql2, etc.)
# libmariadb-dev replaces the old libmysqlclient-dev
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential libmariadb-dev libmariadb-dev-compat && \
    rm -rf /var/lib/apt/lists/*

# Install gem dependencies first (cached layer)
RUN bundle install

# Copy the rest of the application
COPY . .
