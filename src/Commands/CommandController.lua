local hbAdmin = script:FindFirstAncestor("HBAdmin")
local Signal = require(hbAdmin.Util.Signal)
local Thread = require(hbAdmin.Util.Thread)



local CommandController = {
    Commands = {},
    CommandAdded = Signal.new(),
    RequestExecute = Signal.new()
}



function CommandController:Init()
    self.RequestExecute:Connect(function(CommandExecution)
        assert(CommandExecution.__type == "CommandExecution", "CommandExecution expected\n\n"..debug.traceback())
        local Command = CommandExecution:GetCommand()
        local Args = CommandExecution:GetArguments()
        Thread.Spawn(function()
            Command:Execute(unpack(Args))
        end)
    end)

end

function CommandController:AddCommand(Command)
    table.insert(self.Commands, Command)
    self.CommandAdded:Fire(Command)
end

function CommandController:GetCommand(Name)
    Name = Name:lower()
    for _, x in next, self.Commands do
        if x:GetName():lower() == (Name) then
            return x
        end
        local Aliases = x:GetAliases()
        for _, Alias in pairs(Aliases) do
            if Alias:lower() == (Name) then
                return x
            end
        end
    end
    error("Command not found: "..Name)
end

return CommandController