# Dockerfile (single-stage)

FROM node:20-alpine
WORKDIR /app

# Install project dependencies and build tools
COPY package.json package-lock.json* ./
# npm ci requires package-lock.json; fallback to npm install if none.
RUN if [ -f package-lock.json ]; then npm ci; else npm install; fi

# Copy project source and build app
COPY . .
RUN npm run build

# Optional: install a static server for local container run/test
RUN npm install -g serve

# Expose standard port (for local testing).
EXPOSE 5000

CMD [ "serve", "-s", "dist", "-l", "5000" ]