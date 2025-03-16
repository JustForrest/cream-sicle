FROM mcr.microsoft.com/devcontainers/javascript-node:1-22-bookworm

# Set environment variables
ENV NODE_ENV=development

# Install additional global packages
RUN npm install -g next@latest

# Install Supabase CLI
RUN curl -fsSL https://github.com/supabase/cli/releases/download/v1.115.5/supabase_1.115.5_linux_amd64.deb -o supabase.deb \
    && dpkg -i supabase.deb \
    && rm supabase.deb

# Configure ZSH (don't reinstall since it's already in the base image)
RUN if [ -d "/root/.oh-my-zsh" ]; then \
    echo "Oh My Zsh is already installed, configuring..." \
    && echo 'export PATH=$PATH:/workspaces/cream-sicle/node_modules/.bin' >> ~/.zshrc; \
    fi