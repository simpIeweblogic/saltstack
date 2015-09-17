{% for name, user in pillar.get('users', {}).items() if user.absent is not defined or not user.absent %}
{%- if user == None -%}
{%- set user = {} -%}
{%- endif -%}
{%- set user_files = salt['pillar.get'](('users:' ~ name ~ ':user_files'), { 'enabled': False}) -%}
{%- set home = user.get('home', "/home/%s" %name) -%}
{%- set user_group = name -%}

{% for group in user.get('groups', []) %}
users_{{name}}_{{group}}_group:
  group:
    - name: {{group}}
    - present
{% endfor %}


users_{{name}}_user:
  group.present:
    - name: {{user_group}}
    - gid: {{ user['uid']}}
  user.present:
    - name: {{ name }}
    - home: {{ home }}
    - shell: {{ user.get('shell') }}
    - uid: {{ user['uid'] }}
    - password: '{{ user['password'] }}'
    - fullname: {{ user['fullname'] }}
    - groups:
      - {{ user_group }}
      {% for group in user.get('groups', []) %}
      - {{ group }}
      {% endfor %}

{% if 'ssh_auth' in user %}
{% for auth in user['ssh_auth'] %}
users_ssh_auth_{{name}}_{{loop.index0 }}:
  ssh_auth.present:
    - user: {{ name }}
    - name: {{ auth }}
{% endfor %}
{% endif %}

{% if user_files.enabled %}
vimrc_{{name}}:
  file.managed:
    - name: {{home}}/.vimrc
    - source: salt://users/files/.vimrc

oh_my_zsh_{{name}}:
  git.latest:
    - name: git://github.com/robbyrussell/oh-my-zsh.git
    - target: {{home}}/.oh-my-zsh
    - require:
      - user: {{name}}

zsh_config_{{name}}:
  file.managed:
    - name: {{home}}/.zshrc
    - source: salt://users/files/.zshrc
    - require:
      - user: {{name}}

oh_my_zsh_theme_{{name}}:
  file.managed:
    - name: {{home}}/.oh-my-zsh/themes/xxf.zsh-theme
    - source: salt://users/files/.xxf.zsh-theme
    - require:
      - user: {{name}}
{% endif %}
{% endfor %}