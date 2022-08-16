local hbAdmin = script:FindFirstAncestor("HBAdmin")
local Date = require(hbAdmin.Util.Date)

local Message = {
    __type = "Message"
}
Message.__index = Message

function Message.new(User, MessageText, Time)
    local self = setmetatable({
        _User = User,
        _Message = MessageText,
        _Time = Time,
        _Channel = "All"
    }, Message)
    return self
end

function Message.fromMessageData(data)
    return setmetatable({
        _User = {DisplayName = data.SpeakerDisplayName, UserId = data.SpeakerUserId},
        _Message = data.Message,
        _Time = data.Time,
        _Channel = data.OriginalChannel,
        _Type = data.MessageType,

    }, Message)
end

function Message:GetIcon()
    return string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png", self._User.UserId)
end

function Message:GetText()
    return self._Message
end

function Message:GetTime()
    return Date.new(self._Time)
end

function Message:GetName()
    return self._User.DisplayName
end

function Message:GetType()
    return self._Type
end

function Message:GetChannel()
    return self._Channel
end

function Message:ToString()
    return string.format("[%s] -> [%s]: %s -> [%s]", self:GetTime():Format("%H:%M:%S"), self:GetName(), self:GetText(), self:GetChannel())
end

return Message