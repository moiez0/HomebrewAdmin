local hbAdmin = script:FindFirstAncestor("HBAdmin")


local startTime = os.clock()

local Main = {}

local CommandController = require(hbAdmin.Commands.CommandController)
local ChatController = require(hbAdmin.Chat.ChatController)
local Config = require(hbAdmin.Filesystem.Config)
local Commands = require(hbAdmin.Setup.Commands)
local UI = require(hbAdmin.UI)
local genv = require(hbAdmin.Setup.genv)


local notify = function(Message, Title, time)
    UI:Notify(Title or "Homebrew Admin", Message, time)
end


function Main:Init()
    Config:Init()
    UI:Init()
    CommandController:Init()
    ChatController:Init(CommandController)
    Commands:Init(CommandController)
    genv:Init()
    HB.Config = Config
    notify("Total of " .. #CommandController.Commands .. " commands.", "Commands Loaded!")
    notify("Current prefix is `"..Config:Get("prefix").."`", "Prefix")
    notify(Config.VERSION, "Version")
    notify("Loaded in " .. os.clock() - startTime, "Loaded!")
end


return Main
