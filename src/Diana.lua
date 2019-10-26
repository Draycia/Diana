api_client = require("api-client");
api_key = arg[1];

local API = {};

API.Summoner = require("v4.Summoner");
API.ThirdPartyCode = require("v4.ThirdPartyCode");

return API;