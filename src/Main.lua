local hbAdmin = script:FindFirstAncestor("HBAdmin")


local startTime = tick()

local Main = {}

local CommandController = require(hbAdmin.Commands.CommandController)
local ChatController = require(hbAdmin.Chat.ChatController)
local Config = require(hbAdmin.Filesystem.Config)
local Commands = require(hbAdmin.Setup.Commands)


local notify = function(Message)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Homebrew Admin", Text = Message, Duration = 2})
end


function Main:Init()
    CommandController:Init()
    ChatController:Init(CommandController)
    Commands:Init(CommandController)
    Config:Init()
    notify("Loaded in " .. tick() - startTime)
    notify("Total of " .. #CommandController.Commands .. " commands.")
    notify("Current prefix is `"..Config:Get("prefix").."`")
end

return Main