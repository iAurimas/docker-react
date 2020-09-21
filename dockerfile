# Use existing docker image as a Base
#starts building phase in multibuild process
FROM node:alpine as builder

#Creates a folder to which app content will be copied

WORKDIR "/app"

# Copy package.json required for npm install
COPY ./package.json ./

# Download an install dependencies:
# Install npm

RUN npm install

# Copy entire content
COPY ./ ./

# Tell image what to do when it starts a Container  > Builds build directory and store it in /app/build

RUN npm run build



FROM nginx

# copy build folder from build process executed above
COPY --from=builder /app/build /usr/share/nginx/html

#nginx container default start comand will start nginx automaticaly
