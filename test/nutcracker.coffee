nutcracker = require "../src/index"
assert = require "assert"

PORT = 6379
HOST = "127.0.0.1"

describe "nutcracker", ->
  before (done) ->
    @client = nutcracker.createClient(PORT, HOST)
    done()

  describe "initialize", ->
    it "should use config values from args", ->
      assert.strictEqual @client.host, HOST
      assert.strictEqual @client.port, PORT

  describe "available commands", ->
    it "should return normal results", (done) ->
    	@client.set "seq", "9007199254740992", (err, result) ->
        assert.strictEqual result.toString(), "OK"
	      done()

  describe "unavailable commands", ->
    it "should use config values from args", (done) ->
      @client.keys "*", (err, result) ->
        assert.strictEqual err.toString(), "Error: nutcracker: cannot use keys command"
        assert.strictEqual result, null
	      done()