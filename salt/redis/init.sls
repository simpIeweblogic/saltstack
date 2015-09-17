redis-server:
  pkgrepo.managed:
    - ppa: chris-lea/redis-server
  pkg.latest:
    - name: redis-server
    - refresh: True

redis-server-running:
  service.running:
    - name: redis-server
    - watch:
      - pkg: redis-server
    - require:
      - pkg: redis-server
