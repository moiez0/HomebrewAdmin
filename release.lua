local Rostruct = loadstring(game:HttpGet"https://github.com/richie0866/Rostruct/releases/download/v1.1.11/Rostruct.lua")()

Rostruct
    -- Download the lastest release to local files
    .fetchLatest("7n7o", "HomebrewAdmin-Rewritten")
    -- Then, build and start all scripts
    :andThen(function(pkg)
        pkg:build("src/", {Name = "HBAdmin"})
        pkg:start()
    end)