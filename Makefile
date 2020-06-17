TAG    := $(git rev-parse --abbrev-ref HEAD)
LATEST := latest
PROJECT_ID := infra

build:
	@docker build -t test-app:${TAG} -f Dockerfile .
	@docker tag test-app:${TAG} test-app:${LATEST}

clean:
	@docker rmi -f test-app:${TAG}

clean-pyc:
	find . -name '*.pyc' -exec rm --force {} +

test: clean-pyc
	python src/unit_test.py
