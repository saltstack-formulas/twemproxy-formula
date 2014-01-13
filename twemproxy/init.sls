{% from "twemproxy/map.jinja" import twemproxy with context %}

# Ensure the local src directory is ready
{{ twemproxy.src_directory }}:
  file.directory:
    - user: root
    - group: root
    - mode: 755

# Retrieve and unpack the source tarball
twemproxy-source:
  archive:
    - extracted
    - name: {{ twemproxy.src_directory }}
    - source: https://twemproxy.googlecode.com/files/nutcracker-{{ twemproxy.version }}.tar.gz
    - source_hash: {{ twemproxy.source_hash }}
    - archive_format: tar
    - tar_options: z
    - if_missing: /usr/local/src/nutcracker-{{ twemproxy.version }}

# Perform the ./configure, make, make install dance
build:
  cmd.wait:
    - cwd: /usr/local/src/nutcracker-{{ twemproxy.version }}
    - names:
      - ./configure
      - make
      - make install
    - watch:
      - archive: twemproxy-source

# Install the default sample configuration files.
{% for conf in 'nutcracker.leaf.yml nutcracker.root.yml nutcracker.yml'.split() %}
{{ twemproxy.config_directory }}/{{ conf }}:
  file.copy:
    - source: {{ twemproxy.src_directory }}/nutcracker-{{ twemproxy.version }}/conf/{{ conf }}
    - makedirs: True
    - require:
      - archive: twemproxy-source

# Test the configuration files.
nutcracker --test --conf-file={{ twemproxy.config_directory }}/{{ conf }}:
  cmd.wait:
    - cwd: {{ twemproxy.config_directory }}
    - watch:
      - file: {{ twemproxy.config_directory }}/{{ conf }}
    - require:
        - cmd: build
{% endfor %}

