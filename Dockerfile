# Adapted from: https://hexdocs.pm/phoenix/releases.html#containers
ARG ELIXIR_VERSION
ARG ERLANG_VERSION
ARG ALPINE_VERSION

FROM hexpm/elixir:${ELIXIR_VERSION}-erlang-${ERLANG_VERSION}-alpine-${ALPINE_VERSION} AS builder
ENV MIX_ENV=prod
WORKDIR /app

RUN apk add --no-cache build-base npm git python3 && \
  mix local.hex --force && \
  mix local.rebar --force

COPY mix.exs mix.lock ./
COPY config config
COPY priv priv
COPY assets assets
COPY lib lib

RUN mix do deps.get, deps.compile && \
  npm --prefix ./assets ci --progress=false --no-audit --loglevel=error && \
  npm run --prefix ./assets deploy && \
  mix phx.digest && \
  mix do compile, release

FROM alpine:${ALPINE_VERSION} AS runner
# EXPOSE 4000 5432
WORKDIR /app

RUN apk add --no-cache openssl ncurses-libs && \
  chown nobody:nobody /app

USER nobody:nobody
COPY --from=builder --chown=nobody:nobody /app/_build/prod/rel/sample_phoenix_app_without_db ./
ENV HOME=/app
CMD ["bin/sample_phoenix_app_without_db", "start"]
