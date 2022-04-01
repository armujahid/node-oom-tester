FROM node:16-alpine

ENV NODE_ENV production

USER node
WORKDIR /home/node

COPY package*.json ./
RUN npm ci --only=production

COPY --chown=node:node . .

CMD ["npm", "start"]