# Use Python to extract version and project name
VERSION := $(shell uv run python -c "import tomllib; print(tomllib.load(open('pyproject.toml', 'rb'))['project']['version'])")
PROJECT := $(shell uv run python -c "import tomllib; print(tomllib.load(open('pyproject.toml', 'rb'))['project']['name'].lower())")
REGISTORY := ghcr.io/parikshith-palegar
GIT_COMMIT_SHA := $(shell git rev-parse HEAD)
GIT_COMMIT_SHA := $(shell git rev-parse HEAD)
BUILD_DATE := $(shell TZ='Asia/Kolkata' date +'%Y-%m-%dT%H:%M:%S%z')
NAME := $(REGISTORY)/$(PROJECT)

# Default target
build:
	docker build . \
		-t $(NAME):$(VERSION) \
		-t $(NAME):latest \
		--build-arg GIT_COMMIT_SHA=$(GIT_COMMIT_SHA) \
		--build-arg BUILD_DATE="$(BUILD_DATE)" \
		--build-arg VERSION=$(VERSION)

	@echo "✅ Built image: $(NAME):$(VERSION)"
	@echo "✅ Built image: $(NAME):latest"
# 	@docker tag $(NAME):latest $(NAME):$(VERSION)

build-push: build
	@echo "📤 Pushing images..."
	@docker push $(NAME):latest
	@docker push $(NAME):$(VERSION)
	@echo "✅ Pushed: $(NAME):latest and $(NAME):$(VERSION)"

version-patch:
	@./scripts/bump_version.sh patch

version-minor:
	@./scripts/bump_version.sh minor

version-major:
	@./scripts/bump_version.sh major