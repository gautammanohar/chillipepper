#!/bin/bash
find /var/log/ -name '*.log' | \
xargs wc -l | \
awk ' { t = $1; $1 = $2; $2 = t; print; } ' | \
awk -v date="$(date +"%Y-%m-%d %T")" '{print date"|"$0}' | \
sed '$d' | \
sed -e 's/log\s/log|/g' \
>> {{ salt['pillar.get']('count_file') }} 
