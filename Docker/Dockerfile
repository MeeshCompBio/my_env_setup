# Use an existing docker image as a base
FROM alpine

# Download dependency and install
RUN apk add --update redis
RUN apk add --update gcc

# Tell the image what to do
CMD ["redis-server"]