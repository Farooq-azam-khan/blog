from node:18

workdir /usr/src/app

copy package*.json ./
copy elm-tooling.json ./
run npm install 

copy . . 

expose 1234
cmd ["npm", "start"] 

