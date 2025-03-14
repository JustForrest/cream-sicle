FROM mcr.microsoft.com/devcontainers/javascript-node:1-22-bookworm

# Set environment variables
ENV NODE_ENV=development

# Install additional global packages
RUN npm install -g pnpm@latest next@latest

# Install Supabase CLI
RUN curl -fsSL https://github.com/supabase/cli/releases/download/v1.115.5/supabase_1.115.5_linux_amd64.deb -o supabase.deb \
    && dpkg -i supabase.deb \
    && rm supabase.deb

# Optional: Set up oh-my-zsh for a better terminal experience
RUN apt-get update && apt-get install -y zsh && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    chsh -s $(which zsh)