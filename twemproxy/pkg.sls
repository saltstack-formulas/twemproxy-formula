{% from "twemproxy/map.jinja" import twemproxy with context %}


twemproxy-pkg:
  pkg.installed:
    - name: {{ twemproxy.pkg }}
{%- if twemproxy.pkg_version is defined and twemproxy.pkg_version %}
    - version: '{{ twemproxy.pkg_version }}'
{%- endif %}
