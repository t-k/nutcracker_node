redis = require "redis"
net = require "net"
default_port = 22121
default_host = "127.0.0.1"
commands = ["keys", "migrate", "move", "object", "randomkey", "rename", "renamenx", "sort", "bitop", "mget", "mset", "blpop", "brpop", "brpoplpush", "psubscribe", "publish", "punsubscribe", "subscribe", "unsubscribe", "discard", "exec", "multi", "unwatch", "watch", "auth", "echo", "ping", "quit", "select", "script exists", "script flush", "script kill", "script load", "bgrewriteaof", "bgsave", "client kill", "client list", "config get", "config set", "config resetstat", "dbsize", "debug object", "debug segfault", "flushall", "flushdb", "info", "lastsave", "monitor", "save", "shutdown", "slaveof", "slowlog", "sync", "time"]

on_info_cmd = (err, res) ->
  if err
    return this.emit("error", new Error("Ready check failed: " + err.message))
  else
    return this.on_ready()

exports.RedisClient = redis.RedisClient
exports.createClient = (port_arg, host_arg, options) ->
  port = port_arg || default_port
  host = host_arg || default_host
  net_client = net.createConnection(port, host)
  redis_client = new redis.RedisClient(net_client, options)
  redis_client.port = port
  redis_client.host = host
  redis_client.on_info_cmd = on_info_cmd
  commands.forEach (cmd) ->
    if cmd == "info"
      fn = (array, callback) ->
        console.warn("nutcracker: cannot use " + cmd + " command");
        this.on_info_cmd()
        return false
    else
      fn = (array, callback) ->
        if callback && (typeof callback == "function")
          err = new Error('nutcracker: cannot use ' + cmd + ' command')
          callback(err, null)
        return false
    return redis_client[cmd] = redis_client[cmd.toUpperCase()] = fn
  return redis_client

exports.print = redis.print
exports.debug_mode = redis.debug_mode
exports.Multi = redis.Multi