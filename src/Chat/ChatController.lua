local hbAdmin = script:FindFirstAncestor("HBAdmin")
local CommandExecution = require(hbAdmin.Commands.CommandExecution)
local Config = require(hbAdmin.Filesystem.Config)


local ChatController = {
    CommandController = nil
}

function ChatController:Init(CommandController)
    game.Players.LocalPlayer.Chatted:Connect(function(message)
        if message:sub(1, 1) == Config:Get("prefix") then
            self:HandleInput(message:sub(2))
        end
    end)
    self.CommandController = CommandController
end

function ChatController:HandleInput(string)
    string = string:sub(1, 1) == Config:Get("prefix") and string:sub(2) or string
    local CommandExecution = CommandExecution.fromString(string)
    self.CommandController.RequestExecute:Fire(CommandExecution)
end

return ChatController