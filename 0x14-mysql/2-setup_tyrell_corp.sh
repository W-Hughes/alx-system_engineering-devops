#!/usr/bin/env bash
# This script creates a database, table and grants SELECT permission to holberton_user.

# Variables
DB_NAME="tyrell_corp"
TABLE_NAME="nexus6"
USER="holberton_user"
PASSWORD="projectcorrection280hbtn"

# MySQL commands
mysql -u root -p <<EOF
CREATE DATABASE $DB_NAME;
USE $DB_NAME;
CREATE TABLE $TABLE_NAME (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL
);
INSERT INTO $TABLE_NAME (name) VALUES ('Leon');
GRANT SELECT ON $DB_NAME.$TABLE_NAME TO '$USER'@'localhost';
FLUSH PRIVILEGES;
EOF

# Verify the steps
mysql -u$USER -p$PASSWORD -e "USE $DB_NAME; SELECT * FROM $TABLE_NAME;"
