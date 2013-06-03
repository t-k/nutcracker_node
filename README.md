nutcracker - a node.js [nutcracker(twemproxy)](https://github.com/twitter/twemproxy) client
====
[![NPM version](https://badge.fury.io/js/nutcracker.png)](http://badge.fury.io/js/nutcracker)
[![Build Status](https://travis-ci.org/t-k/nutcracker_node.png)](https://travis-ci.org/t-k/nutcracker_node)
[![Dependency Status](https://david-dm.org/t-k/nutcracker_node/status.png)](http://david-dm.org/t-k/nutcracker_node)

nutcracker has a limitation on available commands (e.g., "info", "keys" and [more](https://github.com/twitter/twemproxy/blob/master/notes/redis.md)).

So you cannot use [node_redis](https://github.com/mranney/node_redis) as it is. This module wraps these unavailable commands, and if these commands were called, return warning message and errors.

Installation
---

```bash
npm install nutcracker
```

Usage
---

```coffeescript
nutcracker = require "nutcracker"
client = nutcracker.createClient(22121, "127.0.0.1")

client.set("string key", "string val", nutcracker.print)
client.keys("*", nutcracker.print)
# => Error: Error: nutcracker: cannot use keys command
# => false

```