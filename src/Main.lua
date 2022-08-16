local hbAdmin = script:FindFirstAncestor("HBAdmin")


local startTime = tick()

local Main = {}

local CommandController = require(hbAdmin.Commands.CommandController)
local ChatController = require(hbAdmin.Chat.ChatController)
local Config = require(hbAdmin.Filesystem.Config)
local Commands = require(hbAdmin.Setup.Commands)
local UI = require(hbAdmin.UI.UIApp)


local notify = function(Message, Title, time)
    UI:Notify(Title or "Homebrew Admin", Message, time)
end


function Main:Init()
    Config:Init()
    CommandController:Init()
    ChatController:Init(CommandController)
    Commands:Init(CommandController)
    UI:Init()
    notify("Total of " .. #CommandController.Commands .. " commands.", "Commands Loaded!")
    notify("Current prefix is `"..Config:Get("prefix").."`", "Prefix")
    notify("Loaded in " .. tick() - startTime, "Loaded!")
end

return Main