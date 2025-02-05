#!/usr/bin/env bash
# This script creates a replica user and grants it replication permissions.

# Varibles
REPLICA_USER="replica_user"
REPLICA_PASSWORD="Replica_user1234"
HOLBERTON_USER="holberton_user"

# MySQL commands.
mysql -u root -p <<EOF
CREATE USER '$REPLICA_USER'@'%' IDENTIFIED BY '$REPLICA_PASSWORD';
GRANT REPLICATION SLAVE ON *.* TO '$REPLICA_USER'@'%';
GRANT SELECT ON mysql.user TO '$HOLBERTON_USER'@'localhost';
FLUSH PRIVILEGES;
EOF

# Verify the setup
mysql -u$HOLBERTON_USER -p -e 'SELECT user, Repl_slave_priv FROM mysql.user;'
