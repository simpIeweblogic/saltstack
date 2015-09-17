tighten_ssh:
  file.managed:
      - name: /etc/ssh/sshd_config
      - source: salt://ssh/files/sshd_config

restart_ssh:
  service.running:
    - name: ssh
    - enable: True
    - watch:
      - file: /etc/ssh/sshd_config