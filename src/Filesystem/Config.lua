local hbAdmin = script:FindFirstAncestor("HBAdmin")
local Plugin = require(hbAdmin.Plugins.Plugin)
local CommandController = require(hbAdmin.Commands.CommandController)

local Config = {}

Config.VERSION = "V2.03"
Config.PREFIX = ";"

Config._CurrentConfig = nil

local HttpService = game:GetService("HttpService")

function Config:Init()
    makefolder("HBAdmin")
    makefolder("HBAdmin/plugins")
    if not isfile("HBAdmin/config.json") then
        writefile("HBAdmin/config.json", HttpService:JSONEncode({
            ["version"] = self.VERSION,
            ["prefix"] = self.PREFIX
        }))
    end
    self._CurrentConfig = HttpService:JSONDecode(readfile("HBAdmin/config.json"))
    local Plugins = self:GetPlugins()
    for _, Plugin in pairs(Plugins) do
        for _, Command in pairs(Plugin:GetCommands()) do
            CommandController:AddCommand(Command)
        end
    end
end

function Config:GetPlugins()
    local plugins = {}
    for _, path in pairs(listfiles("HBAdmin/plugins")) do
        local s, e = pcall(loadfile(path))
        if s then
            local plugin = e
            plugins[#plugins+1] = Plugin.new(plugin)
        else
            warn("Could not load plugin `"..path.."`\n"..e.."\n\n"..debug.traceback())
        end
    end
    return plugins
end

return Config