ciarand:
    user.present:
        - fullname: Ciaran Downey
        - home: /home/ciarand
        - gid_from_name: True
        - groups:
            - wheel
    ssh_auth.present:
        - user: ciarand
        - source: salt://ssh_keys/id_rsa.pub

# create the log files or whatever
{% for f in ["access", "error"] %}
/var/log/nginx/{{ f }}.log:
    file.managed:
        - makedirs: True
{% endfor %}

nginx:
    pkg.installed:
        - refresh: True
    service.running:
        - enable: True
        - reload: True
        - watch:
            - pkg: nginx
            - file: /usr/local/etc/nginx/nginx.conf

/usr/local/etc/nginx/nginx.conf:
    file.managed:
        - source: salt://nginx/nginx.conf
        - user: root
        - group: wheel
        - mode: 644

/usr/local/www/nginx:
    file.recurse:
        - source: salt://site
        - include_empty: True

# copy our new sshd_config file up
sshd:
    file.managed:
        - name: /etc/ssh/sshd_config
        - source: salt://ssh/sshd_config
        - user: root
        - group: wheel
        - mode: 644
    service.running:
        - reload: True
        - watch:
            - file: /etc/ssh/sshd_config
