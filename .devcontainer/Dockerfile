FROM mcr.microsoft.com/devcontainers/javascript-node:1-22-bookworm

# Set environment variables
ENV NODE_ENV=development

# Install additional global packages
RUN npm install -g next@latest

# Configure ZSH (don't reinstall since it's already in the base image)
RUN if [ -d "/root/.oh-my-zsh" ]; then \
    echo "Oh My Zsh is already installed, configuring..." \
    && echo 'export PATH=$PATH:$PWD/node_modules/.bin' >> ~/.zshrc; \
    fi

# Fix PATH configuration to use runtime path
RUN echo 'export PATH=$PATH:$(pwd)/node_modules/.bin' >> /home/node/.zshrc && \
    echo 'if [ -d "$PWD/node_modules/.bin" ]; then export PATH=$PATH:$PWD/node_modules/.bin; fi' >> /home/node/.zshrc