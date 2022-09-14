local hbAdmin = script:FindFirstAncestor("HBAdmin")
local Loading = require(hbAdmin.Loading.Maid)
local LoadingMaid = Loading:GetMaid()
local Config = require(hbAdmin.Filesystem.Config)
local CommandController = require(hbAdmin.Commands.CommandController)
local Plugin = require(hbAdmin.Plugins.Plugin)
local Notifications = require(hbAdmin.UI.Components.Notifications)

local genv = {}

local function LoadPlugin(Plugin)
    for _, Command in pairs(Plugin:GetCommands()) do
        CommandController:AddCommand(Command)
    end
end

function genv:Init()
    getgenv().HB = {}
    HB.API = {}
    HB.API.Unload = function()
        Loading:Unload(Config)
    end
    HB.API.AddPlugin = function(filepath)
        local s, e = pcall(loadfile(filepath))
        if s then
            LoadPlugin(Plugin.new(e))
        else
            Notifications:Notify("Plugins", "Could not load plugin `"..filepath.."`", 5)
        end
    end
    LoadingMaid:GiveTask(function() getgenv().HB = nil end)
end

return genv