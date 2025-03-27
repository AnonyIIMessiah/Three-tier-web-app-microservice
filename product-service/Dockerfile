FROM node:23-alpine

WORKDIR /app

COPY package*.json .

RUN npm install

USER node

COPY --chown=node:node . .

EXPOSE 5002

CMD ["node", "server.js"]
