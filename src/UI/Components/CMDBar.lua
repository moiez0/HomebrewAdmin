local hbAdmin = script:FindFirstAncestor("HBAdmin")
local CommandController = require(hbAdmin.Commands.CommandController)
local ChatController = require(hbAdmin.Chat.ChatController)
local Config = require(hbAdmin.Filesystem.Config)

local UserInputService = game:GetService("UserInputService")
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()


local CMDBar = {
    CurrentCommands = {},
    CurrentIndex = 1
}

function CMDBar:Init(Mini)
    local MainBar = Mini.Input
    MainBar.Changed:Connect(function(p)
        if p == "Text" then
            self:Update(Mini)
        end
    end)
    Mouse.KeyDown:Connect(function(key)
        if key == Config:Get"prefix" then
            Mini.Visible = not Mini.Visible
            if Mini.Visible then
                MainBar:CaptureFocus()
                MainBar.Changed:Wait()
                MainBar.Text = ""
            end
        end
    end)
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Up then
            if self.CurrentIndex ~= #self.CurrentCommands then self.CurrentIndex += 1 end
            self:Update(Mini)
        end
        if input.KeyCode == Enum.KeyCode.Down then
            if self.CurrentIndex > 1 then self.CurrentIndex -= 1 end
            self:Update(Mini)
        end
        if input.KeyCode == Enum.KeyCode.Tab then
            MainBar.Changed:Wait()
            MainBar.Text = self.CurrentCommands[self.CurrentIndex]
            MainBar.CursorPosition = #MainBar.Text+1
        end
    end)
    MainBar.FocusLost:connect(function(enterPressed)
        if enterPressed then
            ChatController:HandleInput(MainBar.Text)
            Mini.Text = ''
            self:Update(Mini)
        end
    end)
end

function CMDBar:Update(Mini)
    if self.CurrentIndex > #self.CurrentCommands then
        self.CurrentIndex = #self.CurrentCommands
    end
    if #self.CurrentCommands == 0 then self.CurrentIndex = 0 end
    local MainBar = Mini.Input
    if MainBar.Text == "" then
        MainBar.Predict.Text = "" 
        Mini.Bubble.Visible = false
        return
    end
    CMDBar.CurrentCommands = CommandController:SearchCommand(MainBar.Text)
    MainBar.Predict.Text = CMDBar.CurrentCommands[CMDBar.CurrentIndex] or ""
    if CommandController:GetCommand(MainBar.Text) then
        Mini.Bubble.Visible = true
        Mini.Bubble.TextLabel.Text = CommandController:GetCommand(MainBar.Text):GetDescription()
    elseif CommandController:GetCommand(MainBar.Predict.Text) then
        Mini.Bubble.Visible = true
        Mini.Bubble.TextLabel.Text = CommandController:GetCommand(MainBar.Predict.Text):GetDescription()
    else
        Mini.Bubble.Visible = false
    end
end

return CMDBar