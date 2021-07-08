# syntax=docker/dockerfile:experimental
FROM elixir:1.9-slim AS app_builder

ENV MIX_ENV=prod \
    TEST=1 \
    LANG=C.UTF-8

RUN mix local.hex --ddforce && \
    mix local.rebar --force


RUN mkdir /app
WORKDIR /app

COPY config ./config
COPY lib ./lib
COPY priv ./priv
COPY mix.exs .
COPY mix.lock .

RUN mix deps.get
RUN mix deps.compile
RUN mix phx.digest
RUN mix release


FROM debian:stretch-slim AS app

ENV LANG=C.UTF-8

RUN apt-get update && apt-get install -y openssl

RUN useradd --create-home app
WORKDIR /home/app
COPY --from=app_builder /app/_build .
COPY --from=app_builder /app/priv .
RUN chown -R app: ./prod
USER app

CMD ["./prod/rel/recept_generatorn/bin/recept_generatorn", "start"]
