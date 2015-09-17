base:
  '*':
    - requirements
    - users
    - ssh
    - logging
    - ruby
  'swl-www-*':
    - nginx
  'swl-app-*':
    - redis
    - swl
  'swl-single-*':
    - nginx
    - redis
    - swl
