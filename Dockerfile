FROM ruby:2.6
MAINTAINER Danilo Barion Nogueira <danilo.barion@gmail.com>

RUN apt-get update -qq \
      && apt-get install -y --no-install-recommends libc6 \
      libstdc++6 unixodbc-dev vim locales postgresql-client \
      && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
      && locale-gen \
      && export LC_ALL="en_US.utf8"

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir -p /feature_flags_service

WORKDIR /feature_flags_service
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install

ADD . /feature_flags_service
