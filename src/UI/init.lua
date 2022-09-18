local hbAdmin = script:FindFirstAncestor("HBAdmin")

local Loading = require(hbAdmin.Loading.Maid)
local LoadingMaid = Loading:GetMaid()

local UI = {}

function UI:Init(UI)
    if self._app then
        self._app:Destroy()
    end
    UI = UI or script.Default
    local App = require(UI)
    App:Init()
    LoadingMaid:GiveTask(App)
    self._app = App
end

function UI:Notify(Title, Text, time)
    self._app._notifications:Notify(Title, Text, time)
end

function UI:GetApp()
    return self._app
end

return UI