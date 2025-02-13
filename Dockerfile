 FROM ruby:3.2.2
 WORKDIR /app
 RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
 RUN apt-get update -y
 RUN apt-get install -y nodejs
 RUN npm install -g yarn