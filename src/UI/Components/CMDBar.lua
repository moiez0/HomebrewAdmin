local hbAdmin = script:FindFirstAncestor("HBAdmin")
local CommandController = require(hbAdmin.Commands.CommandController)
local CommandExecution = require(hbAdmin.Commands.CommandExecution)
local Config = require(hbAdmin.Filesystem.Config)

local UserInputService = game:FindService("UserInputService")
local Mouse = game:FindService("Players").LocalPlayer:GetMouse()

local Loading = require(hbAdmin.Loading.Maid)
local LoadingMaid = Loading:GetMaid()

local CMDBar = {
    CurrentCommands = {},
    CurrentIndex = 2,
    Debounce = false
}

function CMDBar:Init(Mini)
    Mini.Position = UDim2.new(0.5, 0, 1.2, 0)
    local MainBar = Mini.Input
    LoadingMaid:GiveTask(
        MainBar.Changed:Connect(function(p)
        if p == "Text" then
            self:Update(Mini)
        end
    end)
)

    LoadingMaid:GiveTask(
        Mouse.KeyDown:Connect(function(key)
        if key == Config:Get"prefix" then
            if Mini.Visible == false then
                self:Show(Mini)
            end
        end
    end)
)
    
    LoadingMaid:GiveTask(
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
)
    LoadingMaid:GiveTask(
        MainBar.FocusLost:connect(function(enterPressed)
        if enterPressed then
            CommandController.RequestExecute:Fire(CommandExecution.fromString(MainBar.Text))
            MainBar.Text = ''
            self:Update(Mini)
            self:Hide(Mini)
        end
    end)
)
end

function CMDBar:Show(Mini)
    if self.Debounce then
        return
    end
    
    self.Debounce = true
    task.delay(.5, function()self.Debounce = false end)

    task.defer(function()Mini.Input:CaptureFocus()end)

    Mini.Visible = true
    Mini:TweenPosition(UDim2.new(0.5, 0, 0.89999976, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, .5)
end

function CMDBar:Hide(Mini)
    if self.Debounce then
        return
    end

    self.Debounce = true
    task.delay(.5, function()self.Debounce = false Mini.Visible = false end)

    task.defer(function()Mini.Input:ReleaseFocus()end)
    
    Mini:TweenPosition(UDim2.new(0.5, 0, 1.2, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, .5)
end

function CMDBar:Update(Mini)
    if self.CurrentIndex > #self.CurrentCommands then
        self.CurrentIndex = #self.CurrentCommands
    end
    if #self.CurrentCommands == 0 then self.CurrentIndex = 1 end
    local MainBar = Mini.Input
    if MainBar.Text == "" then
        MainBar.Predict.Text = "" 
        Mini.Bubble.Visible = false
        return
    end
    CMDBar.CurrentCommands = CommandController:SearchCommandString(MainBar.Text)
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