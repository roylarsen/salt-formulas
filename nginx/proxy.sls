{% from "nginx/map.jinja" import nginx with context %}

include:
  - nginx

{{ nginx.site }} conf:
  file.managed:
    - name: /etc/nginx/conf.d/{{ nginx.site }}.conf
    - template: jinja
    - source: salt://nginx/templates/proxy.conf.tmpl
    - context:
      port: {{ nginx.port }}
      site: {{ nginx.site }}
      proxy: {{ nginx.proxy }}
      root: {{ nginx.root }}
    - require:
      - pkg: nginx
  cmd:
    - run
    - name: firewall-cmd --zone=public --add-port={{ nginx.port }}/tcp
