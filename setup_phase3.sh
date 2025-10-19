#!/bin/bash
# ========================================
# Phase 3: Programming + ESP32 Setup
# Author: Marco Fernandez
# ========================================

BASE=~/ESP32-Learning
SCRIPTS=$BASE/03_Bash_Scripts
LOGS=$BASE/04_Logs
PROJECTS=$BASE/01_Projects

# 1️⃣ Create folder structure
mkdir -p $SCRIPTS $LOGS $PROJECTS

# 2️⃣ Create sample ESP32 script (Blink LED)
BLINK_SCRIPT=$PROJECTS/blink_led.ino
cat << 'EOF' > $BLINK_SCRIPT
#include <Arduino.h>

void setup() {
  pinMode(2, OUTPUT);
}

void loop() {
  digitalWrite(2, HIGH);
  delay(500);
  digitalWrite(2, LOW);
  delay(500);
}
EOF

# 3️⃣ Create ESP32 experiment logger
EXPERIMENT_LOG=$LOGS/esp32_log_$(date +%Y-%m-%d).md
echo "## ESP32 Experiments — $(date)" >> $EXPERIMENT_LOG
echo "- Created sample Blink LED program" >> $EXPERIMENT_LOG

# 4️⃣ Create automation script for daily commit & push
AUTO_SCRIPT=$SCRIPTS/esp32_auto_push.sh
cat << EOF > $AUTO_SCRIPT
#!/bin/bash
LOGFILE=$LOGS/esp32_log_\$(date +%Y-%m-%d).md
echo "## Auto ESP32 Commit — \$(date)" >> \$LOGFILE

cd $PROJECTS
git add .
git commit -m "Auto-update ESP32 experiments \$(date)" || echo "No changes to commit"
git push
EOF

# 5️⃣ Make scripts executable
chmod +x $BLINK_SCRIPT $AUTO_SCRIPT

# 6️⃣ Setup cron job for daily automation at 11:00 AM
CRON_JOB="0 11 * * * $AUTO_SCRIPT"
(crontab -l 2>/dev/null | grep -v -F "$AUTO_SCRIPT" ; echo "$CRON_JOB") | crontab -

echo "✅ Phase 3 setup complete!"
echo "Sample ESP32 project: $BLINK_SCRIPT"
echo "Automation script: $AUTO_SCRIPT"
echo "Daily commit/push scheduled for 11:00 AM"

cd ~/Linux-System-Foundations
git add 05_Phase_Templates/phase_template.sh
git commit -m "Add reusable phase template script for future phases"
git push
