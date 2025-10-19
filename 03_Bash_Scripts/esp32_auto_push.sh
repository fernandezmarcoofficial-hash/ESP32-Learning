#!/bin/bash
LOGFILE=/home/mafeinnvions/ESP32-Learning/04_Logs/esp32_log_$(date +%Y-%m-%d).md
echo "## Auto ESP32 Commit — $(date)" >> $LOGFILE

cd /home/mafeinnvions/ESP32-Learning/01_Projects
git add .
git commit -m "Auto-update ESP32 experiments $(date)" || echo "No changes to commit"
git push
