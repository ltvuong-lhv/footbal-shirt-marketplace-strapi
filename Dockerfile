FROM node:20-alpine

WORKDIR /app

ENV NODE_ENV=production
ENV NODE_OPTIONS="--max-old-space-size=1024"

COPY package*.json ./
RUN npm install --production

COPY . .

RUN npm run build

EXPOSE 1337
CMD ["npm", "run", "start"]
