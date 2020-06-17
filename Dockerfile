FROM python:alpine3.7
RUN addgroup -g 1001 deploy 

RUN adduser -D -h /home/deploy -u 1001  \
    -G deploy -s /bin/sh -k /dev/null deploy

USER deploy
WORKDIR /home/deploy
COPY --chown=deploy:deploy ./src/app.py ./
COPY --chown=deploy:deploy ./requirements.txt ./
COPY --chown=deploy:deploy ./entrypoint.sh ./

EXPOSE 5000
ENTRYPOINT ["./entrypoint.sh"]


