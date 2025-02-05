#!/usr/bin/env bash
# This script creates a MySQL user and grants replication permissions.

# Variables
USER="holberton_user"
PASSWORD="projectcorrection280hbtn"
PERMISSION="REPLICATION CLIENT"

#MySQL commands
mysql -u root -p <<EOF
CREATE USER '$USER'@'localhost' IDENTIFIED BY '$PASSWORD';
GRANT $PERMISSION ON *.* TO '$USER'@'localhost';
FLUSH PRIVILEGES;
EOF

# Verify the user and permissions
mysql -u$USER -p$PASSWORD -e "SHOW GRANTS FOR '$USER'@'localhost';"
