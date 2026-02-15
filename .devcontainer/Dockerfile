FROM node:20

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    zsh \
    fzf \
    sudo \
    iptables \
    ipset \
    iproute2 \
    dnsutils \
    jq \
    vim \
    curl \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Bun
RUN curl -fsSL https://bun.sh/install | bash
ENV BUN_INSTALL="/root/.bun"
ENV PATH="$BUN_INSTALL/bin:$PATH"

# Create non-root node user with sudo access
RUN usermod -aG sudo node \
    && echo "node ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/node \
    && chmod 0440 /etc/sudoers.d/node

# Set up zsh for node user with oh-my-zsh-like features using zsh-in-docker
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/deluan/zsh-in-docker/master/zsh-in-docker.sh)" -- \
    -p git \
    -p fzf \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions \
    -p https://github.com/zsh-users/zsh-syntax-highlighting \
    -a 'export BUN_INSTALL="/home/node/.bun"' \
    -a 'export PATH="$BUN_INSTALL/bin:$PATH"' \
    -a 'export PATH="$PATH:/workspace/node_modules/.bin"'

# Copy bun to node user's home
RUN mkdir -p /home/node/.bun \
    && cp -r /root/.bun/* /home/node/.bun/ \
    && chown -R node:node /home/node/.bun

# Set zsh as default shell
RUN chsh -s /bin/zsh node

# Create workspace directory
RUN mkdir -p /workspace && chown -R node:node /workspace

# Switch to node user
USER node

# Set working directory
WORKDIR /workspace

# Expose default Astro port
EXPOSE 4321

# Default command
CMD ["zsh"]
