local hbAdmin = script:FindFirstAncestor("HBAdmin")
local Command = require(hbAdmin.Commands.Command)


local Plugin = {
    __type = "Plugin"
}
Plugin.__index = Plugin

function Plugin:AddCommand(name, Command)
    self._commands[Command:GetName()] = Command 
end

function Plugin:AddCommands(Commands)
    for name, cmd in pairs(Commands) do
        self:AddCommand(name, Command.new(cmd.Name, cmd.Description, cmd.Arguments, cmd.Aliases, cmd.Function))   
    end                     
end

function Plugin:GetName()
    return self._name
end

function Plugin:GetAuthor()
    return self._author
end

function Plugin:GetCommands()
    return self._commands
end

function Plugin.new(plugin)
    local self = setmetatable({
        _author = plugin.author,
        _name = plugin.name,
        _commands = {}
    }, Plugin)
    self:AddCommands(plugin.commands)
    return self
end

return Plugin