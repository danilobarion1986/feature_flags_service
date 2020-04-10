FROM ruby:2.6.4-alpine

ENV BUILD_PACKAGES tzdata git linux-headers build-base freetds-dev

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.5/main' >> /etc/apk/repositories

RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    rm -rf /var/cache/apk/*

WORKDIR /usr/src/app

RUN gem install bundler

COPY Gemfile Gemfile.lock ./

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rackup", "--host", "0.0.0.0", "--port", "8080"]
