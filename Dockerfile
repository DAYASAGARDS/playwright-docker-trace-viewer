FROM node:18-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone the Playwright repository
RUN git clone https://github.com/microsoft/playwright .

# Install dependencies and build the project
RUN npm ci && \
    npm run build

# Install browser dependencies and Chromium
RUN npx playwright install-deps && \
    npx playwright install chromium

# Expose the port
EXPOSE 8080

# Command to run the trace viewer server
CMD ["npx", "playwright", "show-trace", "--port=8080", "--host=0.0.0.0"]
