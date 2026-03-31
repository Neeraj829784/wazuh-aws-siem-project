#!/bin/bash
#
# Wazuh Manager Installation Script
# Automated installation of Wazuh all-in-one (Manager + Indexer + Dashboard)
#

set -e

echo "================================="
echo "  Wazuh Manager Installation"
echo "================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root or with sudo"
  exit 1
fi

# Update system
echo "[1/5] Updating system packages..."
apt-get update -qq

# Download Wazuh installer
echo "[2/5] Downloading Wazuh installation script..."
curl -sO https://packages.wazuh.com/4.10/wazuh-install.sh
chmod +x wazuh-install.sh

# Install Wazuh (all-in-one)
echo "[3/5] Installing Wazuh Manager, Indexer, and Dashboard..."
echo "This may take 10-15 minutes..."
./wazuh-install.sh -a

# Configure auto-start
echo "[4/5] Configuring auto-start on boot..."
mkdir -p /etc/systemd/system/wazuh-manager.service.d
cat > /etc/systemd/system/wazuh-manager.service.d/override.conf <<EOF
[Unit]
After=wazuh-indexer.service
Wants=wazuh-indexer.service

[Service]
Restart=on-failure
RestartSec=5s
EOF

mkdir -p /etc/systemd/system/wazuh-dashboard.service.d
cat > /etc/systemd/system/wazuh-dashboard.service.d/override.conf <<EOF
[Unit]
After=wazuh-indexer.service wazuh-manager.service
Wants=wazuh-indexer.service wazuh-manager.service

[Service]
Restart=on-failure
RestartSec=10s
EOF

mkdir -p /etc/systemd/system/wazuh-indexer.service.d
cat > /etc/systemd/system/wazuh-indexer.service.d/override.conf <<EOF
[Service]
Restart=on-failure
RestartSec=5s
TimeoutStartSec=180
EOF

systemctl daemon-reload

# Verify installation
echo "[5/5] Verifying installation..."
sleep 5
systemctl is-active wazuh-manager wazuh-indexer wazuh-dashboard

echo ""
echo "✅ Wazuh Manager installation complete!"
echo ""
echo "📋 Important Information:"
echo "========================="
echo "Dashboard URL: https://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)"
echo "Credentials saved in: wazuh-install-files.tar"
echo ""
echo "To extract credentials:"
echo "  tar -xf wazuh-install-files.tar"
echo "  cat wazuh-install-files/wazuh-passwords.txt"
echo ""
echo "Next steps:"
echo "1. Save your credentials securely"
echo "2. Install agents on endpoints"
echo "3. Access dashboard to verify"
echo ""
