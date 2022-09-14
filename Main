
if not game:IsLoaded() then
    game.Loaded:Wait()
end
local start = os.clock()
local succ,err = pcall(function()
local rbxmSuite = loadstring(game:HttpGetAsync("https://github.com/richie0866/rbxm-suite/releases/latest/download/rbxm-suite.lua"))()

local path = rbxmSuite.download("Syntaxx64/HomebrewAdmin@latest", "Homebrew.rbxm")
-- Download the latest RBXM
rbxmSuite.launch(path, {
    runscripts=true,
    deferred = true,
    nocirculardeps = true
})

-- Launch using rbxmSuite
end)
if err then
    local Rostruct = loadstring(game:HttpGetAsync("https://github.com/richie0866/Rostruct/releases/download/v1.1.11/Rostruct.lua"))()
    Rostruct.fetchLatest("Syntaxx64", "HomebrewAdmin")
        :andThen(function(pkg)
            pkg:build("src/")
            pkg:start()
            return pkg
        end)

        :expect()
end
warn("Homebrew loaded in " ..string.format("%.2f", os.clock() - start))
