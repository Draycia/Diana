-- -*- coding: utf-8 -*-
--
-- HTTP API Client.
--
-- Copyright 2014 Alexander Tsirel
-- http://noma4i.com
--
-- This code is released under a Apache License Version 2.0:
-- https://www.apache.org/licenses/LICENSE-2.0.txt

-- https://github.com/noma4i/lua-api-client
-- With slight modifications:
-- Made api_call local and exported it out in a local table
-- Removed the content length header and calculation
-- Added header X-Riot-Token used for specific REST service
-- Separated parameters out into their own argument

http = require("socket.http")
https = require("ssl.https")
json = (loadfile "./libs/JSON.lua")()
loadfile ("./libs/Utils.lua")()

local api_client = {}

function api_client.api_call(...)
    local args = {...}

    local params = args[3] or ""

    local respbody = {}

    https.request {
        method = args[1],
        url = args[2] .. params,
        source = ltn12.source.string(reqbody),
        headers = {
            ["Content-Type"] = "application/x-www-form-urlencoded",
            ["X-Riot-Token"] = api_key
        },
        sink = ltn12.sink.table(respbody)
    }

    return json:decode(table.concat(respbody))
end

return api_client