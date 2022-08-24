local hbAdmin = script:FindFirstAncestor("HBAdmin")
local Maid = require(hbAdmin.Util.Maid)

local Loading = {}

function Loading:Unload(Config)
    local start = os.clock()
    self.Maid:Destroy()
    Config:Save()
    warn("Unloaded in " .. os.clock() - start .. " seconds.")
end

function Loading:GetMaid()
    if not self.Maid then self.Maid = Maid.new() end
    return self.Maid
end

return Loading