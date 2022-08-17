local CommandConfig = {}
CommandConfig.__index = CommandConfig

function CommandConfig.new(name, config)
    local self = setmetatable({}, CommandConfig)
    self._name = name
    self._config = config
    return self
end

function CommandConfig:SetItem(name, item)
    self._config[name] = item
    self._config:Save()
end

function CommandConfig:GetItem(name)
    return self._config[name]
end

return CommandConfig