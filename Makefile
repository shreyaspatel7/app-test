BRANCH    := $$(git rev-parse --abbrev-ref HEAD)
LATEST := latest
PROJECT_ID := shreyas7p

ifeq ($(BRANCH), "master")
	TAG := latest
else
	TAG := $(BRANCH)
endif

build:
	@docker build -t test-app:${TAG} -f Dockerfile .
	@docker tag test-app:${TAG} test-app:${LATEST}

clean:
	@docker rmi -f test-app:${TAG}

clean-pyc:
	find . -name '*.pyc' -exec rm --force {} +

test: clean-pyc
	python src/unit_test.py

tag:
	@docker tag test-app:${TAG} ${PROJECT_ID}/test-app:${TAG} 

push:
	@docker push ${PROJECT_ID}/test-app:${TAG}


	

all: build tag push
