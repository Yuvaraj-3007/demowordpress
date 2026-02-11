#!/bin/bash
# ============================================
# VPS Security Hardening Script
# For: Contabo VPS 75.119.142.251
# ============================================

echo "========================================="
echo "  VPS Security Hardening - Starting..."
echo "========================================="

# ---- 1. UPDATE SYSTEM ----
echo ""
echo "[1/7] Updating system packages..."
apt update && apt upgrade -y

# ---- 2. CREATE NON-ROOT USER ----
echo ""
echo "[2/7] Creating non-root user 'yuvaraj'..."
if id "yuvaraj" &>/dev/null; then
    echo "User 'yuvaraj' already exists. Skipping."
else
    adduser --gecos "" yuvaraj
    usermod -aG sudo yuvaraj
    echo "User 'yuvaraj' created with sudo access."
fi

# ---- 3. FIREWALL (UFW) ----
echo ""
echo "[3/7] Setting up UFW Firewall..."
apt install ufw -y
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp comment 'SSH'
ufw allow 80/tcp comment 'HTTP'
ufw allow 443/tcp comment 'HTTPS'
ufw allow 8000/tcp comment 'Coolify Dashboard'
echo "y" | ufw enable
ufw status verbose
echo "Firewall configured: Only ports 22, 80, 443, 8000 are open."

# ---- 4. FAIL2BAN ----
echo ""
echo "[4/7] Installing and configuring Fail2Ban..."
apt install fail2ban -y

cat > /etc/fail2ban/jail.local << 'JAILEOF'
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 5
banaction = ufw

[sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 7200
JAILEOF

systemctl enable fail2ban
systemctl restart fail2ban
echo "Fail2Ban configured: 3 failed SSH attempts = 2 hour ban."

# ---- 5. SSH HARDENING ----
echo ""
echo "[5/7] Hardening SSH configuration..."

# Backup original config
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

# Disable root login
sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

# Disable password auth for root (keep password auth for yuvaraj until SSH keys are set)
sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Disable empty passwords
sed -i 's/^#*PermitEmptyPasswords.*/PermitEmptyPasswords no/' /etc/ssh/sshd_config

# Limit max auth tries
sed -i 's/^#*MaxAuthTries.*/MaxAuthTries 3/' /etc/ssh/sshd_config

# Disable X11 forwarding
sed -i 's/^#*X11Forwarding.*/X11Forwarding no/' /etc/ssh/sshd_config

# Set login grace time
sed -i 's/^#*LoginGraceTime.*/LoginGraceTime 60/' /etc/ssh/sshd_config

systemctl restart sshd
echo "SSH hardened: Root login disabled, max 3 auth tries."
echo ""
echo "!!! IMPORTANT: Before closing this session, open a NEW terminal"
echo "!!! and test: ssh yuvaraj@75.119.142.251"
echo "!!! If that works, root login is safely disabled."

# ---- 6. AUTO SECURITY UPDATES ----
echo ""
echo "[6/7] Enabling automatic security updates..."
apt install unattended-upgrades -y
dpkg-reconfigure -plow unattended-upgrades

# ---- 7. ADDITIONAL HARDENING ----
echo ""
echo "[7/7] Additional hardening..."

# Disable unused network protocols
echo "net.ipv4.conf.all.rp_filter = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.rp_filter = 1" >> /etc/sysctl.conf
echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
sysctl -p

echo ""
echo "========================================="
echo "  VPS Security Hardening - COMPLETE!"
echo "========================================="
echo ""
echo "  SUMMARY:"
echo "  [OK] System updated"
echo "  [OK] Non-root user 'yuvaraj' created"
echo "  [OK] UFW Firewall: ports 22, 80, 443, 8000"
echo "  [OK] Fail2Ban: 3 failed SSH = 2hr ban"
echo "  [OK] SSH: Root login disabled, max 3 tries"
echo "  [OK] Auto security updates enabled"
echo "  [OK] Network hardening applied"
echo ""
echo "  NEXT STEPS:"
echo "  1. Test SSH with: ssh yuvaraj@75.119.142.251"
echo "  2. Set up SSH keys (optional but recommended)"
echo "  3. Run wordpress-security.sh for WordPress hardening"
echo "========================================="