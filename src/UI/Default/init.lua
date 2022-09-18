local hbAdmin = script:FindFirstAncestor("HBAdmin")

local Maid = require(hbAdmin.Util.Maid)

local DefaultUI = {}

function DefaultUI:Init()

    if self._maid then 
        self._maid:Destroy()
    end
    self._maid = Maid.new()

    local UI = script.UI:Clone()
    local Components = script.Components
    local CMDBar = require(Components.CMDBar)
    local Commands = require(Components.Commands)
    local ChatLogs = require(Components.ChatLogs)
    local Notifications = require(Components.Notifications)
    local MOTD = require(Components.MOTD)
    UI.Parent = game.CoreGui
    Notifications:Init(UI.Notifications)
    CMDBar:Init(UI.Mini)
    Commands:Init(UI.Commands)
    ChatLogs:Init(UI.Chatlogs)
    MOTD:Init(UI.MOTD, Notifications)
    self._maid:GiveTask(UI)
    self._notifications = Notifications
    self._cmdBar = CMDBar
    self._commands = Commands
    self._chatLogs = ChatLogs
end

function DefaultUI:GetNotifications()
    return self._notifications
end

function DefaultUI:GetCMDBar()
    return self._cmdBar
end

function DefaultUI:GetCommands()
    return self._commands
end

function DefaultUI:GetChatLogs()
    return self._chatLogs
end

function DefaultUI:Destroy()
    self._maid:Destroy()
end

return DefaultUI