local hbAdmin = script:FindFirstAncestor("HBAdmin")
local Command = require(hbAdmin.Commands.Command)
local Config = require(hbAdmin.Filesystem.Config)
local Notifications = require(hbAdmin.UI.Components.Notifications)


local OldCommands = require(script.Parent.OldCommands)
local Commands = {
    _commands = {}
}

function Commands:Command(table)
    local title, desc, args, alternatives, func, init = table.title or table.name, table.desc or table.description, table.args or table.arguments, table.aliases or table.alternatives, table.func or table.executor, table.init
    title = title or "Homebrew Command"
    desc = desc or "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    args = args or 0
    alternatives = alternatives or {}
    func = func or function() end

    local command = Command.new(title, desc, args, alternatives, func)
    task.spawn(function()
        local s,e = pcall(init, command)
        if not s then
            Notifications:Notify("Error", "Error loading command "..command:GetName()..". Check Console for more info", 5)
            warn("Error loading command "..command:GetName()..". \n\n"..e.."\n"..debug.traceback())
        end
    end)
    self._commands[#self._commands+1] = command
    return command
end

function Commands:Init(CommandController)
    OldCommands:Init(CommandController)
    local antikill
    antikill = self:Command{
        name="AntiKill",
        aliases = {"antikill", "ak", "atk", "antitkill"},
        desc = "Prevents you from being tkilled",
        executor = function()
            local enabled = antikill:GetStore("enabled")
            if not enabled then
                Notifications:Notify("Anti Kill", "Anti Kill enabled", 5)
                game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled("Seated", false)
                game.Players.LocalPlayer.Character.Humanoid.Sit = true
            else
                Notifications:Notify("Anti Kill", "Anti Kill disabled", 5)
                game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled("Seated", true)
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            end
            antikill:SetStore("enabled", not enabled)
        end,
        init = function(self)
            self:SetStore("enabled", false)
        end
    }

    local antichatreport
    antichatreport = self:Command{
        name = "SecureChat",
        desc = "Fixes the issue of being banned for random BS.",
        aliases = {"acl","anticlog", "schat", "securechat"},
        executor = function()
            local enabled = antichatreport:GetStore("enabled")
            if not enabled then
                Notifications:Notify("Anti-Chat Report", "Anti-Chat Report enabled", 5)
            else
                Notifications:Notify("Anti-Chat Report", "Anti-Chat Report disabled", 5)
            end
            antichatreport:SetStore("enabled", not enabled)
        end,
        init = function(self)
            self:SetStore("enabled", false)
            local Players = game:GetService("Players")
            local Player = Players.LocalPlayer
            local PlayerScripts = Player ~= nil and Player:FindFirstChild("PlayerScripts") or nil
            local ChatScript = PlayerScripts ~= nil and PlayerScripts:FindFirstChild("ChatScript") or nil
            local ChatMain = ChatScript ~= nil and ChatScript:FindFirstChild("ChatMain") or nil
            
            if Player and ChatMain ~= nil then
                local Old, Chatted, OldChatted = nil, Instance.new("BindableEvent"), Player.Chatted; Chatted.Name = Player.Name.."_Chatted_Event"
                Old = hookmetamethod(game, "__index", newcclosure(function(self, Index)
                    if not antichatreport:GetStore("enabled") then return Old(self, Index) end
                    if checkcaller() and self == Player and Index == "Chatted" then
                        return Chatted.Event
                    elseif not checkcaller() and self == Player and Index == "Chatted" then
                        return OldChatted
                    end
               
                    return Old(self, Index)
                end))
               
                local Old2, MessagePosted = nil, require(ChatMain).MessagePosted
                if MessagePosted then
                    Old2 = hookfunction(MessagePosted.fire, function(self, ...)
                        if not antichatreport:GetStore("enabled") then return Old2(self, ...) end
                        if not checkcaller() then
                            return Chatted:Fire(...)
                        end
                    end)
                end
            end
        end
    }

    self:LoadCommands(CommandController)
end

function Commands:LoadCommands(CommandController)
    for _, cmd in next, self._commands do
        CommandController:AddCommand(cmd)
    end
end

return Commands