{% from "twemproxy/map.jinja" import twemproxy with context %}


include:
  - twemproxy.service


{{ twemproxy.config_file }}:
  file.managed:
    - user: root
    - group: root
    - dir_mode: 750
    - file_mode: 640
    - watch_in:
      - service: twemproxy-service
    - contents: |
        {{ twemproxy.config | yaml(False) | indent(8) }}
