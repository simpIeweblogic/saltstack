rails:
  pkg.installed:
    - names:
      - zlib1g-dev
      - libxml2-dev
      - libsqlite3-dev
      - sqlite3

  gem.installed:
    - names:
      - rails
      - unicorn

/www/:
  file.directory:
    - user: www-data
    - group: www-data

/www/.ppk.deploy.swl:
  file.managed:
    - user: www-data
    - source: salt://swl/files/github_deploy_key
    - mode: 0600

swl_repo:
  git.latest:
    - user: www-data
    - name: git@github.com:ch0ke/simple-web-logic.git
    - rev: master
    - target: /www/swl-site
    - identity: /www/.ppk.deploy.swl
    - unless: test -d /vagrant

bundle_install_swl_site:
  cmd.run:
    - name: bundle install
    - cwd: /www/swl-site

rake tmpdirs:
  cmd.run:
    - name: rake tmp:create
    - cwd: /www/swl-site
    - user: www-data

/www/swl-site/log:
  file.directory:
    - makedirs: True
    - user: www-data

nginx_swl_site:
  file.managed:
    - name: /etc/nginx/sites-enabled/swl-site.conf
    - source: salt://swl/files/swl-site.conf
    - template: jinja

run_launcher_swl_site:
  cmd.run:
    - name: ./launch.sh
    - cwd: /www/swl-site
    - user: www-data
