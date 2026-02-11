#!/bin/bash
# ============================================
# WordPress Security Hardening Script
# Run inside the WordPress container via Coolify Terminal
# ============================================

echo "========================================="
echo "  WordPress Security - Starting..."
echo "========================================="

# Install WP-CLI if not present
if ! command -v wp &> /dev/null; then
    echo "[1/8] Installing WP-CLI..."
    curl -sO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
else
    echo "[1/8] WP-CLI already installed."
fi

# ---- 1. Install Security Plugin (Wordfence) ----
echo "[2/8] Installing Wordfence Security plugin..."
wp plugin install wordfence --activate --allow-root

# ---- 2. Disable XML-RPC ----
echo "[3/8] Blocking XML-RPC..."
cat >> /var/www/html/.htaccess << 'HTEOF'

# Block XML-RPC
<Files xmlrpc.php>
    Order Deny,Allow
    Deny from all
</Files>
HTEOF
echo "XML-RPC blocked."

# ---- 3. Hide WordPress Version ----
echo "[4/8] Hiding WordPress version..."
wp eval '
add_filter("the_generator", function() { return ""; });
' --allow-root 2>/dev/null

# Create a must-use plugin for persistent security settings
mkdir -p /var/www/html/wp-content/mu-plugins
cat > /var/www/html/wp-content/mu-plugins/security-hardening.php << 'PHPEOF'
<?php
/**
 * Security Hardening - Must Use Plugin
 * EV Car Demo
 */

// Remove WordPress version from head
remove_action('wp_head', 'wp_generator');

// Disable XML-RPC
add_filter('xmlrpc_enabled', '__return_false');

// Remove RSD link
remove_action('wp_head', 'rsd_link');

// Remove Windows Live Writer manifest
remove_action('wp_head', 'wlwmanifest_link');

// Remove shortlink
remove_action('wp_head', 'wp_shortlink_wp_head');

// Disable file editing from admin panel
if (!defined('DISALLOW_FILE_EDIT')) {
    define('DISALLOW_FILE_EDIT', true);
}

// Security headers
add_action('send_headers', function() {
    header('X-Content-Type-Options: nosniff');
    header('X-Frame-Options: SAMEORIGIN');
    header('X-XSS-Protection: 1; mode=block');
    header('Referrer-Policy: strict-origin-when-cross-origin');
    header('Permissions-Policy: camera=(), microphone=(), geolocation=()');
});

// Disable author archives (prevents username enumeration)
add_action('template_redirect', function() {
    if (is_author()) {
        wp_redirect(home_url(), 301);
        exit;
    }
});

// Limit login attempts message (don't reveal if username exists)
add_filter('login_errors', function() {
    return 'Invalid login credentials. Please try again.';
});

// Disable REST API user enumeration for non-logged-in users
add_filter('rest_endpoints', function($endpoints) {
    if (!is_user_logged_in()) {
        if (isset($endpoints['/wp/v2/users'])) {
            unset($endpoints['/wp/v2/users']);
        }
        if (isset($endpoints['/wp/v2/users/(?P<id>[\d]+)'])) {
            unset($endpoints['/wp/v2/users/(?P<id>[\d]+)']);
        }
    }
    return $endpoints;
});
PHPEOF
chown www-data:www-data /var/www/html/wp-content/mu-plugins/security-hardening.php
echo "Security plugin created."

# ---- 4. Harden wp-config.php ----
echo "[5/8] Hardening wp-config.php..."

# Add security constants if not already present
if ! grep -q "DISALLOW_FILE_EDIT" /var/www/html/wp-config.php; then
    sed -i "/\/\* That's all, stop editing/i\\
/** Security Hardening */\\
define('DISALLOW_FILE_EDIT', true);\\
define('DISALLOW_FILE_MODS', false);\\
define('FORCE_SSL_ADMIN', false);\\
define('WP_AUTO_UPDATE_CORE', 'minor');\\
" /var/www/html/wp-config.php
    echo "wp-config.php hardened."
else
    echo "wp-config.php already hardened."
fi

# ---- 5. Set Proper File Permissions ----
echo "[6/8] Setting file permissions..."
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;
chmod 440 /var/www/html/wp-config.php
chown -R www-data:www-data /var/www/html
echo "File permissions set (dirs:755, files:644, wp-config:440)."

# ---- 6. Protect wp-includes ----
echo "[7/8] Protecting sensitive directories..."

# Block direct access to wp-includes
if ! grep -q "wp-includes" /var/www/html/.htaccess 2>/dev/null; then
    cat >> /var/www/html/.htaccess << 'HTEOF2'

# Block access to wp-includes
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteBase /
    RewriteRule ^wp-admin/includes/ - [F,L]
    RewriteRule !^wp-includes/ - [S=3]
    RewriteRule ^wp-includes/[^/]+\.php$ - [F,L]
    RewriteRule ^wp-includes/js/tinymce/langs/.+\.php - [F,L]
    RewriteRule ^wp-includes/theme-compat/ - [F,L]
</IfModule>

# Protect .htaccess itself
<Files .htaccess>
    Order Allow,Deny
    Deny from all
</Files>

# Block access to sensitive files
<FilesMatch "^(wp-config\.php|readme\.html|license\.txt)$">
    Order Allow,Deny
    Deny from all
</FilesMatch>
HTEOF2
fi
echo "Sensitive directories protected."

# ---- 7. Disable Directory Browsing ----
echo "[8/8] Disabling directory browsing..."
if ! grep -q "Options -Indexes" /var/www/html/.htaccess; then
    echo "Options -Indexes" >> /var/www/html/.htaccess
fi

echo ""
echo "========================================="
echo "  WordPress Security - COMPLETE!"
echo "========================================="
echo ""
echo "  SUMMARY:"
echo "  [OK] Wordfence Security plugin installed"
echo "  [OK] XML-RPC disabled"
echo "  [OK] WordPress version hidden"
echo "  [OK] Security headers added (X-Frame, XSS, etc.)"
echo "  [OK] Username enumeration blocked"
echo "  [OK] REST API user listing disabled"
echo "  [OK] Login error messages sanitized"
echo "  [OK] wp-config.php hardened"
echo "  [OK] File editing from admin disabled"
echo "  [OK] File permissions secured"
echo "  [OK] wp-includes protected"
echo "  [OK] Directory browsing disabled"
echo "  [OK] Sensitive files blocked"
echo ""
echo "  MANUAL STEPS REMAINING:"
echo "  1. In wp-admin > Wordfence > enable firewall"
echo "  2. In wp-admin > Wordfence > enable brute force protection"
echo "  3. Enable 2FA in Wordfence for admin account"
echo "  4. Set up Coolify 2FA in Settings"
echo "========================================="