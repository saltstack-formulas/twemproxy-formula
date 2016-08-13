{% from "twemproxy/map.jinja" import twemproxy with context %}


include:
  - twemproxy.pkg

twemproxy-service:
  service.running:
    - name: {{ twemproxy.service }}
    - enable: True
    - require:
      - pkg: {{ twemproxy.pkg }}

{# there is no pid dir by default at least on Debian, so ensure it exists #}
{{ twemproxy.pid_dir }}:
  file.directory:
    - user: {{ twemproxy.user }}
    - group: {{ twemproxy.group }}
    - require_in:
      - service: twemproxy-service
