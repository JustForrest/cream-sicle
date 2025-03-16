FROM mcr.microsoft.com/devcontainers/javascript-node:0-18

# Set environment variables
ENV NODE_ENV=development

# Install common developer tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    curl \
    jq \
    bash-completion \
    git-lfs \
    vim \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Install global Node packages
RUN npm install -g npm@latest next@latest supabase@latest

# Pre-cache common Next.js dependencies to speed up first install
WORKDIR /tmp/cache
COPY package.json package-lock.json* ./
RUN npm ci || echo "Pre-install failed, will be handled during post-create"
RUN rm -rf /tmp/cache

# Configure ZSH (don't reinstall since it's already in the base image)
RUN if [ -d "/root/.oh-my-zsh" ]; then \
    echo "Oh My Zsh is already installed, configuring..." \
    && echo 'export PATH=$PATH:$PWD/node_modules/.bin' >> ~/.zshrc; \
    fi

# Fix PATH configuration to use runtime path
RUN echo 'export PATH=$PATH:$(pwd)/node_modules/.bin' >> /home/node/.zshrc && \
    echo 'if [ -d "$PWD/node_modules/.bin" ]; then export PATH=$PATH:$PWD/node_modules/.bin; fi' >> /home/node/.zshrc