# Use existing docker image as a Base
#starts building phase in multibuild process
FROM node:alpine

#Creates a folder to which app content will be copied

WORKDIR "/app"

# Copy package.json required for npm install
COPY package*.json ./

# Download an install dependencies:
# Install npm

RUN npm install

# Copy entire content
COPY ./ ./

# Tell image what to do when it starts a Container  > Builds build directory and store it in /app/build

RUN npm run build



FROM nginx

#Expose port 80 once deployed to elasticbeanstalk, this will not work localy!!!!!!!
EXPOSE 80

# copy build folder from build process executed above
COPY --from=0 /app/build /usr/share/nginx/html

#nginx container default start comand will start nginx automaticaly
