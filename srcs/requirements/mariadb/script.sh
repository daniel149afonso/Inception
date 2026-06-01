#!/bin/bash
mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld
exec mariadbd