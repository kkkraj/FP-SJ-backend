# Use the official Ruby image as a base
FROM ruby:3.2.2-alpine

# Install system dependencies
RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    postgresql-client \
    tzdata \
    nodejs \
    yarn \
    git

# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3

# Copy the rest of the application
COPY . .

# Precompile assets
RUN bundle exec rake assets:precompile RAILS_ENV=production

# Create a non-root user
RUN addgroup -g 1000 rails && \
    adduser -D -s /bin/sh -u 1000 -G rails rails

# Change ownership of the app directory
RUN chown -R rails:rails /app

# Switch to non-root user
USER rails

# Expose port
EXPOSE 3000

# Set environment variables
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true

# Start the application
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"] 