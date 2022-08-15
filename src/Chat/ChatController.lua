local hbAdmin = script:FindFirstAncestor("HBAdmin")
local CommandExecution = require(hbAdmin.Commands.CommandExecution)
local Config = require(hbAdmin.Filesystem.Config)


local ChatController = {}

function ChatController:Init(CommandController)
    game.Players.LocalPlayer.Chatted:Connect(function(message)
        if message:sub(1, 1) == Config.PREFIX then
            print(message)
            local CommandExecution = CommandExecution.fromString(message:sub(2))
            CommandController.RequestExecute:Fire(CommandExecution)
        end
    end)
end

return ChatController