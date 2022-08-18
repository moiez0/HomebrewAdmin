local hbAdmin = script:FindFirstAncestor("HBAdmin")
local Loading = require(hbAdmin.Loading.Maid)
local LoadingMaid = Loading:GetMaid()
local Config = require(hbAdmin.Filesystem.Config)

local genv = {}

function genv:Init()
    getgenv().HB = {}
    HB.API = {}
    HB.API.Unload = function()
        Loading:Unload(Config)
    end
    LoadingMaid:GiveTask(function() getgenv().HB = nil end)
end

return genv