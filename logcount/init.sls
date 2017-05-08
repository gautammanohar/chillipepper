# Create the dir that has the script.
logcount_dir:
        file.directory:
          - name: {{ salt['pillar.get']('logcount_dir') }}

# Place the script that needs to run every 30 minutes.
logcount_script:
  file.managed:
    - name: {{ salt['pillar.get']('logcount_dir') }}/{{ salt['pillar.get']('logcount_script') }}
    - source: salt://logcount/files/logcount_script.sh
    - template: jinja

# Set the cron for every 30 minutes.
/bin/sh {{ salt['pillar.get']('logcount_dir') }}/{{ salt['pillar.get']('logcount_script') }}:
  cron.present:
    - user: root
    - minute: '0,30'
