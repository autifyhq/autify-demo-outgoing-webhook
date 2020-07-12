ARG RUBY_VERSION
FROM ruby:${RUBY_VERSION}

ENV LANG C.UTF-8
ENV ROOT /usr/src/app
ARG BUNDLER_VERSION

RUN apk update -qq \
    # Updated and used on-the-fly and not cached locally
    # See: https://github.com/gliderlabs/docker-alpine/blob/master/docs/usage.md#disabling-cache
    && apk add --no-cache build-base \
    # Prevent bundler warnings `ensure that the bundler version executed is >= that which created Gemfile.lock`
    && gem update --system && gem install bundler:${BUNDLER_VERSION}

# Define working directory
WORKDIR ${ROOT}

# Install Dependencies
ADD Gemfile* $ROOT/
RUN bundler update --bundler \
    && bundle install -j "$(getconf _NPROCESSORS_ONLN)" --retry 5 \
    # Remove unneeded files (cached *.gem, *.o, *.c)
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete

COPY . ${ROOT}/

# Start the main process.
EXPOSE 80
CMD ["bundle", "exec", "rackup", "config.ru", "-p", "80", "-o", "0.0.0.0"]
