{% from "twemproxy/map.jinja" import twemproxy with context %}


include:
  - twemproxy.service


{{ twemproxy.default_file }}:
  file.managed:
    - source: salt://twemproxy/files/default.jinja
    - template: jinja
    - user: root
    - group: root
    - dir_mode: 750
    - file_mode: 640
    - watch_in:
      - service: twemproxy-service
