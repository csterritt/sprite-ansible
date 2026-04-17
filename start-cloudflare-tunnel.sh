#!/usr/bin/bash

# Load environment variables
source /home/ubuntu/scripts/.env

# Start Cloudflare tunnel
/home/linuxbrew/.linuxbrew/bin/cloudflared tunnel run --token $CLOUDFLARE_TUNNEL_TOKEN
