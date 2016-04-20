include:
  - nginx.repo

nginx:
  pkg.installed: []
  service.running:
    - reload: True
    - require:
      - pkg: nginx
    - watch:
      - file: /etc/nginx/conf.d/*

Remove default configs:
  file.absent:
      - names:
        - /etc/nginx/conf.d/default.conf
        - /etc/nginx/conf.d/example_ssl.conf
