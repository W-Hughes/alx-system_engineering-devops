# Puppet manifest to fix Nginx for high request load by increasing file limits and connections
exec { 'set_nginx_limits':
  command => "echo 'nginx soft nofile 4096' >> /etc/security/limits.conf && echo 'nginx hard nofile 4096' >> /etc/security/limits.conf",
  path    => '/bin:/usr/bin',
  unless  => "grep -q 'nginx.*nofile.*4096' /etc/security/limits.conf",
  notify  => Exec['restart_nginx'],
}
exec { 'update_nginx_conf':
  command => "sed -i 's/768/2048/' -e 's/processes [0-9]*/processes 4/' /etc/nginx/nginx.conf",
  path    => '/bin:/usr/bin',
  unless  => "grep -q 'worker_connections 2048' /etc/nginx/nginx.conf",
  notify  => Exec['restart_nginx'],
}
exec { 'set_nginx_service_limit':
  command => "sed -i 's/ulimit \$ULIMIT/ulimit -n 4096/' /etc/init.d/nginx",
  path    => '/bin:/usr/bin',
  unless  => "grep -q 'ulimit -n 4096' /etc/init.d/nginx | grep -v '\$ULIMIT'",
  notify  => Exec['restart_nginx'],
}
exec { 'restart_nginx':
  command     => '/usr/sbin/service nginx stop && sleep 1 && /usr/sbin/service nginx start',
  path        => '/bin:/usr/bin:/usr/sbin',
  refreshonly => true,
}
