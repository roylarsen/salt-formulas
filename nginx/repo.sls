nginx-repo:
  pkgrepo:
    - managed
    - name: nginx
    - humanname: nginx
    - baseurl: http://nginx.org/packages/rhel/7/$basearch/
    - gpgcheck: 0
    - enabled: 1
