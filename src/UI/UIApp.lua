local hbAdmin = script:FindFirstAncestor("HBAdmin")

local Components = hbAdmin.UI.Components
local Notifications = require(Components.Notifications)
local CMDBar = require(Components.CMDBar)
local Commands = require(Components.Commands)
local ChatLogs = require(Components.ChatLogs)

local UI = {}

function UI:Init()
    local UI = hbAdmin.UI.Homebrew:Clone()
    UI.Parent = game.CoreGui
    Notifications:Init(UI.Notifications)
    CMDBar:Init(UI.Mini)
    Commands:Init(UI.Commands)
    ChatLogs:Init(UI.Chatlogs)
end

function UI:Notify(Title, Text, time)
    Notifications:Notify(Title, Text, time)
end

return UI