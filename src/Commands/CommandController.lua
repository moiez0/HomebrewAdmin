local hbAdmin = script:FindFirstAncestor("HBAdmin")
local Signal = require(hbAdmin.Util.Signal)
local Thread = require(hbAdmin.Util.Thread)
local Loading = require(hbAdmin.Loading.Maid)
local LoadingMaid = Loading:GetMaid()


local CommandController = {
    Commands = {},
    CommandAdded = Signal.new(),
    RequestExecute = Signal.new()
}



function CommandController:Init()
    LoadingMaid:GiveTask(
        self.RequestExecute:Connect(function(CommandExecution)
        assert(CommandExecution.__type == "CommandExecution", "CommandExecution expected\n\n"..debug.traceback())
        local Command = CommandExecution:GetCommand()
        assert(Command, "CommandExecution has no command\n\n"..debug.traceback())
        local Args = CommandExecution:GetArguments()
        Thread.Spawn(function()
            Command:Execute(Args)
        end)
    end)
)
    LoadingMaid:GiveTask(self.CommandAdded)
    LoadingMaid:GiveTask(self.RequestExecute)
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
end

function CommandController:SearchCommand(Name)
    Name = Name:lower()
    local Commands = {}
    for _, x in next, self.Commands do
        if x:GetName():lower():sub(1, #Name) == (Name) then
            if not Commands[x:GetName()] then
                Commands[x:GetName()] = x:GetName():lower()
            end
        end
        local Aliases = x:GetAliases()
        for _, Alias in pairs(Aliases) do
            if Alias:lower():sub(1, #Name) == (Name) then
                if not Commands[x:GetName()] then
                    Commands[x:GetName()] = Alias:lower()
                end
            end
        end
    end
    local o = {}
    for k, v in next, Commands do
        table.insert(o, v)
    end
    return o
end

return CommandController