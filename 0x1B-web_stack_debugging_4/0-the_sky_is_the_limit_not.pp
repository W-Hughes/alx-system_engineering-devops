# Puppet manifest to fix Nginx for high request load by increasing file limits and connections
exec { 'fix--for-nginx':
  command => "/bin/sed -i -e 's/worker_connections [0-9]*;/worker_connections 1024;/' \
                         -e 's/worker_processes [0-9]*;/worker_processes 1;/' \
                         -e 's/# *multi_accept .*/multi_accept on;/' \
                         -e 's/access_log .*/access_log off;/' \
                         -e 's/sendfile .*/sendfile on;/' /etc/nginx/nginx.conf \
                         && /usr/sbin/service nginx restart",
  path    => '/bin:/usr/bin:/usr/sbin',
  unless  => "/bin/grep -q 'worker_connections 1024' /etc/nginx/nginx.conf \
                && /bin/grep -q 'multi_accept on' /etc/nginx/nginx.conf \
                && /bin/grep -q 'access_log off' /etc/nginx/nginx.conf",
}
