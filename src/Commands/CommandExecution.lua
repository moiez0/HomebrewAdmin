local hbAdmin = script:FindFirstAncestor("HBAdmin")
local CommandController = require(hbAdmin.Commands.CommandController)


local CommandExecution = {
    __type = "CommandExecution"
}
CommandExecution.__index = CommandExecution

function CommandExecution.new(Command, Arguments)
    local self = setmetatable({
        _command = Command,
        _arguments = Arguments
    }, CommandExecution)
    
    return self
end

function CommandExecution.fromString(string)
    local parsedString = string:split(" ")
    local Command = CommandController:GetCommand(parsedString[1])
    local Arguments = {}
    for i = 2, #parsedString do
        table.insert(Arguments, parsedString[i])
    end
    return CommandExecution.new(Command, Arguments)
end

function CommandExecution:GetCommand()
    return self._command
end

function CommandExecution:GetArguments()
    return self._arguments
end

return CommandExecution