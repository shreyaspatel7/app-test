# app-test
## Introduction
This example provides a boilerplate code for building, tagging, and pushing Docker image to DockerHub based on the GitHub branch name.

- To improve the security aspects, we have added new `deploy` user and group to the docker container. 
- We have also added `entrypoint.sh` file so later on we can configure the application to run with appropriate settings :) 

We are using Makefile to perform the basic docker build tag and push commands. We have also added additional functionality to clean the build as well as test it and run it.


## Commands
### Test
```
make test
```
### All command
The following command will build, tag, and push the
```
make all PROJECT_ID=<DOCKER_HUB_REPO_NAME>
```