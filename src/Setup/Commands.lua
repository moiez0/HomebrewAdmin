local hbAdmin = script:FindFirstAncestor("HBAdmin")
local Command = require(hbAdmin.Commands.Command)
local Config = require(hbAdmin.Filesystem.Config)
local Notifications = require(hbAdmin.UI.Components.Notifications)
local Loading = require(hbAdmin.Loading.Maid)

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
    init = init or function() end

    local command = Command.new(title, desc, args, alternatives, func)
    task.delay(.3, function()
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

    self:Command{
        title="Unload",
        desc="Unloads the admin",
        aliases={"panic", "unload", "exit"},
        executor=function()
            Loading:Unload(Config)
        end
    }

    local reCommand

    reCommand = self:Command{
        title="refresh",
        desc="Refreshes your character",
        aliases = {"re", "kys", "suicide", "refresh"},
        executor=function()
            if reCommand:GetStore("running") then
                Notifications:Notify("Refresh", "Already refreshing character!", 3)
                return
            end
            reCommand:SetStore("running", true)
            local Player = game.Players.LocalPlayer
            local Character = Player.Character
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")

            local function anchor(model)
                for i,v in pairs(model:GetChildren()) do
                    if v:IsA("BasePart") then v.Anchored = true end
                    anchor(v)
                end
            end
            anchor(Character)
            local SavePos = Character.HumanoidRootPart.CFrame
            Humanoid.Health = 0
            Player.CharacterAdded:Wait():WaitForChild("HumanoidRootPart").CFrame = SavePos
            reCommand:SetStore("running", false)
        end,
        init=function()
            reCommand:SetStore("running", false)
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