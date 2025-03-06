# Puppet manifest to increase file descriptor limit for holberton user
exec { 'set_holberton_limits':
  command => "printf 'holberton soft nofile 4096\\nholberton hard nofile 4096\\n' >> /etc/security/limits.conf",
  path    => '/bin:/usr/bin',
  unless  => "grep -q 'holberton.*nofile.*4096' /etc/security/limits.conf",
}
