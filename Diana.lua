requests = require([[requests]]);
cjson = require([[cjson]]);
inspect = require([[inspect]]);

Diana = { setKey = {}, setDefaultRegion = {}, championMastery = {}, champion = {}, league = {}, lolStatus = {}, match = {}, spectator = {}, summoner = {}, thirdPartyCode = {} };

local summonerUrl = [[https://%s.api.riotgames.com/lol/summoner/v3/summoners/%s]];
local summonerByName = [[by-name/%s]];
local summonerByAccountId = [[by-account/%d]];
local summonerBySummonerId = [[%d]];

local championMasteryUrl = [[https://%s.api.riotgames.com/lol/champion-mastery/v3/champion-masteries/by-summoner/%d]];
local championMasteryScoresUrl = [[https://%s.api.riotgames.com/lol/champion-mastery/v3/scores/by-summoner/%d]];

local championUrl = [[https://%s.api.riotgames.com/lol/platform/v3/champions%s&freeToPlay=%t]];

local apiKey = [[]];
local defaultRegion = [[na1]];

do
  local strformat = string.format
  function string.format(format, ...)
    local args = {...}
    local match_no = 1
    for pos, type in string.gmatch(format, '()%%.-(%a)') do
      if type == 't' then
        args[match_no] = tostring(args[match_no])
      end
      match_no = match_no + 1
    end
    return strformat(string.gsub(format, '%%t', '%%s'),
      unpack(args,1,select('#',...)))
  end
end

Diana.setKey = function(key)
  apiKey = '?api_key=' .. key;
end

Diana.setDefaultRegion = function(region)
  defaultRegion = region;
end

Diana.summoner.getSummoner = function(args)
  local methodType = '';
  local requestId = 0;
  if type(args.name) == 'string' then
    methodType = summonerByName;
    requestId = args.name;
  elseif type(args.accountId) == 'number' then
    methodType = summonerByAccountId;
    requestId = args.accountId;
  elseif type(args.summonerId) == 'number' then
    methodType = summonerBySummonerId;
    requestId = args.summonerId;
  end
  methodType = string.format(methodType, requestId);
  local platform = args.region or defaultRegion;
  setmetatable({}, Summoner);
  local requestUrl = string.format(summonerUrl, platform, methodType, requestId) .. apiKey;
  local json = cjson.decode(requests.get(requestUrl).text);
  json.summonerId = json.id;
  json.id = nil;
  return json;
end

Diana.championMastery.getMasteries = function(args)
  local requestId = '';
  if type(args.summonerId) ~= 'number' then
    print('Summoner ID nil or NaN.');
    return nil;
  end
  if type(args.championId) == 'number' then
    requestId = 'my-champion/' .. args.championId;
  end
  local platform = args.region or defaultRegion;
  local requestUrl = string.format(championMasteryUrl, platform, args.summonerId) .. requestId .. apiKey;
  local json = cjson.decode(requests.get(requestUrl).text);
  return json;
end

Diana.championMastery.getScore = function(args)
  if type(args.summonerId) ~= 'number' then
    print('Summoner ID nil or NaN.');
    return nil;
  end
  local platform = args.region or defaultRegion;
  local requestUrl = string.format(championMasteryScoresUrl, platform, args.summonerId) .. apiKey;
  local notJson = requests.get(requestUrl).text;
  return tonumber(notJson);
end

Diana.champion.getChampions = function(args)
  local platform = args.region or defaultRegion;
  local freeToPlay = args.freeToPlay or false;
  local requestUrl = string.format(championUrl, platform, apiKey, freeToPlay);
  local json = cjson.decode(requests.get(requestUrl).text)
  return json;
end

Diana.setKey('');
summoner = Diana.summoner.getSummoner{summonerId = 51704649};
mastery = Diana.championMastery.getMasteries{summonerId = 51704649};
score = Diana.championMastery.getScore{summonerId = 51704649};
champions = Diana.champion.getChampions{};
