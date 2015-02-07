-- Copyright (C) Mashape, Inc.

local BasePlugin = require "apenode.base_plugin"
local log = require "apenode.plugins.networklog.log"


local function check_tcp(v, t)
  if t and t == "tcp" and not v then
    return false, "This property is required for the \"tcp\" type"
  end
  return true
end

local NetworkLogHandler = BasePlugin:extend()

local SCHEMA = {
  type = { type = "string", required = true, enum = { "tcp", "nginx_log" } },
  host = { type = "string", func = check_tcp },
  port = { type = "number", func = check_tcp },
  timeout = { type = "number", func = check_tcp },
  keepalive = { type = "number", func = check_tcp }
}

function NetworkLogHandler:new()
  self._schema = SCHEMA
  NetworkLogHandler.super.new(self, "networklog")
end

function NetworkLogHandler:log(conf)
  NetworkLogHandler.super.log(self)
  log.execute(conf)
end

return NetworkLogHandler
