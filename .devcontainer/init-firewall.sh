#!/bin/bash

# Personal Website DevContainer Firewall Script
# This script sets up basic firewall rules for development

set -e

echo "Setting up firewall rules..."

# Check if running as root or with sudo
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root or with sudo"
    exit 1
fi

# Flush existing rules
iptables -F
iptables -X

# Set default policies
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow loopback traffic
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow established and related connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow SSH (important for devcontainer)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow DNS
iptables -A INPUT -p udp --sport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp --sport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT

# Allow HTTP/HTTPS (npm, git, general web)
iptables -A INPUT -p tcp --sport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --sport 443 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT

# Allow GitHub services (HTTPS)
iptables -A OUTPUT -p tcp -d github.com --dport 443 -j ACCEPT
iptables -A OUTPUT -p tcp -d api.github.com --dport 443 -j ACCEPT
iptables -A OUTPUT -p tcp -d raw.githubusercontent.com --dport 443 -j ACCEPT

# Allow npm registry
iptables -A OUTPUT -p tcp -d registry.npmjs.org --dport 443 -j ACCEPT
iptables -A OUTPUT -p tcp -d registry.npmjs.org --dport 80 -j ACCEPT

# Allow Cloudflare Pages (for deployment)
iptables -A OUTPUT -p tcp -d *.pages.dev --dport 443 -j ACCEPT
iptables -A OUTPUT -p tcp -d api.cloudflare.com --dport 443 -j ACCEPT

# Allow Bun registry
iptables -A OUTPUT -p tcp -d registry.bun.sh --dport 443 -j ACCEPT

# Allow Astro dev server (4321) from localhost
iptables -A INPUT -p tcp -s 127.0.0.1 --dport 4321 -j ACCEPT
iptables -A INPUT -p tcp -s 172.0.0.0/8 --dport 4321 -j ACCEPT

# Allow common development ports
iptables -A INPUT -p tcp --dport 3000:3010 -j ACCEPT
iptables -A INPUT -p tcp --dport 8000:8010 -j ACCEPT
iptables -A INPUT -p tcp --dport 9000:9010 -j ACCEPT

# ICMP (ping)
iptables -A INPUT -p icmp -j ACCEPT
iptables -A OUTPUT -p icmp -j ACCEPT

# Log dropped packets (optional, for debugging)
# iptables -A INPUT -j LOG --log-prefix "IPTABLES-DROP-INPUT: "
# iptables -A OUTPUT -j LOG --log-prefix "IPTABLES-DROP-OUTPUT: "

echo "Firewall rules applied successfully!"
echo ""
echo "Allowed services:"
echo "  - Loopback/localhost"
echo "  - DNS (UDP/TCP 53)"
echo "  - HTTP/HTTPS (80/443)"
echo "  - SSH (22)"
echo "  - GitHub services"
echo "  - npm registry"
echo "  - Cloudflare Pages/API"
echo "  - Bun registry"
echo "  - Development ports (3000-3010, 4321, 8000-8010, 9000-9010)"
echo ""

# Save rules if iptables-persistent is installed
if command -v netfilter-persistent &> /dev/null; then
    netfilter-persistent save
    echo "Rules saved with iptables-persistent"
fi

echo "Firewall configuration complete!"
