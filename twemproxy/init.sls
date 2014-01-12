# Ensure the local src directory is ready
/usr/local/src:
  file.directory:
    - user: root
    - group: root
    - mode: 755

# Retrieve and unpack the source tarball
twemproxy-source:
  archive:
    - extracted
    - name: /usr/local/src
    - source: https://twemproxy.googlecode.com/files/nutcracker-0.3.0.tar.gz
    - source_hash: sha1=b17f973ff2de9bd5e21417786a1449bea1557fba
    - archive_format: tar
    - tar_options: z
    - if_missing: /usr/local/src/nutcracker-0.3.0

# Perform the ./configure, make, make install dance
build:
  cmd.wait:
    - cwd: /usr/local/src/nutcracker-0.3.0
    - names:
      - ./configure
      - make
      - make install
    - watch:
      - archive: twemproxy-source

# Install the default sample configuration files.
{% for conf in 'nutcracker.leaf.yml nutcracker.root.yml nutcracker.yml'.split() %}
/usr/local/etc/nutcracker/{{ conf }}:
  file.copy:
    - source: /usr/local/src/nutcracker-0.3.0/conf/{{ conf }}
    - makedirs: True

# Test the configuration files.
nutcracker --test --conf-file=/usr/local/etc/nutcracker/{{ conf }}:
  cmd.wait:
    - cwd: /usr/local/etc/nutcracker
    - watch:
      - file: /usr/local/etc/nutcracker/{{ conf }}
{% endfor %}

