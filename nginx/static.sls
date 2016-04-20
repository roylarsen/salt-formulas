{% from "nginx/map.jinja" import nginx with context %}

include:
  - nginx

/var/www:
  file.directory:
    - owner: nginx
    - group: nginx
    - mode: 0755

Create site dir:
  file.directory:
    - name: /var/www/{{nginx.site}}
    - owner: nginx
    - group: nginx
    - mode: 0755
   
Create site:
  file.managed:
    - name: /var/www/{{ nginx.site }}/index.html
    - source: salt://nginx/files/index.html
    - owner: nginx
    - group: nginx
    - mode: 0755
    - require:
      - file: /var/www/{{ nginx.site }}

{{ nginx.site }} conf:
  file.managed:
    - name: /etc/nginx/conf.d/{{ nginx.site }}.conf
    - template: jinja
    - source: salt://nginx/templates/static.conf.tmpl
    - context:
      port: {{ nginx.port }}
      site: {{ nginx.site }}
    - require:
      - pkg: nginx
  cmd:
    - run
    - name: firewall-cmd --zone=public --add-port={{ nginx.port }}/tcp
