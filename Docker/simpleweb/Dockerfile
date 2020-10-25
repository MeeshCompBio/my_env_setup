# base image specify
FROM node:alpine

WORKDIR /usr/app

# Install some dependencits
COPY ./package.json ./
RUN npm install
COPY ./ ./
#set command
CMD ["npm", "start"]