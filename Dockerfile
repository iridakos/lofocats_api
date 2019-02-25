FROM ruby:2.3-alpine

COPY . /app

WORKDIR /app

RUN apk add --no-cache --virtual .builddeps \
    build-base \
  && apk add --no-cache --virtual .rundeps \
    postgresql-dev \
    postgresql-client \
    tzdata \
  && bundle install --without development test \
  && chown -R daemon:daemon /app \
  && apk del .builddeps

ENTRYPOINT ["/app/bin/entrypoint.sh"]

EXPOSE 3001

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3001"]
