FROM python:3.11-slim AS builder

WORKDIR /app

RUN pip install pyarmor==9.1.7

COPY . .

RUN scripts/pyarmor_gen.sh

# Final build
FROM python:3.11-slim
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

ARG GIT_COMMIT_SHA
ARG BUILD_DATE
ARG VERSION

LABEL git_commit_sha=${GIT_COMMIT_SHA}
LABEL build_date=${BUILD_DATE}
LABEL version=${VERSION}

ENV GIT_COMMIT_SHA=${GIT_COMMIT_SHA}
ENV BUILD_DATE=${BUILD_DATE}
ENV version=${VERSION}

# installing curl for healthcheck
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder /app/uv.lock .
COPY --from=builder /app/pyproject.toml .
COPY --from=builder /app/.python-version .
COPY --from=builder /app/dist .

RUN uv sync --locked

EXPOSE 3000

CMD [ "uv", "run", "main.py" ]
