# Getting the git branch name
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
LATEST := latest
# Project/ DockerHub repo name 
PROJECT_ID := shreyas7p

# We will run this pre-check to tag the images with associated branch name
branch-check:
ifeq ($(BRANCH), master)
# We set the tag to latest if the branch is master
TAG := $(LATEST)
else
TAG := $(BRANCH)
endif

# Build and tag local docker image
build: branch-check
	@docker build -t test-app:${TAG} -f Dockerfile .
	@docker tag test-app:${TAG} test-app:${TAG}

# Remove local docker image 
clean: branch-check
	@docker rmi -f test-app:${TAG}

# Clean pythn cach
clean-pyc:
	find . -name '*.pyc' -exec rm --force {} +

# Run unit tests
test: clean-pyc
	python src/unit_test.py

# Tag the docker image for DockerHub push
tag: branch-check
	@docker tag test-app:${TAG} ${PROJECT_ID}/test-app:${TAG} 
# Pushs the image to DockerHub
push: branch-check
	@docker push ${PROJECT_ID}/test-app:${TAG}

# Build, Tag, and Pushes the local Docker image to DockerHub
all: build tag push
