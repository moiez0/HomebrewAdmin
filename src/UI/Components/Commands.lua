local hbAdmin = script:FindFirstAncestor("HBAdmin")
local CommandController = require(hbAdmin.Commands.CommandController)
local FastDraggable = require(hbAdmin.UI.FastDraggable)

local Commands = {
    MainFrame = nil,
    CmdsFrame = nil
}

function Commands:Init(CmdsFrame)
    local MainFrame = CmdsFrame.Page.Command:Clone()
    CmdsFrame.Page.Command:Destroy()
    self.MainFrame = MainFrame
    self.CmdsFrame = CmdsFrame
    CmdsFrame.Top.Right.Exit.Trigger.MouseButton1Click:Connect(function()
        self:Hide()
    end)
    for _, Command in pairs(CommandController.Commands) do
        self:RegisterCommand(Command)
    end
    FastDraggable(CmdsFrame, CmdsFrame.Top, 0.1)
end

function Commands:RegisterCommand(Command)
    local Clone = self.MainFrame:Clone()
    Clone.Parent = self.CmdsFrame.Page
    local Aliases = Command:GetAliases()
    Clone.Version.Title.Text = Command:GetName()
    if #Aliases > 0 then
        Clone.Version.Title.Text ..= "<font color=\"#797979\" size=\"10\">/".. table.concat(Aliases, "/").."</font>"
    end

    Clone.Version.Desc.Text = Command:GetDescription()
    Clone.Visible = true
end


function Commands:Show()
    self.CmdsFrame.Visible = true
    self.CmdsFrame.Top.Visible = true
    self.CmdsFrame:TweenSize(UDim2.new(0, 248, 0, 314, "Out", "Quad", 0, 5))
end

function Commands:Hide()
    self.CmdsFrame:TweenSize(UDim2.new(0, 0, 0, 0, "Out", "Quad", 0, 5))
    wait(.3)
    self.CmdsFrame.Top.Visible = false
    wait(.6)
    self.CmdsFrame.Visible = false
end

return Commands