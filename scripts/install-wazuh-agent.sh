#!/bin/bash
#
# Wazuh Agent Installation Script
# Automated installation and configuration of Wazuh agent
#

set -e

echo "================================="
echo "  Wazuh Agent Installation"
echo "================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root or with sudo"
  exit 1
fi

# Get manager IP
if [ -z "$1" ]; then
  echo "❌ Usage: $0 <MANAGER_PRIVATE_IP>"
  echo "Example: $0 172.31.30.136"
  exit 1
fi

MANAGER_IP="$1"

echo "Manager IP: $MANAGER_IP"
echo ""

# Add Wazuh repository
echo "[1/5] Adding Wazuh repository..."
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import
chmod 644 /usr/share/keyrings/wazuh.gpg
echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list

# Update package list
echo "[2/5] Updating package list..."
apt-get update -qq

# Install Wazuh agent
echo "[3/5] Installing Wazuh agent..."
WAZUH_MANAGER="$MANAGER_IP" apt-get install wazuh-agent=4.10.3-* -y

# Configure auto-start
echo "[4/5] Configuring auto-start on boot..."
mkdir -p /etc/systemd/system/wazuh-agent.service.d
cat > /etc/systemd/system/wazuh-agent.service.d/override.conf <<EOF
[Service]
Restart=on-failure
RestartSec=10s

[Unit]
After=network-online.target
Wants=network-online.target
EOF

systemctl daemon-reload
systemctl enable wazuh-agent
systemctl start wazuh-agent

# Verify installation
echo "[5/5] Verifying agent status..."
sleep 5
systemctl is-active wazuh-agent

echo ""
echo "✅ Wazuh agent installation complete!"
echo ""
echo "📋 Agent Information:"
echo "==================="
echo "Manager IP: $MANAGER_IP"
echo "Agent Status: $(systemctl is-active wazuh-agent)"
echo ""
echo "Check logs: sudo tail -f /var/ossec/logs/ossec.log"
echo "Verify on manager: sudo /var/ossec/bin/manage_agents -l"
echo ""
