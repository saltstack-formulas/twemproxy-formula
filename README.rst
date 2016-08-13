twemproxy
=========

A salt formula that installs and configures twemproxy (nutcracker),
the memcached and redis proxy written by twitter.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``twemproxy``
-------------

Shortcut which includes all states listed below.

``twemproxy.config``
-------------

Manages the configuration file.
As twemproxy uses yaml in cofuguration it will fully match provided pillar.

``twemproxy.pkg``
-------------

Install twemproxy package

``twemproxy.service``
-------------

Manages twemproxy service

``twemproxy.build``
-------------

Download, build and install Twemproxy from source.

Notes
-----

Building and installing software from source as root (which is what this state
does) is generally considered poor-practice. A better solution is to build
twemproxy and package it using your distribution's tools, then make it
available in a local package repository. Then you can simply use:

.. code-block:: yaml

    twemproxy:
      pkg.installed

Tested On
---------

- CentOS release 6.5 (Final)
