--- Summoner endpoint
local Summoner = {}

-- @type SummonerDTO
-- @number profileIconID ID of the summoner icon associated with the summoner.
-- @string name Summoner name.
-- @string puuid Encrypted PUUID. Exact length of 78 characters.
-- @number summonerLevel Summoner level associated with the summoner.
-- @number revisionDate Date summoner was last modified specified as epoch milliseconds.
-- @string id Encrypted summoner ID. Max length 63 characters.
-- @string accountId Encrypted account ID. Max length 56 characters.

--- Gets a SummonerDTO table or http response table from an encrypted account id
-- https://developer.riotgames.com/apis#summoner-v4/GET_getByAccountId
-- @param encrypted_account_id The encrypted account ID
function Summoner.by_account(encrypted_account_id)
    return api_client.api_call(
            "GET",
            "https://na1.api.riotgames.com/lol/summoner/v4/summoners/by-account/" .. encrypted_account_id
    );
end

--- Gets a SummonerDTO from a summoner name
-- https://developer.riotgames.com/apis#summoner-v4/GET_getBySummonerName
-- @param summoner_name A string containing the account's current summoner name
function Summoner.by_name(summoner_name)
    return api_client.api_call(
            "GET",
            "https://na1.api.riotgames.com/lol/summoner/v4/summoners/by-name/" .. urlencode(summoner_name)
    );
end

--- Gets a SummonerDTO from an encrypted PUUID
-- https://developer.riotgames.com/apis#summoner-v4/GET_getByPUUID
-- @param encrypted_puuid The account's encrypted PUUID
function Summoner.by_puuid(encrypted_puuid)
    return api_client.api_call(
            "GET",
            "https://na1.api.riotgames.com/lol/summoner/v4/summoners/by-puuid/" .. encrypted_puuid
    );
end

--- Gets a SummonerDTO from a summoner ID
-- https://developer.riotgames.com/apis#summoner-v4/GET_getBySummonerId
-- @param id The account's summoner ID
function Summoner.by_id(id)
    return api_client.api_call(
            "GET",
            "https://na1.api.riotgames.com/lol/summoner/v4/summoners/" .. id
    );
end

return Summoner;