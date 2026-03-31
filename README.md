# 🔒 Cloud-Based SIEM Implementation with Wazuh on AWS

> **Enterprise Security Monitoring System | Automated Threat Detection | Real-Time Attack Analysis**

[![AWS](https://img.shields.io/badge/AWS-EC2-orange?logo=amazon-aws)](https://aws.amazon.com)
[![Wazuh](https://img.shields.io/badge/Wazuh-4.10.3-blue?logo=wazuh)](https://wazuh.com)
[![Security](https://img.shields.io/badge/Security-SIEM-red?logo=security)](https://github.com/Neeraj829784/wazuh-aws-siem-project)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Architecture](#-architecture)
- [Key Features](#-key-features)
- [Technologies Used](#-technologies-used)
- [Security Events Detected](#-security-events-detected)
- [Installation Guide](#-installation-guide)
- [Attack Simulation](#-attack-simulation)
- [Cost Analysis](#-cost-analysis)
- [Skills Demonstrated](#-skills-demonstrated)
- [Future Enhancements](#-future-enhancements)
- [Screenshots](#-screenshots)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🎯 Overview

This project demonstrates the deployment and operation of a **production-grade SIEM (Security Information and Event Management)** system using **Wazuh** on **AWS infrastructure**. The implementation showcases real-world security monitoring capabilities, including automated threat detection, compliance scanning, and active attack simulation.

### Project Highlights

- ✅ **Full-Stack SIEM Deployment** - Complete Wazuh installation with Manager, Indexer, and Dashboard
- ✅ **Multi-Agent Architecture** - Centralized monitoring of distributed endpoints
- ✅ **Real Attack Detection** - Live demonstration of SSH brute force, port scanning, and privilege escalation attempts
- ✅ **Compliance Monitoring** - Automated CIS benchmark scanning with security posture assessment
- ✅ **Cloud-Native Design** - Optimized AWS infrastructure with cost-efficient resource allocation
- ✅ **Automated Deployment** - Scripted installation and configuration for rapid deployment
- ✅ **MITRE ATT&CK Mapping** - Threat detection aligned with industry-standard frameworks

---

## 🏗️ Architecture

### System Design

```
┌─────────────────────────────────────────────────────────────┐
│                    AWS VPC (Private Network)                │
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              Wazuh Manager (t3.xlarge)               │  │
│  │  ┌────────────────────────────────────────────┐     │  │
│  │  │  Wazuh Manager   │  OpenSearch Indexer    │     │  │
│  │  │  - Log Analysis  │  - Data Storage        │     │  │
│  │  │  - Rule Engine   │  - Search Engine       │     │  │
│  │  │  - API Server    │  - Analytics           │     │  │
│  │  └────────────────────────────────────────────┘     │  │
│  │  ┌────────────────────────────────────────────┐     │  │
│  │  │         Wazuh Dashboard (Web UI)           │     │  │
│  │  │  - Real-time Alerts                        │     │  │
│  │  │  - Security Analytics                      │     │  │
│  │  │  - Compliance Reports                      │     │  │
│  │  └────────────────────────────────────────────┘     │  │
│  │                                                      │  │
│  │  Private IP: 172.31.x.x                             │  │
│  │  Public IP: <ELASTIC_IP>                            │  │
│  │  Storage: 30GB GP3 SSD                              │  │
│  └──────────────────────────────────────────────────────┘  │
│                            │                                │
│                            │ Port 1514/1515 (Agent Comm)   │
│                            │                                │
│  ┌─────────────────────────┴──────────────┐                │
│  │                                        │                │
│  │  ┌──────────────────┐   ┌─────────────┴──────┐        │
│  │  │  Wazuh Agent 1   │   │  Attack Instance   │        │
│  │  │  (t3.micro)      │   │  (t3.micro)        │        │
│  │  │                  │   │                    │        │
│  │  │  - File Monitor  │   │  - Nmap Scanner    │        │
│  │  │  - Log Collector │   │  - Hydra (SSH)     │        │
│  │  │  - Rootkit Check │   │  - Attack Tools    │        │
│  │  │                  │   │                    │        │
│  │  │  Private IP:     │   │  Private IP:       │        │
│  │  │  172.31.x.x      │   │  172.31.x.x        │        │
│  │  └──────────────────┘   └────────────────────┘        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ HTTPS (443)
                            ▼
                    Security Analyst
                   (Dashboard Access)
```

### Infrastructure Components

| Component | Instance Type | vCPUs | RAM | Storage | Purpose |
|-----------|--------------|-------|-----|---------|---------|
| **Wazuh Manager** | t3.xlarge | 4 | 16GB | 30GB GP3 | Central SIEM server with manager, indexer, and dashboard |
| **Wazuh Agent** | t3.micro | 2 | 1GB | 20GB GP3 | Monitored endpoint with security agent |
| **Attack Simulator** | t3.micro | 2 | 1GB | 20GB GP3 | Penetration testing tools for attack simulation |

### Network Configuration

- **VPC CIDR:** 172.31.0.0/16 (AWS Default VPC)
- **Communication:** Private IPs for agent-manager communication (secure, fast, cost-free)
- **Public Access:** Elastic IP on manager for dashboard access
- **Security Groups:** 
  - Manager: Ports 22, 443, 1514, 1515, 55000
  - Agent: SSH (22) + outbound to manager
  - Attacker: SSH (22) + outbound for attack simulation

---

## ✨ Key Features

### 🛡️ Security Monitoring

- **Real-Time Threat Detection**
  - SSH brute force attempts
  - Failed authentication tracking
  - Invalid user login detection
  - Privilege escalation attempts
  - Suspicious process execution

- **File Integrity Monitoring (FIM)**
  - Critical system directories: `/etc`, `/bin`, `/usr/bin`, `/sbin`
  - Real-time change detection
  - Configuration file monitoring
  - Unauthorized modification alerts

- **Log Analysis**
  - System logs (syslog, auth.log)
  - Security events correlation
  - Anomaly detection
  - Multi-source log aggregation

### 📊 Compliance & Reporting

- **CIS Benchmark Scanning**
  - Automated security configuration assessment
  - 182 security checks across Ubuntu systems
  - Compliance scoring and remediation guidance
  - Industry-standard security baselines

- **MITRE ATT&CK Framework**
  - Attack technique mapping (T1110.001, T1021.004)
  - Tactic identification (Credential Access, Lateral Movement)
  - Threat intelligence integration
  - Security posture visualization

### 🔄 Automation & Integration

- **Auto-Start Configuration**
  - Systemd service management
  - Automatic restart on failure
  - Boot-time initialization
  - Service dependency management

- **API Integration Ready**
  - RESTful API for external tools
  - n8n workflow automation support
  - Authentication token system
  - Programmatic alert retrieval

---

## 🛠️ Technologies Used

### Core Technologies

- **Wazuh 4.10.3** - Open-source SIEM platform
- **OpenSearch** - Data storage and search engine
- **Amazon Web Services (AWS)** - Cloud infrastructure provider
- **Ubuntu 22.04 LTS / 24.04 LTS** - Operating system
- **Systemd** - Service management

### Security Tools

- **Nmap** - Network scanning and port discovery
- **Hydra** - SSH brute force simulation
- **Hping3** - Network stress testing
- **Custom Attack Scripts** - Bash-based attack automation

### Infrastructure as Code

- **AWS CLI** - Infrastructure automation
- **Bash Scripting** - Deployment automation
- **Git** - Version control

---

## 🎯 Security Events Detected

### Attack Scenarios Demonstrated

#### 1. **SSH Brute Force Attack**
- **Description:** Multiple failed login attempts from attacker instance
- **Detection Rule:** Wazuh Rule 5710 & 5712 (Level 5 & 10)
- **MITRE Technique:** T1110.001 (Password Guessing)
- **Evidence:** 25+ invalid user attempts detected and logged
- **Alert Severity:** High (Level 10 - Brute Force)

```
Rule 5712: SSH brute force trying to get access to the system
Source IP: 172.31.x.x (Attacker Instance)
Failed Attempts: fakeuser1-10, admin, root, test, hacker
Action: Alert generated, IP logged, incident recorded
```

#### 2. **Port Scanning Detection**
- **Description:** Network reconnaissance using nmap
- **Detection Method:** Multiple connection attempts to filtered ports
- **Scan Range:** Ports 1-1000, service detection on 22/80/443/1514
- **Evidence:** Network traffic patterns indicating reconnaissance activity

#### 3. **Invalid User Login Attempts**
- **Description:** Authentication attempts with non-existent usernames
- **Detection Rule:** Wazuh Rule 5710 (Level 5)
- **MITRE Technique:** T1110.001 (Password Guessing), T1021.004 (SSH)
- **Compliance:** PCI-DSS 10.2.4, 10.2.5, HIPAA 164.312.b, GDPR IV_35.7.d

#### 4. **Privilege Escalation Monitoring**
- **Description:** Unauthorized sudo attempts
- **Detection Rule:** Wazuh Rule 5405 (Level 5)
- **Evidence:** Failed sudo execution by non-privileged users
- **Alert:** Real-time notification of suspicious privilege requests

### Compliance Findings

#### CIS Ubuntu 22.04 Benchmark Results
- **Total Checks:** 182 security controls
- **Passed:** 75 checks (41%)
- **Failed:** 105 checks
- **Invalid:** 2 checks
- **Score:** 41% (Baseline security posture)

**Key Findings:**
- Password policy weaknesses
- Missing security patches
- Firewall configuration gaps
- File permission issues
- Audit logging deficiencies

---

## 📥 Installation Guide

### Prerequisites

- AWS Account with EC2 access
- SSH key pair configured
- Basic understanding of Linux and AWS
- 30GB+ free storage for manager instance

### Quick Start

#### Step 1: Launch AWS Instances

```bash
# Set your AWS region
export AWS_DEFAULT_REGION=eu-north-1

# Launch Wazuh Manager (t3.xlarge, 30GB storage)
aws ec2 run-instances \
  --image-id <UBUNTU_24.04_AMI> \
  --instance-type t3.xlarge \
  --key-name <YOUR_KEY_NAME> \
  --security-group-ids <MANAGER_SG> \
  --block-device-mappings '[{"DeviceName":"/dev/sda1","Ebs":{"VolumeSize":30,"VolumeType":"gp3"}}]' \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=wazuh-manager}]'

# Launch Wazuh Agent (t3.micro, 20GB storage)
aws ec2 run-instances \
  --image-id <UBUNTU_22.04_AMI> \
  --instance-type t3.micro \
  --key-name <YOUR_KEY_NAME> \
  --security-group-ids <AGENT_SG> \
  --block-device-mappings '[{"DeviceName":"/dev/sda1","Ebs":{"VolumeSize":20,"VolumeType":"gp3"}}]' \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=wazuh-agent-1}]'
```

#### Step 2: Install Wazuh Manager

```bash
# SSH into manager instance
ssh -i <YOUR_KEY>.pem ubuntu@<MANAGER_PUBLIC_IP>

# Download and run Wazuh installer
curl -sO https://packages.wazuh.com/4.10/wazuh-install.sh
sudo bash ./wazuh-install.sh -a

# Save the credentials displayed at the end
# Dashboard: https://<MANAGER_PUBLIC_IP>
# Username: admin
# Password: <GENERATED_PASSWORD>
```

#### Step 3: Install Wazuh Agent

```bash
# SSH into agent instance
ssh -i <YOUR_KEY>.pem ubuntu@<AGENT_PUBLIC_IP>

# Add Wazuh repository
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | sudo gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import
sudo chmod 644 /usr/share/keyrings/wazuh.gpg
echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | sudo tee -a /etc/apt/sources.list.d/wazuh.list
sudo apt-get update

# Install agent with manager IP
sudo WAZUH_MANAGER='<MANAGER_PRIVATE_IP>' apt-get install wazuh-agent=4.10.3-* -y

# Start agent service
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
```

#### Step 4: Configure Auto-Start

```bash
# On Manager: Configure service dependencies
sudo mkdir -p /etc/systemd/system/wazuh-manager.service.d
sudo tee /etc/systemd/system/wazuh-manager.service.d/override.conf > /dev/null <<EOF
[Unit]
After=wazuh-indexer.service
Wants=wazuh-indexer.service

[Service]
Restart=on-failure
RestartSec=5s
EOF

sudo systemctl daemon-reload

# On Agent: Configure network dependency
sudo mkdir -p /etc/systemd/system/wazuh-agent.service.d
sudo tee /etc/systemd/system/wazuh-agent.service.d/override.conf > /dev/null <<EOF
[Service]
Restart=on-failure
RestartSec=10s

[Unit]
After=network-online.target
Wants=network-online.target
EOF

sudo systemctl daemon-reload
```

#### Step 5: Verify Installation

```bash
# Check manager services
sudo systemctl status wazuh-manager wazuh-indexer wazuh-dashboard

# Check agent status
sudo systemctl status wazuh-agent

# List registered agents (on manager)
sudo /var/ossec/bin/manage_agents -l
```

---

## ⚔️ Attack Simulation

### Setting Up Attack Environment

#### Launch Attack Instance

```bash
# Create attacker instance with Kali tools
aws ec2 run-instances \
  --image-id <UBUNTU_22.04_AMI> \
  --instance-type t3.micro \
  --key-name <YOUR_KEY_NAME> \
  --security-group-ids <ATTACKER_SG> \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=wazuh-attacker}]'

# SSH into attacker instance
ssh -i <YOUR_KEY>.pem ubuntu@<ATTACKER_PUBLIC_IP>

# Install attack tools
sudo apt update
sudo apt install -y nmap hydra hping3
```

#### Attack Script

Create `/tmp/attack-agent.sh`:

```bash
#!/bin/bash

TARGET_IP="<AGENT_PRIVATE_IP>"

echo "=== Wazuh Attack Simulation ==="
echo "Target: $TARGET_IP"

# 1. Port Scanning
echo "[1/4] Port Scanning..."
nmap -sS -p 1-1000 $TARGET_IP -T4

# 2. SSH Brute Force
echo "[2/4] SSH Brute Force..."
for user in admin root test hacker; do
  for pass in password 123456 admin; do
    sshpass -p "$pass" ssh -o ConnectTimeout=2 \
      -o StrictHostKeyChecking=no $user@$TARGET_IP 2>/dev/null
  done
done

# 3. Invalid User Attempts
echo "[3/4] Invalid User Attempts..."
for i in {1..10}; do
  ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no \
    fakeuser$i@$TARGET_IP 2>/dev/null
  sleep 1
done

# 4. Service Detection
echo "[4/4] Service Detection..."
nmap -sV -p 22 $TARGET_IP

echo "✅ Attack simulation complete!"
echo "Check Wazuh Dashboard for alerts"
```

#### Run Attack

```bash
chmod +x /tmp/attack-agent.sh
sudo bash /tmp/attack-agent.sh
```

### Expected Detection Results

Within 1-2 minutes, Wazuh Dashboard will show:

- ✅ **Rule 5710 alerts** - Invalid user login attempts (Level 5)
- ✅ **Rule 5712 alerts** - SSH brute force detection (Level 10)
- ✅ **MITRE ATT&CK mapping** - T1110.001 (Password Guessing)
- ✅ **Source IP tracking** - All attacks correlated to attacker IP
- ✅ **Compliance violations** - PCI-DSS, HIPAA, GDPR mappings

---

## 💰 Cost Analysis

### Monthly Cost Breakdown (eu-north-1)

#### When Instances Are Running 24/7

| Resource | Specification | Hourly Cost | Monthly Cost |
|----------|--------------|-------------|--------------|
| Wazuh Manager | t3.xlarge (4 vCPU, 16GB) | $0.1664 | ~$120.00 |
| Wazuh Agent | t3.micro (2 vCPU, 1GB) | $0.0104 | ~$7.50 |
| Attacker Instance | t3.micro (2 vCPU, 1GB) | $0.0104 | ~$7.50 |
| EBS Storage | 70GB GP3 ($0.08/GB) | - | ~$5.60 |
| Elastic IP | 1 IP (attached) | Free | $0.00 |
| **Total (Running)** | | | **~$140.60/month** |

#### When Instances Are Stopped

| Resource | Cost |
|----------|------|
| EBS Storage (Manager 30GB) | $2.40/month |
| EBS Storage (Agent 20GB) | $1.60/month |
| EBS Storage (Attacker 20GB) | $1.60/month |
| Elastic IP (unattached) | $3.60/month |
| **Total (Stopped)** | **~$9.20/month** |

### Cost Optimization Strategies

1. **Use for Learning/Demo Only** (~$5-10 total)
   - Launch instances when needed
   - Run for 5-10 hours total
   - Terminate after documentation
   - Keep automation scripts for quick recreation

2. **Scheduled Operations** (~$20-30/month)
   - Use Lambda to start/stop instances on schedule
   - Run only during working hours (8 hours/day)
   - Reduces cost by ~70%

3. **Spot Instances** (up to 90% savings)
   - Use spot instances for agent and attacker
   - Manager stays on-demand for stability
   - Potential savings: ~$100/month

4. **Instance Right-Sizing**
   - Manager reduced from 100GB → 30GB: Saves $3.20/month
   - Consider t3a instances: Additional 10% savings

### Project Cost Summary

**Recommended Approach:**
- **Setup Phase:** Launch instances for 5-10 hours
- **Total Cost:** ~$5-10
- **Documentation:** Screenshots, scripts, architecture diagrams
- **Post-Demo:** Terminate all resources → $0/month ongoing

**Result:** Professional portfolio project with minimal cost! 🎯

---

## 🎓 Skills Demonstrated

### Technical Competencies

#### Security Operations
- ✅ SIEM deployment and configuration (Wazuh)
- ✅ Log analysis and correlation
- ✅ Threat detection and incident response
- ✅ Security event monitoring
- ✅ Attack pattern recognition
- ✅ Compliance scanning (CIS Benchmarks)

#### Cloud Architecture
- ✅ AWS EC2 instance management
- ✅ VPC networking and security groups
- ✅ Elastic IP configuration
- ✅ EBS volume management
- ✅ Cost optimization strategies
- ✅ Multi-tier architecture design

#### Linux System Administration
- ✅ Ubuntu/Debian package management
- ✅ Systemd service configuration
- ✅ SSH hardening and management
- ✅ File integrity monitoring
- ✅ Log management and analysis
- ✅ User and permission management

#### DevOps & Automation
- ✅ Bash scripting for automation
- ✅ Infrastructure provisioning
- ✅ Configuration management
- ✅ Service orchestration
- ✅ Automated deployment pipelines
- ✅ Version control (Git)

#### Security Frameworks
- ✅ MITRE ATT&CK framework mapping
- ✅ CIS Benchmark compliance
- ✅ PCI-DSS controls (10.2.4, 10.2.5, 10.6.1)
- ✅ HIPAA security rules (164.312.b)
- ✅ GDPR data protection (IV_35.7.d, IV_32.2)
- ✅ NIST 800-53 (AU.14, AC.7, AU.6)

#### Penetration Testing
- ✅ Network reconnaissance (nmap)
- ✅ SSH brute force simulation (hydra)
- ✅ Attack scripting and automation
- ✅ Vulnerability assessment
- ✅ Attack lifecycle understanding

---

## 🚀 Future Enhancements

### Planned Features

#### Phase 1: Advanced Detection
- [ ] Custom detection rules for specific threats
- [ ] Machine learning-based anomaly detection
- [ ] Geolocation tracking for source IPs
- [ ] Threat intelligence feed integration

#### Phase 2: Automation & Integration
- [ ] n8n workflow automation
  - Automated alert notifications (Slack/Discord/Email)
  - Ticket creation in JIRA/ServiceNow
  - Threat intelligence enrichment
  - Automated incident response workflows
- [ ] Terraform infrastructure as code
- [ ] Ansible configuration management
- [ ] CI/CD pipeline for updates

#### Phase 3: Enhanced Security
- [ ] Multi-agent deployment (Windows, CentOS)
- [ ] Active response automation (IP blocking)
- [ ] Vulnerability scanning integration
- [ ] Container security monitoring (Docker/Kubernetes)
- [ ] Cloud-native security (AWS CloudTrail integration)

#### Phase 4: Visualization & Reporting
- [ ] Custom Grafana dashboards
- [ ] Automated compliance reports
- [ ] Executive summary generation
- [ ] SLA monitoring and alerting

---

## 📸 Screenshots

> **Note:** Screenshots will be added to showcase:
> - Wazuh Dashboard overview with active alerts
> - Security events timeline showing detected attacks
> - Agent management interface with connected endpoints
> - Attack detection details (SSH brute force, invalid users)
> - MITRE ATT&CK framework visualization
> - CIS compliance scanning results (41% baseline score)
> - Real-time alert correlation from attacker IP
> - File integrity monitoring dashboard
> - AWS infrastructure overview (3-instance architecture)

*Screenshots are being prepared and will be added to the `/screenshots` directory.*

---

## 📚 Documentation

Additional documentation available in the `/docs` folder:

- **Installation Guide** - Detailed step-by-step setup instructions
- **Configuration Guide** - Advanced Wazuh configuration options
- **Troubleshooting Guide** - Common issues and solutions
- **Attack Scenarios** - Detailed attack simulation procedures
- **API Integration** - n8n and external tool integration guide
- **Cost Optimization** - AWS cost reduction strategies

---

## 🤝 Contributing

This is a portfolio/demonstration project, but suggestions and improvements are welcome!

### How to Contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Open a Pull Request

### Areas for Contribution

- Additional attack scenarios and detection rules
- Multi-platform agent support (Windows, macOS)
- Alternative cloud provider guides (Azure, GCP)
- Enhanced automation scripts
- Documentation improvements

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **Wazuh Team** - For the excellent open-source SIEM platform
- **AWS** - For the free tier and educational resources
- **MITRE** - For the ATT&CK framework
- **CIS** - For security benchmarks
- **Security Community** - For continuous learning resources

---

## 📧 Contact

**Neeraj**
- GitHub: [@Neeraj829784](https://github.com/Neeraj829784)
- LinkedIn: [Connect with me](#) *(Add your LinkedIn URL)*
- Email: [Your professional email] *(Add your email)*

---

## ⭐ Project Status

**Status:** ✅ Complete and Documented

**Last Updated:** March 2026

**Version:** 1.0.0

---

<div align="center">

### 🔒 Built with Security in Mind | ☁️ Powered by AWS | 🛡️ Protected by Wazuh

**If you found this project helpful, please give it a ⭐!**

</div>
