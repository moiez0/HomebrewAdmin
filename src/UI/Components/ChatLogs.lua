local hbAdmin = script:FindFirstAncestor("HBAdmin")

local Maid = require(hbAdmin.Util.Maid)
local Message = require(hbAdmin.UI.Message)
local Notifications = require(hbAdmin.UI.Components.Notifications)
local FastDraggable = require(hbAdmin.UI.FastDraggable)

local ChatLogs = {
    Maid = nil,
    Enabled = false,
    Logs = {}
}

function ChatLogs:Init(LogFrame)
    self.MainFrame = LogFrame
    LogFrame.Top.Right.Exit.Trigger.MouseButton1Click:Connect(function()
        self:Hide()
    end)
    local Page = LogFrame.Page
    self.ChatElement = Page.Chat:Clone()
    Page.Chat:Destroy()
    LogFrame.Buttons.Enable.Trigger.MouseButton1Click:Connect(function()
        if self.Enabled then
            self:Disable()
            LogFrame.Buttons.Enable.Title.Text = "Enable"
        else
            self:Enable()
            LogFrame.Buttons.Enable.Title.Text = "Disable"
        end
    end)
    LogFrame.Buttons.Save.Trigger.MouseButton1Click:Connect(function()
        self:SaveLogs()
    end)
    FastDraggable(LogFrame, LogFrame.Top, 0.1)
end

function ChatLogs:Show()
    self.MainFrame.Visible = true
end

function ChatLogs:Hide()
    self.MainFrame.Visible = false
end

function ChatLogs:Enable()
    Notifications:Notify("Chat Logs", "Enabled", 5)
    self.Enabled = true
    self.Maid = Maid.new()
    self.Maid:GiveTask(game.ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering").OnClientEvent:Connect(function(data)
        self:AddMessage(Message.fromMessageData(data))
    end))
end

function ChatLogs:Disable()
    Notifications:Notify("Chat Logs", "Disabled", 5)
    self.Enabled = false
    self.Maid:Destroy()
end

function ChatLogs:SaveLogs()
    Notifications:Notify("Chat Logs", "Saving...", 5)
    local Start = tick()
    makefolder("HBAdmin/ChatLogs")
    local output = string.rep("-", 10).."Homebrew Admin Chatlogs - "..os.date("%H:%M:%S").." - "..game.MarketplaceService:GetProductInfo(game.PlaceId).Name..string.rep("-", 10).."\n"
    for _, Message in pairs(self.Logs) do
        output ..= Message:ToString().."\n"
    end
    local fname = game.MarketplaceService:GetProductInfo(game.PlaceId).Name.." - "..os.date("%H-%M-%S")..".txt"
    writefile("HBAdmin/ChatLogs/"..fname, output)
    Notifications:Notify("Chat Logs", "Saved to HBAdmin/ChatLogs/"..fname.." in "..string.format("%.2f", tick()-Start).." seconds", 5)
end

function ChatLogs:AddMessage(Message)
    table.insert(self.Logs, Message)
    local newChat = self.ChatElement:Clone()
    newChat.Visible = true
    local type = Message:GetType()
    newChat.Parent = self.MainFrame.Page
    newChat.Inner.Join.Desc.Text = Message:GetText()
    newChat.Inner.Join.Icon.Image = Message:GetIcon()
    newChat.Inner.Right.Time.Text = Message:GetTime():Format("%H:%M %P")
    newChat.Inner.Right.Type.Text = type or "Unknown"
    if type == "Message" then
        newChat.Inner.Right.Type.TextColor3 = Color3.fromRGB(255, 255, 255)
    elseif type == "Whisper" then
        newChat.Inner.Right.Type.TextColor3 = Color3.fromRGB(38, 172, 255)
    else
        newChat.Inner.Right.Type.TextColor3 = Color3.fromRGB(132, 24, 255)
    end
    newChat.Inner.Right.Type.MouseEnter:Connect(function()
        newChat.Inner.Right.Type.Text = Message:GetChannel()
    end)
    newChat.Inner.Right.Type.MouseLeave:Connect(function()
        newChat.Inner.Right.Type.Text = type
    end)
    newChat.Inner.Join.Icon.Title.Text = Message:GetName()
end

return ChatLogs