Description
===========

Installs and configures [Cube](http://square.github.com/cube/)

Requirements
============

* Node.js
* MongoDB
* UFW
* Tested on Ubuntu 11.10.

Usage
=====

Include default recipe in your run list.

Cube listens on ports 1080 (collector) and 1081 (evaluator) without
any security. As such this cookbook installs the
[Uncomplicated Firewall cookbook](http://community.opscode.com/cookbooks/ufw)
locking down all ports except SSH. You'll likely want to tailor this
to your environment.
