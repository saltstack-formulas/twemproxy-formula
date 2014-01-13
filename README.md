twemproxy
=========

Download, build and install Twemproxy from source.

> See the full [Salt Formulas installation and usage instructions][1]

[1]: http://docs.saltstack.com/topics/conventions/formulas.html "Salt Formulas"

Available states
----------------

``twemproxy``

 * Install ``twemproxy`` aka ``nutcracker``.

Building and installing software from source as root (which is what this state
does) is generally considered poor-practice. A better solution is to build
twemproxy and package it using your distribution's tools and make it available
in a local package repository. Then you can simple use:

```yaml
twemproxy:
  pkg.installed
```
