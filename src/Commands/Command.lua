local hbAdmin = script:FindFirstAncestor("HBAdmin")

local Command = {
    __type = "Command"
}
Command.__index = Command



function Command.new(Title, Desc, Args, Alternatives, Func)
    local self = setmetatable({
        _name = Title,
        _args = Args,
        _desc = Desc,
        _alias = Alternatives,
        _executor = Func,
        _store = {}
    }, Command)


    return self
end

function Command:Execute(Args)
    local executor = self._executor
    local args = Args
    executor(unpack(args))
end

function Command:GetName()
    return self._name
end

function Command:GetDescription()
    return self._desc
end

function Command:GetArguments()
    return self._args
end

function Command:GetAliases()
    return self._alias
end

function Command:GetStore(key)
    return self._store[key]
end

function Command:SetStore(key, value)
    self._store[key] = value
end

return Command