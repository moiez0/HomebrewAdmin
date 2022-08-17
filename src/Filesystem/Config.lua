local hbAdmin = script:FindFirstAncestor("HBAdmin")
local Plugin = require(hbAdmin.Plugins.Plugin)
local CommandController = require(hbAdmin.Commands.CommandController)
local Notifications = require(hbAdmin.UI.Components.Notifications)

local CommandConfig = require(hbAdmin.Commands.CommandConfig)

local Config = {}

Config._VERSION = "V2.03"
Config._PREFIX = ";"

Config._CurrentConfig = nil

local HttpService = game:GetService("HttpService")

function Config:Init()
    makefolder("HBAdmin")
    makefolder("HBAdmin/plugins")
    if not isfile("HBAdmin/config.json") then
        writefile("HBAdmin/config.json", HttpService:JSONEncode({
            ["version"] = self._VERSION,
            ["prefix"] = self._PREFIX
        }))
    end
    self._CurrentConfig = HttpService:JSONDecode(readfile("HBAdmin/config.json"))
    self.VERSION = self._CurrentConfig.version
    self.PREFIX = self._CurrentConfig.prefix
    Notifications:Notify("Plugins", "Began loading plugins...", 5)
    local startPlugins = tick()
    local Plugins = self:GetPlugins()
    for _, Plugin in pairs(Plugins) do
        for _, Command in pairs(Plugin:GetCommands()) do
            CommandController:AddCommand(Command)
        end
    end
    Notifications:Notify("Plugins", "Loaded " .. #Plugins .. " plugins in " .. string.format("%.2f", tick() - startPlugins) .. " seconds.", 5)
end

function Config:GetPlugins()
    local plugins = {}
    for _, path in pairs(listfiles("HBAdmin/plugins")) do
        local s, e = pcall(loadfile(path))
        if s then
            local plugin = e
            plugins[#plugins+1] = Plugin.new(plugin)
        else
            UI:Notify("Plugins", "Could not load plugin `"..path.."`")
        end
    end
    return plugins
end

function Config:Update(new)
    for k, v in pairs(new) do
        self._CurrentConfig[k] = v
    end
    self:Save()
end

function Config:Save()
    writefile("HBAdmin/config.json", HttpService:JSONEncode(self._CurrentConfig))
end

function Config:Get(key)
    return self._CurrentConfig[key]
end

function Config:CreateConfig(name)
    return CommandConfig.new(name, self)
end

function Config:GetConfig()
    return self._CurrentConfig
end

return Config