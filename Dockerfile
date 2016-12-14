FROM alpine

EXPOSE 6419

WORKDIR /data

CMD ["grip", ".", "0.0.0.0"]

RUN apk --no-cache add py-pip

RUN pip install --no-cache-dir grip
