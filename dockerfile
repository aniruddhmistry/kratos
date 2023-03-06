FROM alpine:latest

RUN apk update && apk add python

CMD [ "python", "--version" ]
