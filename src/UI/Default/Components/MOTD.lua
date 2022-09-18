local hbAdmin = script:FindFirstAncestor("HBAdmin")

local Maid = require(hbAdmin.Util.Maid)
local Config = require(hbAdmin.Filesystem.Config)

local MOTD = {}

function MOTD:Init(MainFrame, Notifications)
    self._maid = Maid.new()
    self._maid:GiveTask(MainFrame)
    local lastMotd = Config:Get("lastMotd")
    if lastMotd == MainFrame.Body.Title.Text then
        self:Destroy()
        return
    end
    Config:Update {
        lastMotd = MainFrame.Body.Title.Text
    }
    MainFrame.Body.Position = UDim2.new(0.5, 0,0, -211)
    MainFrame.Body:TweenPosition(UDim2.new(0.5, 0,0, 0), "Out", "Quad", 0.5, true)
    self._maid:GiveTask(MainFrame.Body.Top.Exit.Close.Trigger.MouseButton1Click:Connect(function()
        MainFrame.Body:TweenPosition(UDim2.new(0.5, 0,0, -211), "Out", "Quad", 0.5, true)
        wait(0.5)
        self:Destroy()
    end))
    self._maid:GiveTask(MainFrame.Body.Top.Exit.Copy.Trigger.MouseButton1Click:Connect(function()
        setclipboard("discord.gg/GH5mEDgpVp")
        Notifications:Notify("Copied!", "Copied discord to clipboard")
    end))
end

function MOTD:Destroy()
    self._maid:Destroy()
end

return MOTD