local ThirdPartyCode = {}

--- Sets the
-- https://developer.riotgames.com/apis#third-party-code-v4/GET_getThirdPartyCodeBySummonerId
-- @param encrypted_summoner_id The encrypted summoner ID
function ThirdPartyCode.by_summoner(encrypted_summoner_id)
    return api_client.api_call_raw(
            "GET",
            "https://na1.api.riotgames.com/lol/platform/v4/third-party-code/by-summoner/5" .. encrypted_summoner_id
    );
end

return ThirdPartyCode;