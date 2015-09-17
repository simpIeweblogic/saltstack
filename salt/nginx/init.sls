nginx:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - watch:
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-enabled/*

configure_nginx:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://nginx/files/nginx.conf

/etc/nginx/sites-enabled/default:
  file.absent
