# Diana

Library for the Riot Games Developer API, written in Lua.

Tested with lua 5.3.

### Usage:
First you'll need an API key, obtained [here](https://developer.riotgames.com/).  
By default, API keys are passed in as the first (user supplied) program argument.  
`lua Diana.lua RGAPI-KEY-HERE`

For the time being, you can just edit the `Diana.lua` file to use the library.  
Each endpoint is stored as a local variable

The lib uses the global variable `api_key` for the api key and the variable `api_client` for requests.  
Both of these must be present for the library to work.

A helper function named `var_dump` is provided globally, located in the `Utils.lua` file.  
It will print all variables in whatever table to pass in.

Example Usage:
```lua
local input = "Vìcarious"
local user = Summoner.by_name(input)

print(user.name)
```

#### Required dependencies:  
[luasec](https://github.com/brunoos/luasec)  
[luasocket](https://github.com/diegonehab/luasocket)

##### Arch Community Packages:
If you're running Arch Linux, here are working packages for the above dependencies:  
[lua-sec](https://www.archlinux.org/packages/community/x86_64/lua-sec/)  
[lua-socket](https://www.archlinux.org/packages/community/x86_64/lua-socket/)

#### TODO
- Attempt pure-lua http(s) connections and make this lib free of external dependencies.
- Attempt to make this lib easily usable on Windows.
- Store all endpoints in a table and export it out of the `Diana.lua` file.
- Allow user to pass in table for query parameters and auto format them in `api-client.lua`
- Endpoints that do not return traditional JSON (see: champion-mastery) should turn them into JSON with the status code.
- Check status code of responses
- Assign the correct status_code in api-client