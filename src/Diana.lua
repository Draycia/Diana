---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by draycia.
--- DateTime: 10/24/19 4:11 PM
---

api_client = require("api-client");
api_key = arg[1];

local Summoner = require("v4.Summoner")

print(Summoner.by_name("Vìcarious").name)