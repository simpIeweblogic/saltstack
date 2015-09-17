ruby_repo:
  pkgrepo.managed:
    - humanname: ruby-ppa-trusty
    - name: deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main
    - file: /etc/apt/sources.list.d/ruby-trusty.list
    - dist: trusty
    - keyid: C3173AA6
    - keyserver: keyserver.ubuntu.com

ruby:
  pkg.installed:
    - names:
      - ruby2.2
      - ruby2.2-dev
      - ruby-switch
    - require:
      - pkgrepo: ruby_repo

  cmd.run:
    - name: ruby-switch --set ruby2.2
    - require:
      - pkg: ruby

  gem.installed:
    - name: lolcat
