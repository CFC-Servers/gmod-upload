local libPath = "{{LIB_PATH}}"
if libPath ~= "{{LIB" .. "_PATH}}" then
    package.path = package.path .. ";" .. libPath .. "/?.lua"
end

local safeCall = require( "lib/runner" )

local function loadConfig()
    local json = require( "lib/json" )

    ---@param list string[]
    ---@return table<string, string>
    local function makeLookup( list )
        local newList = {}
        for _, v in ipairs( list ) do
            newList[v] = v
        end

        return newList
    end

    local TITLE = assert( arg[1], "No title given" )

    local TYPE = assert( arg[2], "No type given" )
    do
        local valid = makeLookup( {
            "ServerContent", "gamemode", "map", "weapon", "vehicle", "npc", "tool", "effects", "model", "entity"
        } )
        assert( valid[TYPE], "Invalid type input: '" .. TYPE .. "'" )
    end

    local TAGS = {}
    do
        local valid = makeLookup( {
            "fun", "roleplay", "scenic", "movie", "realism", "cartoon", "water", "comic", "build"
        } )

        local added = {}
        local function addTag( tag )
            if not tag then return end
            if tag == "" then return end

            assert( valid[tag], "Invalid tag: " .. tag )
            if added[tag] then return end

            table.insert( TAGS, tag )
            added[tag] = true
        end

        addTag( arg[3] )
        addTag( arg[4] )
        addTag( arg[5] )

        assert( #TAGS > 0, "No tags given" )
    end

    local path = os.time() .. ".json"

    local config = {
        title = TITLE,
        type = TYPE,
        tags = TAGS,
        ignore = { path, ".git/*", ".github/*", "addon.txt" }
    }

    if arg[6] == "true" then -- ignore lua
        table.insert( config.ignore, "*.lua" )
    end

    local newContents = json.encode( config )

    local handle = assert( io.open( path, "wb" ), "Failed to open file for writing: " .. path )
    handle:write( newContents )
    handle:close()

    print( path )
end

safeCall( loadConfig, "Failed to process addon config" )
