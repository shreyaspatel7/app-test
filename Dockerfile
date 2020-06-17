FROM python:alpine3.7

# Adds a new user group
RUN addgroup -g 1001 deploy 
#Adds a new user
RUN adduser -D -h /home/deploy -u 1001  \
    -G deploy -s /bin/sh -k /dev/null deploy

# Switch to the user newly created user
USER deploy
# Change the workign dir to new user's home dir
WORKDIR /home/deploy

# Copy the file with assiging owndership to newly created user and group
COPY --chown=deploy:deploy ./src/app.py ./
COPY --chown=deploy:deploy ./requirements.txt ./
COPY --chown=deploy:deploy ./entrypoint.sh ./

# Install python depedancies 
RUN pip install -r requirements.txt --user

# Expose the port for api
EXPOSE 5000

# Run the entrypoint script to start the python api server
ENTRYPOINT ["./entrypoint.sh"]


