# Getting the git branch name
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
LATEST := latest
APP_NAME := test-app
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
	@docker build -t ${APP_NAME}:${TAG} -f Dockerfile .
	@docker tag ${APP_NAME}:${TAG} test-app:${TAG}

# Remove local docker image 
clean: branch-check
	@docker rmi -f ${APP_NAME}:${TAG}

# Clean pythn cach
clean-pyc:
	find . -name '*.pyc' -exec rm --force {} +

# Run unit tests
test: clean-pyc
	python src/unit_test.py

# Tag the docker image for DockerHub push
tag: branch-check
	@docker tag ${APP_NAME}:${TAG} ${PROJECT_ID}/${APP_NAME}:${TAG} 
# Pushs the image to DockerHub
push: branch-check
	@docker push ${PROJECT_ID}/${APP_NAME}:${TAG}

# Build, Tag, and Pushes the local Docker image to DockerHub
all: build tag push
