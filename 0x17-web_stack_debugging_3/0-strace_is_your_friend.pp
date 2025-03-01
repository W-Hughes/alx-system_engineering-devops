# 0-strace_is_your_friend.pp
# Fixes Apache 500 error by correcting typo in wp-settings.php

exec { 'fix-wp-settings-typo':
  command => "sed -i 's|class-wp-locale.phpp|class-wp-locale.php|g' /var/www/html/wp-settings.php",
  path    => ['/bin', '/usr/bin'],
  unless  => "grep 'class-wp-locale.php' /var/www/html/wp-settings.php", # run if and only if typo exists
  require => File['/var/www/html/wp-settings.php'],
  notify  => Service['apache2'],
}

file { '/var/www/html/wp-settings.php':
  ensure => file,
  owner  => 'www-data',
  group  => 'www-data',
  mode   => '0644',
  require => Package['apache2'],
}

service { 'apache2':
  ensure => running,
  enable => true,
}

package { 'apache2':
  ensure => installed,
}
