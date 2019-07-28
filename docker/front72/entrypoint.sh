#!/bin/bash

iptables-restore -n /iptables-rules.conf
php-fpm

exec "$@"
