local hbAdmin = script:FindFirstAncestor("HBAdmin")

local Thread = require(hbAdmin.Util.Thread)

local Notifications = {}

local NotificationQueue = {}

function Notifications:Notify(Title, Text, time)
    table.insert(NotificationQueue, {Title, Text, time})
end


function Notifications:Init(MainFrame)
    MainFrame.Visible = true
    local Frame = MainFrame.Body:Clone()
    MainFrame.Body:Destroy()

    local UIPadding = MainFrame.UIPadding

    local endpos = Frame.Position
    local startpos = endpos + UDim2.new(0, Frame.Size.X.Offset + UIPadding.PaddingRight.Offset*2, 0, 0)

    local Notifications = {}

    local Padding = 10

    function createNotification(Title, Text, time)
        time = time or 5
        local newFrame = Frame:Clone()
        newFrame.Visible = true
        newFrame.Parent = MainFrame
        newFrame.Position = startpos
        local Notification = {
            frame = newFrame,
            timer = time,
            leaving = false
        }
        newFrame.Title.Text = Text
        newFrame.Top.Title.Text = Title
        table.insert(Notifications, 1, Notification) 
        newFrame.Top.Exit.Image.Trigger.MouseButton1Click:Connect(function()
            Notification.timer = 0
        end)
    end
    task.defer(function()
        while true do
            local dt = game.RunService.RenderStepped:Wait()
            for i, Notification in pairs(Notifications) do
                Notification.timer = Notification.timer - dt
                if Notification.timer <= 0 then
                    if not Notification.leaving then
                        Notification.leaving = true
                        Notification.leavepos = Notification.frame.Position + UDim2.new(0, Frame.Size.X.Offset + UIPadding.PaddingRight.Offset*2, 0, 0)
                    end
                end
                if Notification.leaving then
                    local leavepos = Notification.leavepos
                    if Notification.frame.Position == leavepos then Notifications[i] = nil for i = i+1, #Notifications do Notifications[i-1] = Notifications[i] Notifications[i] = nil end end
                    Notification.frame.Position = Notification.frame.Position:Lerp(leavepos, .1)
                else
                    local enterpos = endpos - UDim2.new(0, 0, 0, (Frame.Size.Y.Offset + Padding) * (i-1)) 
                    if enterpos.Y.Offset > endpos.Y.Offset then enterpos = endpos end
                    Notification.frame.Position = Notification.frame.Position:Lerp(enterpos, .1)
                end
            end
        end
    end)
    self.Notify = function(self, ...) createNotification(...) end
    task.defer(function()
        for i, Notification in pairs(NotificationQueue) do
            createNotification(Notification[1], Notification[2], Notification[3])
        end
    end)
end

return Notifications