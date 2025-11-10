FROM ruby:3.2

# Set working directory inside the container
WORKDIR /chat_system

# Install dependencies needed to build native gems (mysql2, etc.)
# libmariadb-dev replaces the old libmysqlclient-dev
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential libmariadb-dev libmariadb-dev-compat && \
    rm -rf /var/lib/apt/lists/*

# Install gem dependencies first (cached layer)
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the application
COPY . .

# Expose the Rails app port
EXPOSE 3000

# Default command (optional, but nice for dev mode)
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
