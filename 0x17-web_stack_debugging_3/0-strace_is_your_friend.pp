# Puppet manifest to fix Wordpress typo in wp-settings.php
exec { 'fix_wp_settings_typo':
  command => "sed -i 's|phpp|php|' /var/www/html/wp-settings.php",
  path    => '/bin:/usr/bin',
  unless  => "grep -q \"require_once( ABSPATH . WPINC . '/class-wp-locale.php' );\" /var/www/html/wp-settings.php"
}
