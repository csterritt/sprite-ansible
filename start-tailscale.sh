#!/bin/bash
cd /commands
rm -f nohup.out
mkdir -p ts.state.dir
nohup tailscaled --state=tailscaled.state --statedir=ts.state.dir &
tailscale up
sleep 2
tailscale set --ssh
