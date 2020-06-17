BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
LATEST := latest
PROJECT_ID := shreyas7p

branch-check:
ifeq ($(BRANCH), master)
TAG := $(LATEST)
else
TAG := $(BRANCH)
endif

build: branch-check
	@docker build -t test-app:${TAG} -f Dockerfile .
	@docker tag test-app:${TAG} test-app:${TAG}

clean: branch-check
	@docker rmi -f test-app:${TAG}

clean-pyc:
	find . -name '*.pyc' -exec rm --force {} +

test: clean-pyc
	python src/unit_test.py

tag: branch-check
	@docker tag test-app:${TAG} ${PROJECT_ID}/test-app:${TAG} 

push: branch-check
	@docker push ${PROJECT_ID}/test-app:${TAG}


	

all: build tag push
