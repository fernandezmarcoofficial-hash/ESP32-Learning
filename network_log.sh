#!/bin/bash
# network_log.sh
# Logs network status to a daily Markdown file

# Create logs folder if it doesn't exist
LOG_DIR=~/Linux-System-Foundations/04_Logs
mkdir -p "$LOG_DIR"

# Generate filename with current date
LOG_FILE="$LOG_DIR/network_log_$(date +%F).md"

# Start logging
{
echo "## Network Log - $(date '+%Y-%m-%d %H:%M:%S')"
echo ""
echo "### Ping Test"
ping -c 4 8.8.8.8
echo ""
echo "### Network Interfaces"
ip addr show
echo ""
echo "### Routing Table"
ip route show
echo ""
echo "### DNS Resolution Test"
nslookup github.com
echo ""
echo "---"
} >> "$LOG_FILE"
