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
locking down all ports except SSH. To white list IP addresses create a
data bag named "firewall" and upload an item like the following:

```javascript
{
  "id": "cube",
  "rules": [
    { "collector-datacenter":
      { "port": "1080",
        "source": "192.168.1.1/24" }},
    { "evaluator-datacenter":
      { "port": "1081",
        "source": "192.168.1.1/24" }}
  ]
}
```
