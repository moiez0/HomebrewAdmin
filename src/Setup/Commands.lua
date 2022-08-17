local hbAdmin = script:FindFirstAncestor("HBAdmin")

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local PhysicsService = game:GetService("PhysicsService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer


local Commands = {}

function Commands:Init(CommandController)
    local Command = require(hbAdmin.Commands.Command)
    local Config = require(hbAdmin.Filesystem.Config)
    local UI = require(hbAdmin.UI.UIApp)
    local Components = hbAdmin.UI.Components
    local CommandsUI = require(Components.Commands)
    local ChatLogs = require(Components.ChatLogs)

    local VERSION = Config:Get("version")

    local notify = function(Message, Title, time)
        UI:Notify(Title or "Homebrew Admin", Message, time)
    end

    local AddCommand = function(Title, Desc, Args, Alternatives, Func)
        CommandController:AddCommand(Command.new(Title, Desc, Args, Alternatives, Func))
    end

    local GetCommand = function(Name) return CommandController:GetCommand(Name) end

    local GetPlayer = function(Name)
        if Name:lower() == "random" then
            return Players:GetPlayers()[math.random(#Players:GetPlayers())]
        else
            Name = Name:lower():gsub("%s", "")
            for _, x in next, Players:GetPlayers() do
                if x.Name:lower():match(Name) then
                    return x
                elseif x.DisplayName:lower():match("^" .. Name) then
                    return x
                end
            end
        end
    end

    AddCommand(
        "chatlogs",
        "opens the chat logger",
        0,
        {"clog", "chatlog", "logs"},
        function()
            ChatLogs:Show()
        end
    )

    AddCommand(
        "force",
        "Use the force on target [TOOL REQUIRED]",
        1,
        {"hold", "theforce"},
        function(Target)
                    
        
        local Players = game:GetService("Players")
        local CoreGui = game:GetService("CoreGui")
        local RunService = game:GetService("RunService")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local UserInputService = game:GetService("UserInputService")
        local Lighting = game:GetService("Lighting")
        local StarterGui = game:GetService("StarterGui")
        
        local Player = Players.LocalPlayer
        local Character = Player.Character
        
        local PlayerGui = Player:WaitForChild("PlayerGui")
        local Backpack = Player:WaitForChild("Backpack")
        
        local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
        local RootPart = Character and Humanoid and Humanoid.RootPart or false
        local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
        if not Humanoid or not RootPart or not RightArm then
            return
        end
        
        local AnimationIds = {
            ["Grab"] = {
                ["R6"] = 182393478,
                ["R15"] = 393915542
            }
        }
        
        local CreateRightGrip = function(Tool)
            if Tool and RightArm then
                local Handle = Tool and Tool:FindFirstChild("Handle") or false
                if Handle then
                    local Weld = Instance.new("Weld")
                    Weld.Name = "RightGrip"
                    Weld.Part0 = RightArm
                    Weld.Part1 = Handle
                    Weld.C0 = CFrame.new(0, -5, -3) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))--math.rad(-90) 
                    Weld.C1 = Tool.Grip
                    Weld.Parent = RightArm
                    return Weld
                end
            end
        end
        
        Humanoid:UnequipTools()
        local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
        if not MainTool or not MainTool:FindFirstChild("Handle") then
            return
        end
        
        local TPlayer = GetPlayer(Target)
        local TCharacter = TPlayer and TPlayer.Character
        
        local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
        local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
        if not THumanoid or not TRootPart then
            return
        end
        
        if Character:FindFirstChild("Animate") then
            Character:FindFirstChild("Animate").Disabled = true
        end
        for _, x in next, Humanoid:GetPlayingAnimationTracks() do
            x:Stop()
        end
        CreateRightGrip(MainTool)
        MainTool.Parent = Character
        MainTool.Handle:BreakJoints()
        MainTool.Parent = Backpack
        MainTool.Parent = Humanoid
        CreateRightGrip(MainTool)
        if firetouchinterest then
            firetouchinterest(MainTool.Handle, TRootPart, 0)
            firetouchinterest(MainTool.Handle, TRootPart, 1)
        else
            if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                local OldCFrame = RootPart.CFrame
                local OldTick = tick()
                repeat
                    task.wait()
                    RootPart.CFrame = TRootPart.CFrame * CFrame.new(0, 2, 2)
                    if MainTool.Parent ~= Humanoid then
                        break
                    end
                until (tick() - OldTick) > 3
                RootPart.CFrame = OldCFrame
            else
                return
            end
        end
        
        THumanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
        THumanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
        local MainAnimation = Instance.new("Animation", Humanoid)
        local Animation
        local WaitTime
        if Humanoid.RigType == Enum.HumanoidRigType.R6 then
            MainAnimation.AnimationId = "rbxassetid://"..AnimationIds["Grab"]["R6"]
            Animation = Humanoid:LoadAnimation(MainAnimation)
        else
            MainAnimation.AnimationId = "rbxassetid://"..AnimationIds["Grab"]["R15"]
            Animation = Humanoid:LoadAnimation(MainAnimation)
        end
        Animation.Looped = false
        Animation:Play()
        task.wait(WaitTime)
        Animation:AdjustSpeed(0)
        
        notify("Press K to kill")
        notify("Press E to drop")
        
        local KillTPlayer; KillTPlayer = UserInputService.InputBegan:Connect(function(Input, GameProcessed)
            if not GameProcessed and Input.KeyCode == Enum.KeyCode.K then
                KillTPlayer:Disconnect()
                RootPart.Anchored = true
                RootPart.Anchored = false
                Player.Character = nil
                Humanoid.Health = 0
                Character:BreakJoints()
            elseif not GameProcessed and Input.KeyCode == Enum.KeyCode.E then
                Animation:Stop()
                KillTPlayer:Disconnect()
                if Character:FindFirstChild("Animate") then
                    Character:FindFirstChild("Animate").Disabled = false
                end
                if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                    Character["Right Arm"].RightGrip:Destroy()
                else
                    Character["RightHand"].RightGripAttachment:Destroy()
                    Character["RightHand"].RightGrip:Destroy()
                end
            end
        end)
       end
    )

    AddCommand(
        "tfling",
        "makes your tool fling (dont equip)",
        0,
        {"toolfling"},
        function()
            notify("Equip your tool.")
            Tool = Player.Backpack:FindFirstChildWhichIsA("Tool")
            if not Tool then
                repeat
                    wait()
                    Tool = Player.Backpack:FindFirstChildWhichIsA("Tool")
                until Tool
            end
            Tool.Handle.Massless = true
            Tool.GripPos = Vector3.new(0, -10000, 0)
        end
    )

    AddCommand(
        "re",
        "Resets you in the same pos",
        0,
        {"reset","refresh"},
        function()
            if Player.Character.Humanoid then
                CF = Player.Character.HumanoidRootPart.CFrame
                Player.Character:BreakJoints()
                Player.CharacterAdded:Wait()
                Player.Character:WaitForChild("HumanoidRootPart")
                Player.Character.HumanoidRootPart.CFrame = CF
            end
        end
    )

    AddCommand(
        "respawn",
        "Resets you",
        0,
        {"reset","gr"},
        function()
            if Player.Character.Humanoid then
                Player.Character:BreakJoints()
            end
        end
    )


    AddCommand(
        "view",
        "views specified player",
        1,
        {"spectate"},
        function(targ)
            if death then
                death:Disconnect()
                viewing:Disconnect()
            end
            local Target = GetPlayer(targ)
            if Target then
                repeat
                    wait()
                until Target.Character
                workspace.CurrentCamera.CameraSubject = Target.Character
                local function died()
                    repeat
                        wait()
                    until Target.Character.Humanoid
                    workspace.CurrentCamera.CameraSubject = Target.Character
                end
                death = Target.CharacterAdded:Connect(died)
                viewing = workspace.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(died)
                notify("Viewing: " .. Target.Name)
            else
                notify("No such player.")
            end
        end
    )

    AddCommand(
        "unview",
        "unviews",
        0,
        {},
        function()
            if death then
                death:Disconnect()
                viewing:Disconnect()
                workspace.CurrentCamera.CameraSubject = Player.Character
                notify("Unviewed..")
            else
                notify("You are not viewing anyone!")
            end
        end
    )
   
    AddCommand(
        "night",
        "Sets time to night [CLIENT]",
        0,
        {},
        function()
            Lighting.ClockTime = 0
            notify("Set clocktime to 22.")
        end
    )

    AddCommand(
            "day",
            "Sets time to day [CLIENT]",
            0,
            {},
            function()
                Lighting.ClockTime = 14
                notify("Set clocktime to 5")
            end
    )


    AddCommand(
            "reach",
            "Gives reach at arg",
            1,
            {},
            function(reachsize)
                local reachsize = reachsize or 25
                local Tool = Player.Character:FindFirstChildOfClass("Tool") or Player.Backpack:FindFirstChildOfClass("Tool")
                if Tool:FindFirstChild("OGSize3") then
                    Tool.Handle.Size = Tool.OGSize3.Value
                    Tool.OGSize3:Destroy()
                    Tool.Handle.FunTIMES:Destroy()
                end
                local val = Instance.new("Vector3Value",Tool)
                val.Name = "OGSize3"
                val.Value = Tool.Handle.Size
                local sb = Instance.new("SelectionBox")
                sb.Adornee = Tool.Handle
                sb.Name = "FunTIMES"
                sb.Parent = Tool.Handle
                Tool.Handle.Massless = true
                Tool.Handle.Size = Vector3.new(Tool.Handle.Size.X,Tool.Handle.Size.Y,reachsize)
                notify("Reach enabled.")
            end
    )

    AddCommand(
            "unreach",
            "Disables reach",
            0,
            {"noreach"},
            function()
                for i,v in pairs(Player.Character:GetDescendants()) do
                    if v:IsA("Tool") and v:FindFirstChild("OGSize3") then
                        v.Handle.Size = v.OGSize3.Value
                        v.Handle.FunTIMES:Destroy()
                        notify("Reach disabled on "..v.Name)
                    end
                end
            end
    )
    
    AddCommand(
        "safechat",
        "Enables safechat",
        0,
        {},
        function()
            Player:SetSuperSafeChat(true)
            notify("Safe chat enabled.")
        end
    )

    AddCommand(
        "unsafechat",
        "Disables safechat",
        0,
        {"nosafechat"},
        function()
            Player:SetSuperSafeChat(false)
            notify("Safe chat disabled.")
        end
    )
    
    AddCommand(
        "enableshiftlock",
        "Enables shift lock",
        0,
        {"sl"},
        function()
            Player.DevEnableMouseLock = true
            notify("Done.")
        end
    )

    AddCommand(
        "firstperson",
        "Enables first person",
        0,
        {"fp","firstp"},
        function()
            Player.CameraMode = "LockFirstPerson"
            notify("Set camera mode.")
        end
    )

    AddCommand(
        "thirdperson",
        "Enables third person",
        0,
        {"thirdp"},
        function()
            Player.CameraMode = "Classic"
            notify("Set camera mode.")
        end
    )

    AddCommand(
        "droppabletools",
        "Makes your tools droppable",
        0,
        {"tooldroppable","makedroppable"},
        function()
            Player.Character:FindFirstChildOfClass('Humanoid'):UnequipTools()
            for i, v in pairs(Player.Backpack:GetDescendants()) do
                    if v:IsA("Tool") then
                        v.CanBeDropped = true
                    end
            end
            notify("Done.")
        end
    )

    AddCommand(
        "maxzoom",
        "Sets camera max zoom to arg",
        1,
        {},
        function(distance)
            Player.CameraMaxZoomDistance = distance
            notify("Maxzoom set to "..distance)
        end
    )

    AddCommand(
        "minzoom",
        "Sets camera min zoom to arg",
        1,
        {},
        function(distance)
            Player.CameraMinZoomDistance = distance
            notify("Minzoom set to "..distance)
        end
    )

    AddCommand(
        "fov",
        "Sets fov to arg",
        1,
        {},
        function(fov)
            if fov == "default" then
                fov = 70
            end
            workspace.CurrentCamera.FieldOfView = fov
            notify("FOV set to "..fov)
        end
    )

    AddCommand(
        "antiafk",
        "Stops ROBLOX from kicking you for being afk",
        0,
        {},
        function()
        ANTIAFK = Player.Idled:connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    end
    )

    AddCommand(
        "unantiafk",
        "Disconnects antiafk",
        0,
        {},
        function()
        if ANTIAFK then
            ANTIAFK:Disconnect()
            notify("Disconnected antiafk.")
        else
            notify("antiafk is not on!")
        end
    end
    )


    AddCommand(
        "discord",
        "Grabs our discord invite!",
        0,
        {},
        function()
            sc = setclipboard or toClipboard
            if sc then
                sc("https://discord.gg/rZsAbyRasw")
            else
                notify("https://discord.gg/rZsAbyRasw")
            end
            pcall(function()
            httprequest({
                Url = 'http://127.0.0.1:6463/rpc?v=1',
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json',
                    Origin = 'https://discord.com'
                },
                Body = HttpService:JSONEncode({
                    cmd = 'INVITE_BROWSER',
                    nonce = HttpService:GenerateGUID(false),
                    args = {code = 'rZsAbyRasw'}
                })
            })
        end)
        end
    )
    
    local arms = {
        "Left Arm",
        "Right Arm",
        "LeftUpperArm",
        "RightUpperArm"
    }
    AddCommand(
        "noarms",
        "removes your arms",
        0,
        {},
        function()
            notify("Removing arms..")
            local succ, err =
                pcall(
                function()
                    for i, v in pairs(arms) do
                        if Player.Character and Player.Character:FindFirstChild(v) then
                            Player.Character[v]:Destroy()
                        end
                    end
                end
            )
            if err then
                notify("Uh oh, something went wrong.")
            end
        end
    )

    AddCommand(
        "creeper",
        "makes you a creeper",
        0,
        {},
        function()
            notify("Making you a creeper..")
            local succ, err =
                pcall(
                function()
                    for i, v in pairs(arms) do
                        if Player.Character and Player.Character:FindFirstChild(v) then
                            Player.Character[v]:Destroy()
                        end
                    end
                    Player.Character.Head.Mesh:Destroy()
                end
            )
            if err then
                notify("Uh oh, something went wrong.")
            end
        end
    )

    AddCommand(
        "blockhead",
        "removes your heads mesh",
        0,
        {"nomeshhead"},
        function()
            local succ, err =
                pcall(
                function()
                    Player.Character.Head.Mesh:Destroy()
                end
            )
            if succ then
                notify("Destroyed mesh.")
            else
                notify("Something went wrong..")
            end
        end
    )

    AddCommand(
        "nohats",
        "removes your hats",
        0,
        {"removehats"},
        function()
            for _, hat in pairs(Player.Character:GetDescendants()) do
                if hat:IsA("Accessory") then
                    hat.Handle.AccessoryWeld:Destroy()
                    hat.Handle.Velocity = Vector3.new(math.huge, math.huge, math.huge)
                end
            end
        end
    )

    -- fencing only
    if game.PlaceId == 12109643 then
        AddCommand(
            "killall",
            "Kills everyone.",
            0,
            {"spraykillall"},
            function()
                local Players = game:GetService("Players")
                local Player = Player
                local Character = Player.Character
                local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                local RootPart = Humanoid.RootPart
                local Handle = workspace:FindFirstChild("Handle")

                if not Character or not Humanoid or not RootPart or not Handle or not Character:FindFirstChild("Right Arm") then
                    return
                end

                local Old = RootPart.CFrame

                RootPart.CFrame = CFrame.new(0, 8e9, 0)

                for i = 1, #Players:GetPlayers() - 1 do
                    firetouchinterest(RootPart, Handle, 0)
                    firetouchinterest(RootPart, Handle, 1)
                    Character:WaitForChild("Spray").Parent = workspace
                    RunService.Heartbeat:wait()
                end
                for _, x in next, workspace:GetChildren() do
                    if x:IsA("Tool") and x.Name == "Spray" then
                        firetouchinterest(RootPart, x.Handle, 0)
                    end
                end

                RootPart.Velocity = Vector3.new()
                RootPart.CFrame = Old
                repeat
                    RunService.Heartbeat:wait()
                until Character:FindFirstChild("Spray")
                wait(.25)
                local NewHumanoid = Humanoid:Clone()
                Humanoid:Destroy()
                NewHumanoid.Parent = Character

                NewHumanoid:UnequipTools()
                repeat
                    RunService.Heartbeat:wait()
                until not Character:FindFirstChild("Spray")
                wait(.25)
                for _, x in next, Player.Backpack:GetChildren() do
                    if x:IsA("Tool") and x.Name == "Spray" then
                        x.Parent = Character
                        if
                            Players:GetPlayers()[_] and Players:GetPlayers()[_].Character and
                                Players:GetPlayers()[_].Character:FindFirstChildOfClass("Humanoid") and
                                not Players:GetPlayers()[_].Character:FindFirstChildOfClass("Humanoid").Sit and
                                Players:GetPlayers()[_].Character:FindFirstChildOfClass("Humanoid").Health > 0 and
                                Players:GetPlayers()[_].Character:FindFirstChild("Right Arm")
                        then
                            firetouchinterest(x.Handle, Players:GetPlayers()[_].Character.PrimaryPart, 0)
                            firetouchinterest(x.Handle, Players:GetPlayers()[_].Character.PrimaryPart, 1)
                            RunService.Stepped:wait()
                        end
                    end
                end
                Player.Character = nil
                NewHumanoid.Health = 0
            end
        )
    end

    AddCommand(
        "spotify",
        "unlocks the spotify api",
        0,
        {"spoti"},
        function()
            if getgenv().apikey == nil then
                notify("No api key! Please apply one with spotikey.")
            else
                notify("Unlocking api..")
            end
            getgenv().requests = {
                ["CurrentlyPlaying"] = {
                    Url = "https://api.spotify.com/v1/me/player/currently-playing",
                    Method = "GET",
                    Headers = {
                        ["Accept"] = "application/json",
                        ["Authorization"] = "Bearer " .. apikey,
                        ["Content-Type"] = "application/json"
                    }
                },
                ["NextSong"] = {
                    Url = "https://api.spotify.com/v1/me/player/next",
                    Method = "POST",
                    Headers = {
                        ["Accept"] = "application/json",
                        ["Authorization"] = "Bearer " .. apikey,
                        ["Content-Type"] = "application/json"
                    }
                },
                ["LastSong"] = {
                    Url = "https://api.spotify.com/v1/me/player/previous",
                    Method = "POST",
                    Headers = {
                        ["Accept"] = "application/json",
                        ["Authorization"] = "Bearer " .. apikey,
                        ["Content-Type"] = "application/json"
                    }
                },
                ["Pause"] = {
                    Url = "https://api.spotify.com/v1/me/player/pause",
                    Method = "PUT",
                    Headers = {
                        ["Accept"] = "application/json",
                        ["Authorization"] = "Bearer " .. apikey,
                        ["Content-Type"] = "application/json"
                    }
                },
                ["Play"] = {
                    Url = "https://api.spotify.com/v1/me/player/play",
                    Method = "PUT",
                    Headers = {
                        ["Accept"] = "application/json",
                        ["Authorization"] = "Bearer " .. apikey,
                        ["Content-Type"] = "application/json"
                    }
                }
            }
        end
    )

    AddCommand(
        "spotinext",
        "goes to the next song on spotify",
        0,
        {"spotifynext"},
        function()
            local succ, err =
                pcall(
                function()
                    syn.request(getgenv().requests["NextSong"])
                end
            )
            if err then
                notify("Spotify api not unlocked..")
            end
        end
    )

    AddCommand(
        "spotipause",
        "pauses the song on spotify",
        0,
        {"spotifypause"},
        function()
            local succ, err =
                pcall(
                function()
                    syn.request(getgenv().requests["Pause"])
                end
            )
            if err then
                notify("Spotify api not unlocked..")
            end
        end
    )

    AddCommand(
        "spotiplay",
        "plays/unpauses the song on spotify",
        0,
        {"spotifyplay"},
        function()
            local succ, err =
                pcall(
                function()
                    syn.request(getgenv().requests["Play"])
                end
            )
            if err then
                notify("Spotify api not unlocked..")
            end
        end
    )

    AddCommand(
        "spotilast",
        "goes to the last song on spotify",
        0,
        {"spoti"},
        function()
            local succ, err =
                pcall(
                function()
                    syn.request(getgenv().requests["LastSong"])
                end
            )
            if err then
                notify("Spotify api not unlocked..")
            end
        end
    )

    AddCommand(
        "amongus",
        "susifies you",
        0,
        {"susify", "amogus"},
        function()
            function weldit(part0, part1, offset)
                a0 = Instance.new("Attachment", part0)
                if offset then
                    a0.Position = offset
                end
                a1 = Instance.new("Attachment", part1)
                a2 = Instance.new("Attachment", part0)
                part0.AlignPosition.Attachment0 = a0
                part0.AlignPosition.Attachment1 = a1
                part0.AlignOrientation.Attachment0 = a2
                part0.AlignOrientation.Attachment1 = a1
            end
            function align(part)
                alignPosition = Instance.new("AlignPosition", part)
                alignPosition.RigidityEnabled = false
                alignPosition.ApplyAtCenterOfMass = false
                alignPosition.MaxForce = 9e35
                alignPosition.MaxVelocity = 9e99
                alignPosition.ReactionForceEnabled = false
                alignPosition.Responsiveness = 9e99
                alignOr = Instance.new("AlignOrientation", part)
                alignOr.MaxTorque = 9e99
                alignOr.MaxAngularVelocity = 9e99
                alignOr.PrimaryAxisOnly = false
                alignOr.ReactionTorqueEnabled = false
                alignOr.Responsiveness = 200
                alignOr.RigidityEnabled = false
            end
            notify("Susifying you..")
            local succ, err =
                pcall(
                function()
                    for i, v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
                        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                            RunService.Heartbeat:connect(
                                function()
                                    Player.Character["Left Arm"].Velocity = Vector3.new(0, 45.005, 0)
                                    Player.Character["Right Arm"].Velocity = Vector3.new(0, 45.005, 0)
                                end
                            )
                        end
                    end
                    if Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
                        align(Player.Character["Left Arm"])
                        align(Player.Character["Right Arm"])
                        Player.Character["Torso"]["Right Shoulder"]:Destroy()
                        weldit(Player.Character["Right Arm"], Player.Character.Torso, Vector3.new(0.3, 0, -1))
                        Player.Character["Torso"]["Left Shoulder"]:Destroy()
                        weldit(Player.Character["Left Arm"], Player.Character.Torso, Vector3.new(-0.3, 0, -1))
                    elseif Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
                        notify("R6 only!")
                    end
                    Player.Character.Head.Mesh:Destroy()
                end
            )
            if err then
                notify("Uh oh, something went wrong.")
            end
        end
    )

    AddCommand(
        "nolegs",
        "removes your legs",
        0,
        {},
        function()
            notify("Removing legs..")
            local succ, err =
                pcall(
                function()
                    if Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
                        Player.Character["Left Leg"]:Destroy()
                        Player.Character["Right Leg"]:Destroy()
                    elseif Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
                        Player.Character["LeftUpperLeg"]:Destroy()
                        Player.Character["RightUpperLeg"]:Destroy()
                    end
                end
            )
            if err then
                notify("Uh oh, something went wrong.")
            end
        end
    )

    AddCommand(
        "nolimbs",
        "removes your limbs",
        0,
        {},
        function()
            notify("Removing limbs..")
            local succ, err =
                pcall(
                function()
                    if Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
                        Player.Character["Left Arm"]:Destroy()
                        Player.Character["Right Arm"]:Destroy()
                        Player.Character["Left Leg"]:Destroy()
                        Player.Character["Right Leg"]:Destroy()
                    elseif Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
                        Player.Character["LeftUpperArm"]:Destroy()
                        Player.Character["RightUpperArm"]:Destroy()
                        Player.Character["LeftUpperLeg"]:Destroy()
                        Player.Character["RightUpperLeg"]:Destroy()
                    end
                end
            )
            if err then
                notify("Uh oh, something went wrong.")
            end
        end
    )

    AddCommand(
        "freezeanims",
        "freezes animations",
        0,
        {"freezeanim"},
        function()
            notify("Freezing animations..")
            local ActiveTracks = Player.Character.Humanoid:GetPlayingAnimationTracks()
            for _, v in pairs(ActiveTracks) do
                v:AdjustSpeed(0)
            end
        end
    )

    AddCommand(
        "unfreezeanims",
        "freezes animations",
        0,
        {"unfreezeanim"},
        function()
            notify("Unfreezing animations..")
            local ActiveTracks = Player.Character.Humanoid:GetPlayingAnimationTracks()
            for _, v in pairs(ActiveTracks) do
                v:AdjustSpeed(1)
            end
        end
    )

    AddCommand(
        "setfps",
        "sets your fps cap to arg",
        1,
        {"setfpscap"},
        function(fps)
            if setfpscap then
                setfpscap(fps)
                notify("Set fps cap to " .. fps .. ".")
            else
                notify("Exploit does not support setfpscap")
            end
        end
    )

    AddCommand(
        "grab",
        "Grabs Player [tool required]",
        0,
        {"grabknife", "gk"},
        function(playerx)
            local Target = playerx
            local Character = Player.Character
            local PlayerGui = Player:WaitForChild("PlayerGui")
            local Backpack = Player:WaitForChild("Backpack")
            local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
            local RootPart = Character and Humanoid and Humanoid.RootPart or false
            local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
            if not Humanoid or not RootPart or not RightArm then
                return
            end

            local AnimationIds = {
                ["Grab"] = {
                    ["R6"] = 35978879,
                    ["R15"] = 4210116953
                },
                ["Kill"] = {
                    ["R6"] = 204062532,
                    ["R15"] = 3338083565
                }
            }

            local GetPlayer = GetPlayer
            local CreateRightGrip = function(Tool)
                if Tool and RightArm then
                    local Handle = Tool and Tool:FindFirstChild("Handle") or false
                    if Handle then
                        local Weld = Instance.new("Weld")
                        Weld.Name = "RightGrip"
                        Weld.Part0 = RightArm
                        Weld.Part1 = Handle
                        if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                            Weld.C0 = CFrame.new(0, -2, 0) * CFrame.Angles(math.rad(-110), 0, math.rad(45))
                        else
                            --math.rad(-90)
                            Weld.C0 = CFrame.new(2, -1, 1) * CFrame.Angles(math.rad(-90), math.rad(-25), math.rad(-110))
                        end
                        Weld.C1 = Tool.Grip
                        Weld.Parent = RightArm
                        return Weld
                    end
                end
            end

            Humanoid:UnequipTools()
            local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
            if not MainTool or not MainTool:FindFirstChild("Handle") then
                return
            end

            local TPlayer = GetPlayer(Target)
            local TCharacter = TPlayer and TPlayer.Character

            local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
            local RootPart = Character and Humanoid and Humanoid.RootPart or false
            local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
            if not Humanoid or not RootPart or not RightArm then
                return
            end

            local AnimationIds = {
                ["Grab"] = {
                    ["R6"] = 35978879,
                    ["R15"] = 4210116953
                },
                ["Kill"] = {
                    ["R6"] = 204062532,
                    ["R15"] = 3338083565
                }
            }


            local CreateRightGrip = function(Tool)
                if Tool and RightArm then
                    local Handle = Tool and Tool:FindFirstChild("Handle") or false
                    if Handle then
                        local Weld = Instance.new("Weld")
                        Weld.Name = "RightGrip"
                        Weld.Part0 = RightArm
                        Weld.Part1 = Handle
                        if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                            Weld.C0 = CFrame.new(0, -2, 0) * CFrame.Angles(math.rad(-110), 0, math.rad(45))
                        else
                            --math.rad(-90)
                            Weld.C0 = CFrame.new(2, -1, 1) * CFrame.Angles(math.rad(-90), math.rad(-25), math.rad(-110))
                        end
                        Weld.C1 = Tool.Grip
                        Weld.Parent = RightArm
                        return Weld
                    end
                end
            end

            Humanoid:UnequipTools()
            local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
            if not MainTool or not MainTool:FindFirstChild("Handle") then
                return
            end

            local TPlayer = GetPlayer(Target)
            local TCharacter = TPlayer and TPlayer.Character

            local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
            local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
            if not THumanoid or not TRootPart then
                return
            end

            if Character:FindFirstChild("Animate") then
                Character:FindFirstChild("Animate").Disabled = true
            end
            for _, x in next, Humanoid:GetPlayingAnimationTracks() do
                x:Stop()
            end
            CreateRightGrip(MainTool)
            MainTool.Parent = Character
            MainTool.Handle:BreakJoints()
            MainTool.Parent = Backpack
            MainTool.Parent = Humanoid
            CreateRightGrip(MainTool)
            THumanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
            THumanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
            if firetouchinterest then
                firetouchinterest(MainTool.Handle, TRootPart, 0)
                firetouchinterest(MainTool.Handle, TRootPart, 1)
            else
                if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                    local OldCFrame = RootPart.CFrame
                    local OldTick = tick()
                    repeat
                        task.wait()
                        RootPart.CFrame = TRootPart.CFrame * CFrame.new(0, 2, 2)
                        if MainTool.Parent ~= Humanoid then
                            break
                        end
                    until (tick() - OldTick) > 3
                    RootPart.CFrame = OldCFrame
                else
                    return
                end
            end

            
            local MainAnimation = Instance.new("Animation", Humanoid)
            local Animation
            local WaitTime
            if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                MainAnimation.AnimationId = "rbxassetid://" .. AnimationIds["Grab"]["R6"]
                Animation = Humanoid:LoadAnimation(MainAnimation)
                WaitTime = .1
            else
                CS =
                    RunService.Heartbeat:Connect(
                    function()
                        if Humanoid then
                            if Humanoid.Health > 0 then
                                Humanoid:ChangeState("GettingUp")
                            end
                        else
                            CS:Disconnect()
                        end
                    end
                )
                MainAnimation.AnimationId = "rbxassetid://" .. AnimationIds["Grab"]["R15"]
                Animation = Humanoid:LoadAnimation(MainAnimation)
                WaitTime = .25
            end
            Animation.Looped = false
            Animation:Play()
            task.wait(WaitTime)
            Animation:AdjustSpeed(0)

            local KillTPlayer
            KillTPlayer =
                UserInputService.InputBegan:Connect(
                function(Input, GameProcessed)
                    if not GameProcessed and Input.KeyCode == Enum.KeyCode.K then
                        KillTPlayer:Disconnect()
                        local KillAnimation = Instance.new("Animation")
                        if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                            KillAnimation.AnimationId = "rbxassetid://" .. AnimationIds["Kill"]["R6"]
                        else
                            KillAnimation.AnimationId = "rbxassetid://" .. AnimationIds["Kill"]["R15"]
                        end
                        KillAnimation.Parent = Humanoid
                        local Animation = Humanoid:LoadAnimation(KillAnimation)
                        Animation:Play()
                        RootPart.Anchored = true
                        Animation:AdjustSpeed(1)
                        task.wait(1)
                        RootPart.Anchored = false
                        Player.Character = nil
                        Humanoid.Health = 0
                        Character:BreakJoints()
                    elseif not GameProcessed and Input.KeyCode == Enum.KeyCode.E then
                        Animation:Stop()
                        if CS then
                        CS:Disconnect()
                        end
                        KillTPlayer:Disconnect()
                        if Character:FindFirstChild("Animate") then
                            Character:FindFirstChild("Animate").Disabled = false
                        end
                        if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                            Character["Right Arm"].RightGrip:Destroy()
                        else
                            Character["RightHand"].RightGripAttachment:Destroy()
                            Character["RightHand"].RightGrip:Destroy()
                        end
                    end
                end
            )
            notify("Press K to kill")
            wait(1)
            notify("Press E to drop")
        end
    )

    AddCommand(
        "bring",
        "Carrys player [tool required]",
        0,
        {},
        function(playerx)
            local Target = playerx
            local Character = Player.Character
            local PlayerGui = Player:WaitForChild("PlayerGui")
            local Backpack = Player:WaitForChild("Backpack")
            local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
            local RootPart = Character and Humanoid and Humanoid.RootPart or false
            local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
            if not Humanoid or not RootPart or not RightArm then
                return
            end

            local GetPlayer = GetPlayer
            local CreateRightGrip = function(Tool)
                if Tool and RightArm then
                    local Handle = Tool and Tool:FindFirstChild("Handle") or false
                    if Handle then
                        local Weld = Instance.new("Weld")
                        Weld.Name = "RightGrip"
                        Weld.Part0 = RightArm
                        Weld.Part1 = Handle
                        Weld.C0 = CFrame.new(0, 0, 0)
                        Weld.C1 = Tool.Grip
                        Weld.Parent = RightArm
                        return Weld
                    end
                end
            end

            Humanoid:UnequipTools()
            local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
            if not MainTool or not MainTool:FindFirstChild("Handle") then
                return
            end

            local TPlayer = GetPlayer(Target)
            local TCharacter = TPlayer and TPlayer.Character

            local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
            local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
            if not THumanoid or not TRootPart then
                return
            end

            CreateRightGrip(MainTool)
            MainTool.Parent = Character
            MainTool.Handle:BreakJoints()
            MainTool.Parent = Backpack
            MainTool.Parent = Humanoid
            CreateRightGrip(MainTool)
            if firetouchinterest then
                THumanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
                THumanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
                firetouchinterest(MainTool.Handle, TRootPart, 0)
                firetouchinterest(MainTool.Handle, TRootPart, 1)
                MainTool.Handle.AncestryChanged:Wait()
                wait(.3)
                if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                    Character["Right Arm"].RightGrip:Destroy()
                else
                    Character["RightHand"].RightGripAttachment:Destroy()
                    Character["RightHand"].RightGrip:Destroy()
                end
            else
                if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                    local OldCFrame = RootPart.CFrame
                    local OldTick = tick()
                    repeat
                        task.wait()
                        RootPart.CFrame = TRootPart.CFrame * CFrame.new(0, 2, 2)
                        if MainTool.Parent ~= Humanoid then
                            break
                        end
                    until (tick() - OldTick) > 3
                    RootPart.CFrame = OldCFrame
                else
                    return
                end
            end
        end
    )

    AddCommand(
        "void",
        "Voids player [tool required]",
        0,
        {"instantvoid", "vkill","kill2"},
        function(playerx)
            local Target = playerx
            local Character = Player.Character
            local PlayerGui = Player:WaitForChild("PlayerGui")
            local Backpack = Player:WaitForChild("Backpack")
            local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
            local RootPart = Character and Humanoid and Humanoid.RootPart or false
            local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
            if not Humanoid or not RootPart or not RightArm then
                return
            end

            local GetPlayer = GetPlayer
            local CreateRightGrip = function(Tool)
                if Tool and RightArm then
                    local Handle = Tool and Tool:FindFirstChild("Handle") or false
                    if Handle then
                        local Weld = Instance.new("Weld")
                        Weld.Name = "RightGrip"
                        Weld.Part0 = RightArm
                        Weld.Part1 = Handle
                        Weld.C0 = CFrame.new(0, workspace.FallenPartsDestroyHeight * 3, 0)
                        Weld.C1 = Tool.Grip
                        Weld.Parent = RightArm
                        return Weld
                    end
                end
            end

            Humanoid:UnequipTools()
            local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
            if not MainTool or not MainTool:FindFirstChild("Handle") then
                return
            end

            local TPlayer = GetPlayer(Target)
            local TCharacter = TPlayer and TPlayer.Character

            local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
            local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
            if not THumanoid or not TRootPart then
                return
            end
            CreateRightGrip(MainTool)
            MainTool.Parent = Character
            MainTool.Handle:BreakJoints()
            MainTool.Parent = Backpack
            MainTool.Parent = Humanoid
            CreateRightGrip(MainTool)
            THumanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
            THumanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
            wait(.1)
            if firetouchinterest then
                firetouchinterest(MainTool.Handle, TRootPart, 0)
                firetouchinterest(MainTool.Handle, TRootPart, 1)
                MainTool.Handle.AncestryChanged:Wait()
                wait(.3)
                if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                    Character["Right Arm"].RightGrip:Destroy()
                else
                    Character["RightHand"].RightGrip:Destroy()
                    Character["RightHand"].RightGripAttachment:Destroy()
                end
            else
                if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                    local OldCFrame = RootPart.CFrame
                    local OldTick = tick()
                    repeat
                        task.wait()
                        RootPart.CFrame = TRootPart.CFrame * CFrame.new(0, 2, 2)
                        if MainTool.Parent ~= Humanoid then
                            break
                        end
                    until (tick() - OldTick) > 3
                    RootPart.CFrame = OldCFrame
                else
                    return
                end
            end
        end
    )

    AddCommand(
        "fakechat",
        "fake chats as a user with specified message (you need to chat too)",
        3,
        {"falsechat"},
        function(user, chat, ychat)
            notify("Faking chat..")
            local A_1 =
                ychat ..
                "                                                                                                                                              " ..
                    "[" .. user .. "]" .. ":" .. "" .. " " .. chat
            local A_2 = "All"
            local Event = ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest
            Event:FireServer(A_1, A_2)
        end
    )

    AddCommand(
        "2007anims",
        "changes your characters animations to 2007 animations",
        0,
        {"2007anim"},
        function()
            loadstring(
                game:HttpGet(
                    ("https://raw.githubusercontent.com/mgamingpro/HomebrewAdmin/master/scripts/2007anims.lua"),
                    true
                )
            )()
        end
    )

    AddCommand(
        "r15v2",
        "gives you v2 r15 animations from 2016",
        0,
        {},
        function()
            if Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
                notify("Loading V2 R15 Animations..")
                Player.Character.Animate:Destroy()
                local a = game:GetObjects("rbxassetid://6816103163")[1]
                local function b()
                    local c = Instance.new("LocalScript", Close)
                    c.Name = "Animate"
                    c.Parent = Player.Character
                    for d, e in next, a:GetDescendants() do
                        if e:IsA("StringValue") then
                            e.Parent = c
                        end
                    end
                    function waitForChild(f, g)
                        local h = nil
                        local i = f:findFirstChild(g)
                        if i then
                            return i
                        end
                        while true do
                            h = f.ChildAdded:wait()
                            if h.Name == g then
                                break
                            end
                        end
                        return h
                    end
                    local j = c.Parent
                    local k = waitForChild(j, "Humanoid")
                    k.CameraOffset = Vector3.new(0, 0.5, 0)
                    math.randomseed(tick())
                    local l = {}
                    function configureAnimationSet(m, n)
                        if l[m] ~= nil then
                            local o, p, q = pairs(l[m].connections)
                            while true do
                                local r, s = o(p, q)
                                if r then
                                else
                                    break
                                end
                                q = r
                                s:disconnect()
                            end
                        end
                        l[m] = {}
                        l[m].count = 0
                        l[m].totalWeight = 0
                        l[m].connections = {}
                        local t = c:FindFirstChild(m)
                        if t ~= nil then
                            table.insert(
                                l[m].connections,
                                t.ChildAdded:connect(
                                    function(u)
                                        configureAnimationSet(m, n)
                                    end
                                )
                            )
                            table.insert(
                                l[m].connections,
                                t.ChildRemoved:connect(
                                    function(v)
                                        configureAnimationSet(m, n)
                                    end
                                )
                            )
                            local w = 1
                            local x, y, z = pairs(t:GetChildren())
                            while true do
                                local A, B = x(y, z)
                                if A then
                                else
                                    break
                                end
                                z = A
                                if B:IsA("Animation") then
                                    table.insert(
                                        l[m].connections,
                                        B.Changed:connect(
                                            function(C)
                                                configureAnimationSet(m, n)
                                            end
                                        )
                                    )
                                    l[m][w] = {}
                                    l[m][w].anim = B
                                    local D = B:FindFirstChild("Weight")
                                    if D == nil then
                                        l[m][w].weight = 1
                                    else
                                        l[m][w].weight = D.Value
                                    end
                                    l[m].count = l[m].count + 1
                                    l[m].totalWeight = l[m].totalWeight + l[m][w].weight
                                    w = w + 1
                                end
                            end
                        end
                        if l[m].count <= 0 then
                            local E, F, G = pairs(n)
                            while true do
                                local H, I = E(F, G)
                                if H then
                                else
                                    break
                                end
                                G = H
                                l[m][H] = {}
                                l[m][H].anim = Instance.new("Animation")
                                l[m][H].anim.Name = m
                                l[m][H].anim.AnimationId = I.id
                                l[m][H].weight = I.weight
                                l[m].count = l[m].count + 1
                                l[m].totalWeight = l[m].totalWeight + I.weight
                            end
                        end
                    end
                    local J = {
                        idle = {
                            {id = "rbxasset://R15021216/idle_stretch.xml", weight = 1},
                            {id = "rbxasset://R15021216/idle_look.xml", weight = 1},
                            {id = "rbxasset://R15021216/idle.xml", weight = 9}
                        },
                        walk = {{id = "rbxasset://R15021216/run.xml", weight = 10}},
                        run = {{id = "rbxasset://R15021216/run.xml", weight = 10}},
                        jump = {{id = "rbxasset://R15021216/jump.xml", weight = 10}},
                        fall = {{id = "rbxasset://R15021216/falling.xml", weight = 10}},
                        climb = {{id = "rbxasset://R15021216/climb.xml", weight = 10}},
                        sit = {{id = "http://www.roblox.com/asset/?id=393915321", weight = 10}},
                        toolnone = {{id = "http://www.roblox.com/asset/?id=393915542", weight = 10}},
                        toolslash = {{id = "http://www.roblox.com/asset/?id=393915542", weight = 10}},
                        toollunge = {{id = "http://www.roblox.com/asset/?id=393915542", weight = 10}},
                        wave = {{id = "http://www.roblox.com/asset/?id=393915710", weight = 10}},
                        point = {{id = "http://www.roblox.com/asset/?id=393915866", weight = 10}},
                        dance = {
                            {id = "http://www.roblox.com/asset/?id=393916260", weight = 10},
                            {id = "http://www.roblox.com/asset/?id=393916456", weight = 10},
                            {id = "http://www.roblox.com/asset/?id=393916635", weight = 10}
                        },
                        dance2 = {
                            {id = "http://www.roblox.com/asset/?id=393916791", weight = 10},
                            {id = "http://www.roblox.com/asset/?id=393916989", weight = 10},
                            {id = "http://www.roblox.com/asset/?id=393917195", weight = 10}
                        },
                        dance3 = {
                            {id = "http://www.roblox.com/asset/?id=393917375", weight = 10},
                            {id = "http://www.roblox.com/asset/?id=393917556", weight = 10},
                            {id = "http://www.roblox.com/asset/?id=393917721", weight = 10}
                        },
                        laugh = {{id = "http://www.roblox.com/asset/?id=393916166", weight = 10}},
                        cheer = {{id = "http://www.roblox.com/asset/?id=393916016", weight = 10}}
                    }
                    function scriptChildModified(K)
                        local L = J[K.Name]
                        if L ~= nil then
                            configureAnimationSet(K.Name, L)
                        end
                    end
                    c.ChildAdded:connect(scriptChildModified)
                    c.ChildRemoved:connect(scriptChildModified)
                    for M, N in pairs(J) do
                        configureAnimationSet(M, N)
                    end
                    local O = ""
                    local P = {
                        wave = false,
                        point = false,
                        dance = true,
                        dance2 = true,
                        dance3 = true,
                        laugh = false,
                        cheer = false
                    }
                    local Q = nil
                    local R = nil
                    local S = nil
                    function stopAllAnimations()
                        local T = O
                        if P[T] ~= nil then
                            if P[T] == false then
                                T = "idle"
                            end
                        end
                        O = ""
                        Q = nil
                        if R ~= nil then
                            R:disconnect()
                        end
                        if S ~= nil then
                            S:Stop()
                            S:Destroy()
                            S = nil
                        end
                        return T
                    end
                    local U = 1
                    function setAnimationSpeed(V)
                        if V ~= U then
                            U = V
                            S:AdjustSpeed(U)
                        end
                    end
                    function keyFrameReachedFunc(W)
                        if W == "End" then
                            local X = O
                            if P[X] ~= nil then
                                if P[X] == false then
                                    X = "idle"
                                end
                            end
                            playAnimation(X, 0.15, k)
                            setAnimationSpeed(U)
                        end
                    end
                    function playAnimation(Y, Z, _)
                        local a0 = math.random(1, l[Y].totalWeight)
                        local a1 = 1
                        while true do
                            if l[Y][a1].weight < a0 then
                            else
                                break
                            end
                            a0 = a0 - l[Y][a1].weight
                            a1 = a1 + 1
                        end
                        local a2 = l[Y][a1].anim
                        if a2 ~= Q then
                            if S ~= nil then
                                S:Stop(Z)
                                S:Destroy()
                            end
                            U = 1
                            S = _:LoadAnimation(a2)
                            S:Play(Z)
                            O = Y
                            Q = a2
                            if R ~= nil then
                                R:disconnect()
                            end
                            R = S.KeyframeReached:connect(keyFrameReachedFunc)
                        end
                    end
                    local a3 = ""
                    function toolKeyFrameReachedFunc(a4)
                        if a4 == "End" then
                            playToolAnimation(a3, 0, k)
                        end
                    end
                    local a5 = nil
                    local a6 = nil
                    local a7 = nil
                    function playToolAnimation(a8, a9, aa)
                        local ab = math.random(1, l[a8].totalWeight)
                        local ac = 1
                        while true do
                            if l[a8][ac].weight < ab then
                            else
                                break
                            end
                            ab = ab - l[a8][ac].weight
                            ac = ac + 1
                        end
                        local ad = l[a8][ac].anim
                        if a5 ~= ad then
                            if a6 ~= nil then
                                a6:Stop()
                                a6:Destroy()
                                a9 = 0
                            end
                            a6 = aa:LoadAnimation(ad)
                            a6:Play(a9)
                            a3 = a8
                            a5 = ad
                            a7 = a6.KeyframeReached:connect(toolKeyFrameReachedFunc)
                        end
                    end
                    function stopToolAnimations()
                        if a7 ~= nil then
                            a7:disconnect()
                        end
                        a3 = ""
                        a5 = nil
                        if a6 ~= nil then
                            a6:Stop()
                            a6:Destroy()
                            a6 = nil
                        end
                        return a3
                    end
                    local ae = "Standing"
                    function onRunning(af)
                        if 0.01 < af then
                        else
                            playAnimation("idle", 0.1, k)
                            ae = "Standing"
                            return
                        end
                        playAnimation("walk", 0.1, k)
                        setAnimationSpeed(af / 15)
                        ae = "Running"
                    end
                    function onDied()
                        ae = "Dead"
                    end
                    local ag = 0
                    function onJumping()
                        playAnimation("jump", 0.1, k)
                        ag = 0.31
                        ae = "Jumping"
                    end
                    function onClimbing(ah)
                        playAnimation("climb", 0.1, k)
                        setAnimationSpeed(ah / 2)
                        ae = "Climbing"
                    end
                    function onGettingUp()
                        ae = "GettingUp"
                    end
                    function onFreeFall()
                        if ag <= 0 then
                            playAnimation("fall", 0.2, k)
                        end
                        ae = "FreeFall"
                    end
                    function onFallingDown()
                        ae = "FallingDown"
                    end
                    function onSeated()
                        ae = "Seated"
                    end
                    function onPlatformStanding()
                        ae = "PlatformStanding"
                    end
                    function onSwimming(ai)
                        if 0 < ai then
                            ae = "Running"
                            return
                        end
                        ae = "Standing"
                    end
                    function getTool()
                        local aj, ak, al = ipairs(j:GetChildren())
                        while true do
                            local am, an = aj(ak, al)
                            if am then
                            else
                                break
                            end
                            al = am
                            if an.className == "Tool" then
                                return an
                            end
                        end
                        return nil
                    end
                    function getToolAnim(ao)
                        local ap, aq, ar = ipairs(ao:GetChildren())
                        while true do
                            local as, at = ap(aq, ar)
                            if as then
                            else
                                break
                            end
                            ar = as
                            if at.Name == "toolanim" then
                                if at.className == "StringValue" then
                                    return at
                                end
                            end
                        end
                        return nil
                    end
                    local au = "None"
                    function animateTool()
                        if au == "None" then
                            playToolAnimation("toolnone", 0.1, k)
                            return
                        end
                        if au == "Slash" then
                            playToolAnimation("toolslash", 0, k)
                            return
                        end
                        if au == "Lunge" then
                        else
                            return
                        end
                        playToolAnimation("toollunge", 0, k)
                    end
                    function moveSit()
                        RightShoulder.MaxVelocity = 0.15
                        LeftShoulder.MaxVelocity = 0.15
                        RightShoulder:SetDesiredAngle(1.57)
                        LeftShoulder:SetDesiredAngle(-1.57)
                        RightHip:SetDesiredAngle(1.57)
                        LeftHip:SetDesiredAngle(-1.57)
                    end
                    local av = 0
                    local aw = 0
                    function move(ax)
                        av = ax
                        if 0 < ag then
                            ag = ag - (ax - av)
                        end
                        if ae == "FreeFall" then
                            if ag <= 0 then
                                playAnimation("fall", 0.2, k)
                            else
                                if ae == "Seated" then
                                    playAnimation("sit", 0.5, k)
                                    return
                                end
                                if ae == "Running" then
                                    playAnimation("walk", 0.1, k)
                                elseif ae ~= "Dead" then
                                    if ae ~= "GettingUp" then
                                        if ae ~= "FallingDown" then
                                            if ae ~= "Seated" then
                                                if ae == "PlatformStanding" then
                                                    stopAllAnimations()
                                                end
                                            else
                                                stopAllAnimations()
                                            end
                                        else
                                            stopAllAnimations()
                                        end
                                    else
                                        stopAllAnimations()
                                    end
                                else
                                    stopAllAnimations()
                                end
                            end
                        else
                            if ae == "Seated" then
                                playAnimation("sit", 0.5, k)
                                return
                            end
                            if ae == "Running" then
                                playAnimation("walk", 0.1, k)
                            elseif ae ~= "Dead" then
                                if ae ~= "GettingUp" then
                                    if ae ~= "FallingDown" then
                                        if ae ~= "Seated" then
                                            if ae == "PlatformStanding" then
                                                stopAllAnimations()
                                            end
                                        else
                                            stopAllAnimations()
                                        end
                                    else
                                        stopAllAnimations()
                                    end
                                else
                                    stopAllAnimations()
                                end
                            else
                                stopAllAnimations()
                            end
                        end
                        local ay = getTool()
                        if ay then
                        else
                            stopToolAnimations()
                            au = "None"
                            a5 = nil
                            aw = 0
                            return
                        end
                        animStringValueObject = getToolAnim(ay)
                        if animStringValueObject then
                            au = animStringValueObject.Value
                            animStringValueObject.Parent = nil
                            aw = ax + 0.3
                        end
                        if aw < ax then
                            aw = 0
                            au = "None"
                        end
                        animateTool()
                    end
                    k.Died:connect(onDied)
                    k.Running:connect(onRunning)
                    k.Jumping:connect(onJumping)
                    k.Climbing:connect(onClimbing)
                    k.GettingUp:connect(onGettingUp)
                    k.FreeFalling:connect(onFreeFall)
                    k.FallingDown:connect(onFallingDown)
                    k.Seated:connect(onSeated)
                    k.PlatformStanding:connect(onPlatformStanding)
                    k.Swimming:connect(onSwimming)
                    Player.Chatted:connect(
                        function(az)
                            local aA = ""
                            if string.sub(az, 1, 3) == "/e " then
                                aA = string.sub(az, 4)
                            elseif string.sub(az, 1, 7) == "/emote " then
                                aA = string.sub(az, 8)
                            end
                            if ae == "Standing" and P[aA] ~= nil then
                                playAnimation(aA, 0.1, k)
                            end
                        end
                    )
                    local aB = game:service("RunService")
                    playAnimation("idle", 0.1, k)
                    ae = "Standing"
                    while j.Parent ~= nil do
                        local aC, aD = wait(0.1)
                        move(aD)
                    end
                end
                coroutine.wrap(b)()
            else
                notify("Must be R15.")
            end
        end
    )

    AddCommand(
        "rtools",
        "Drops all tools.",
        0,
        {"droptools", "dtools"},
        function()
            pcall(
                function()
                    Player.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
                    Player.Backpack:ClearAllChildren()
                end
            )
        end
    )

    AddCommand(
        "whisper",
        "sends a pm to specified player with specified text",
        2,
        {},
        function(player, text)
            user = GetPlayer(player)
            plr = user.Name
            notify("Whispering to " .. plr .. ", " .. text .. ".")
            whisper(user, text)
        end
    )

    AddCommand(
        "tornado",
        "Tornadoes specified player [TOOL REQUIRED]",
        1,
        {"cuff"},
        function(player)
            Target = player
            local function Message(MTitle, MText, Time)
                -- game:GetService("StarterGui"):SetCore("SendNotification",{Title = MTitle;Text = MText;Duration = Time;})
                notify(MText)
            end

            if not GetPlayer(Target) then
                return Message("Error", ">   Player does not exist.", 5)
            end

            repeat
                RunService.Heartbeat:wait()
            until GetPlayer(Target).Character and GetPlayer(Target).Character:FindFirstChildOfClass("Humanoid").Health > 0 or
                not GetPlayer(Target)

            local Player = game:GetService("Players").LocalPlayer
            local Character = Player.Character
            local Humanoid
            local HumanoidRootPart
            local Torso
            local Tool
            local Handle

            local TPlayer = GetPlayer(Target)
            local TCharacter = TPlayer.Character
            local THumanoid
            local THumanoidRootPart
            local TTorso

            if Character:FindFirstChild("HumanoidRootPart") then
                HumanoidRootPart = Character.HumanoidRootPart
            end
            if Character:FindFirstChild("Torso") then
                Torso = Character.Torso
            end
            if Character:FindFirstChildOfClass("Humanoid") then
                Humanoid = Character:FindFirstChildOfClass("Humanoid")
            end
            if Character:FindFirstChildOfClass("Tool") then
                Tool = Character:FindFirstChildOfClass("Tool")
            elseif Player.Backpack:FindFirstChildOfClass("Tool") and Humanoid then
                Tool = Player.Backpack:FindFirstChildOfClass("Tool")
                Humanoid:EquipTool(Player.Backpack:FindFirstChildOfClass("Tool"))
            end
            if Tool and Tool:FindFirstChild("Handle") then
                Handle = Tool.Handle
            end
            if TCharacter:FindFirstChild("HumanoidRootPart") then
                THumanoidRootPart = TCharacter.HumanoidRootPart
            end
            if TCharacter:FindFirstChild("Torso") then
                TTorso = TCharacter.Torso
            elseif TCharacter:FindFirstChild("UpperTorso") then
                TTorso = TCharacter.UpperTorso
            end
            if TCharacter:FindFirstChildOfClass("Humanoid") then
                THumanoid = Character:FindFirstChildOfClass("Humanoid")
            end
            if not HumanoidRootPart then
                Message("Error", ">   Missing HumanoidRootPart, Trying Torso.", 5)
                wait(1)
                if Torso then
                    Message("Succes", ">   Torso found.", 5)
                    wait(1)
                else
                    Message("Error", ">   Missing Torso")
                    return
                end
            end
            if Humanoid.RigType == Enum.HumanoidRigType.R15 then
                Message("Error", ">   This command doesn't work on R15.", 5)
                wait(1)
                return
            end
            if not Tool then
                Message("Error", ">   You have no tools.", 5)
                wait(1)
                return
            end
            if not Handle then
                Message("Error", ">   Tool doesn't have handle.", 5)
                wait(1)
                return
            end
            if not THumanoidRootPart then
                Message("Error", ">   Missing HumanoidRootPart on Target, Trying Torso.", 5)
                wait(1)
                if Torso then
                    Message("Succes", ">   Torso found on Target.", 5)
                    wait(1)
                else
                    Message("Error", ">   Missing Torso on Target", 5)
                    return
                end
            end

            local fun = Instance.new("BodyAngularVelocity")
            fun.Name = "funfunfun"
            fun.MaxTorque = Vector3.new(0, math.huge, 0)
            fun.AngularVelocity = Vector3.new(0, 50, 0)
            fun.Parent = Player.Character.HumanoidRootPart

            Humanoid:Destroy()
            local NewHumanoid = Instance.new("Humanoid", Character)
            NewHumanoid:UnequipTools()
            NewHumanoid:EquipTool(Tool)
            Tool.Parent = workspace

            repeat
                Tool.Grip = CFrame.new()
                Tool.Grip = Handle.CFrame:ToObjectSpace(TTorso.CFrame):Inverse()
                firetouchinterest(Handle, TTorso, 0)
                firetouchinterest(Handle, TTorso, 1)
                RunService.Heartbeat:wait()
            until Tool.Parent ~= Character
            NewHumanoid.WalkSpeed = 30
        end
    )

    AddCommand(
        "fling",
        "Flings specified target",
        1,
        {},
        function(play)
            if play == "all" then
                AllBool = true
            else
                TargetPlayer = GetPlayer(play)
                AllBool = false
            end
            function flingem(TargetPlayer)
                local Character = Player.Character
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                local RootPart = Humanoid and Humanoid.RootPart

                local TCharacter = TargetPlayer.Character
                local THumanoid
                local TRootPart
                local THead
                local Accessory
                local Handle

                if TCharacter:FindFirstChildOfClass("Humanoid") then
                    THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
                end
                if THumanoid and THumanoid.RootPart then
                    TRootPart = THumanoid.RootPart
                end
                if TCharacter:FindFirstChild("Head") then
                    THead = TCharacter.Head
                end
                if TCharacter:FindFirstChildOfClass("Accessory") then
                    Accessory = TCharacter:FindFirstChildOfClass("Accessory")
                end
                if Accessoy and Accessory:FindFirstChild("Handle") then
                    Handle = Accessory.Handle
                end

                if Character and Humanoid and RootPart then
                    --workspace.FallenPartsDestroyHeight =
                    if RootPart.Velocity.Magnitude < 50 then
                        OldPos = RootPart.CFrame
                    end
                    if THumanoid and THumanoid.Sit and not AllBool then
                        return Message("Error Occurred", "Targeting is sitting", 5) -- u can remove dis part if u want lol
                    end
                    if THead then
                        workspace.CurrentCamera.CameraSubject = THead
                    elseif not THead and Handle then
                        workspace.CurrentCamera.CameraSubject = Handle
                    elseif THumanoid and TRootPart then
                        workspace.CurrentCamera.CameraSubject = THumanoid
                    end
                    if not TCharacter:FindFirstChildWhichIsA("BasePart") then
                        return
                    end

                    local FPos = function(BasePart, Pos, Ang)
                        RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                        Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                        RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                        RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                    end

                    local SFBasePart = function(BasePart)
                        local TimeToWait = 2
                        local Time = tick()
                        local Angle = 0

                        repeat
                            if RootPart and THumanoid then
                                if BasePart.Velocity.Magnitude < 50 then
                                    Angle = Angle + 100

                                    FPos(
                                        BasePart,
                                        CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25,
                                        CFrame.Angles(math.rad(Angle), 0, 0)
                                    )
                                    task.wait()

                                    FPos(
                                        BasePart,
                                        CFrame.new(0, -1.5, 0) +
                                            THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25,
                                        CFrame.Angles(math.rad(Angle), 0, 0)
                                    )
                                    task.wait()

                                    FPos(
                                        BasePart,
                                        CFrame.new(2.25, 1.5, -2.25) +
                                            THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25,
                                        CFrame.Angles(math.rad(Angle), 0, 0)
                                    )
                                    task.wait()

                                    FPos(
                                        BasePart,
                                        CFrame.new(-2.25, -1.5, 2.25) +
                                            THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25,
                                        CFrame.Angles(math.rad(Angle), 0, 0)
                                    )
                                    task.wait()

                                    FPos(
                                        BasePart,
                                        CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,
                                        CFrame.Angles(math.rad(Angle), 0, 0)
                                    )
                                    task.wait()

                                    FPos(
                                        BasePart,
                                        CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,
                                        CFrame.Angles(math.rad(Angle), 0, 0)
                                    )
                                    task.wait()
                                else
                                    FPos(
                                        BasePart,
                                        CFrame.new(0, 1.5, THumanoid.WalkSpeed),
                                        CFrame.Angles(math.rad(90), 0, 0)
                                    )
                                    task.wait()

                                    FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                                    task.wait()

                                    FPos(
                                        BasePart,
                                        CFrame.new(0, 1.5, THumanoid.WalkSpeed),
                                        CFrame.Angles(math.rad(90), 0, 0)
                                    )
                                    task.wait()

                                    FPos(
                                        BasePart,
                                        CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25),
                                        CFrame.Angles(math.rad(90), 0, 0)
                                    )
                                    task.wait()

                                    FPos(
                                        BasePart,
                                        CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25),
                                        CFrame.Angles(0, 0, 0)
                                    )
                                    task.wait()

                                    FPos(
                                        BasePart,
                                        CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25),
                                        CFrame.Angles(math.rad(90), 0, 0)
                                    )
                                    task.wait()

                                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                                    task.wait()

                                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                                    task.wait()

                                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
                                    task.wait()

                                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                                    task.wait()
                                end
                            else
                                break
                            end
                        until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or
                            TargetPlayer.Parent ~= Players or
                            not TargetPlayer.Character == TCharacter or
                            THumanoid.Sit or
                            Humanoid.Health <= 0 or
                            tick() > Time + TimeToWait
                    end

                    workspace.FallenPartsDestroyHeight = 0 / 0

                    local BV = Instance.new("BodyVelocity")
                    BV.Name = "EpixVel"
                    BV.Parent = RootPart
                    BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
                    BV.MaxForce = Vector3.new(1 / 0, 1 / 0, 1 / 0)

                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

                    if TRootPart and THead then
                        if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                            SFBasePart(THead)
                        else
                            SFBasePart(TRootPart)
                        end
                    elseif TRootPart and not THead then
                        SFBasePart(TRootPart)
                    elseif not TRootPart and THead then
                        SFBasePart(THead)
                    elseif not TRootPart and not THead and Accessory and Handle then
                        SFBasePart(Handle)
                    else
                        return Message("Error Occurred", "Target is missing everything", 5)
                    end

                    BV:Destroy()
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                    workspace.CurrentCamera.CameraSubject = Humanoid

                    repeat
                        RootPart.CFrame = OldPos * CFrame.new(0, .5, 0)
                        Character:SetPrimaryPartCFrame(OldPos * CFrame.new(0, .5, 0))
                        Humanoid:ChangeState("GettingUp")
                        table.foreach(
                            Character:GetChildren(),
                            function(_, x)
                                if x:IsA("BasePart") then
                                    x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                                end
                            end
                        )
                        task.wait()
                    until (RootPart.Position - OldPos.p).Magnitude < 25
                else
                    return Message("Error Occurred", "Random error", 5)
                end
            end
            if AllBool == true then
                for _, x in next, Players:GetPlayers() do
                    flingem(x)
                end
            else
                flingem(TargetPlayer)
            end
        end
    )



    AddCommand(
        "loopkill",
        "Loop kills specified player [TOOL REQUIRED]",
        1,
        {"looptkill"},
        function(Arguments)
        LoopKill = true
        local CMD = GetCommand("tkill")
        CMD:Execute({Arguments})
    end)
                                

    AddCommand(
        "unloopkill",
        "Stops loop killing",
        0,
        {"unlooptkill"},
        function()
        LoopKill = false
    end)

    LoopKill = false
    AddCommand(
        "tkill",
        "kills specified player [TOOL REQUIRED]",
        1,
        {"kill"},
        function(Target)
        
        
        local function Message(MTitle,MText,Time)
            notify(MText)
        end
        
        local function Kill()
            if not GetPlayer(Target) then
                return Message("Error",">   Player does not exist.",5)
            end
            
            repeat game:GetService("RunService").Heartbeat:wait() until GetPlayer(Target).Character and GetPlayer(Target).Character:FindFirstChildOfClass("Humanoid") and GetPlayer(Target).Character:FindFirstChildOfClass("Humanoid").Health > 0
            local Character
            local Humanoid
            local RootPart
            local Tool
            local Handle
            
            local TPlayer = GetPlayer(Target)
            local TCharacter = TPlayer.Character
            local THumanoid
            local TRootPart
            
            if Player.Character ~= nil and Player.Character and Player.Character.Name == Player.Name then
                Character = Player.Character
            else
                return Message("Error",">   Missing Character")
            end
            if Character:FindFirstChildOfClass("Humanoid") then
                Humanoid = Character:FindFirstChildOfClass("Humanoid")
            else
                return Message("Error",">   Missing Humanoid")
            end
            if Humanoid and Humanoid.RootPart then
                RootPart = Humanoid.RootPart
            else
                return Message("Error",">   Missing RootPart")
            end
            if Character:FindFirstChildOfClass("Tool") then
                Tool = Character:FindFirstChildOfClass("Tool")
            elseif Player.Backpack:FindFirstChildOfClass("Tool") and Humanoid then
                Tool = Player.Backpack:FindFirstChildOfClass("Tool")
                Humanoid:EquipTool(Player.Backpack:FindFirstChildOfClass("Tool"))
            else
                return Message("Error",">   Missing Tool")
            end
            if Tool and Tool:FindFirstChild("Handle") then
                Handle = Tool.Handle
            else
                return Message("Error",">   Missing Tool's Handle")
            end
            
            --Target
            if TCharacter:FindFirstChildOfClass("Humanoid") then
                THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
            else
                return Message("Error",">   Missing Target Humanoid")
            end
            if THumanoid.RootPart then
                TRootPart = THumanoid.RootPart
            else
                return Message("Error",">   Missing Target RootPart")
            end
            
            if THumanoid.Sit then
                return Message("Error",">   Target is seated")
            end
            
            local OldCFrame = RootPart.CFrame
            
            Humanoid:Destroy()
            local NewHumanoid = Humanoid:Clone()
            NewHumanoid.Parent = Character
            NewHumanoid:UnequipTools()
            NewHumanoid:EquipTool(Tool)
            Tool.Parent = workspace
        
            local Timer = os.time()
        
            repeat
                if (TRootPart.CFrame.p - RootPart.CFrame.p).Magnitude < 500 then
                    Tool.Grip = CFrame.new()
                    Tool.Grip = Handle.CFrame:ToObjectSpace(TRootPart.CFrame):Inverse()
                end
                firetouchinterest(Handle,TRootPart,0)
                firetouchinterest(Handle,TRootPart,1)
                game:GetService("RunService").Heartbeat:wait()
            until Tool.Parent ~= Character or not TPlayer or not TRootPart or THumanoid.Health <= 0 or os.time() > Timer + .20
            Player.Character = nil
            NewHumanoid.Health = 0
            Player.CharacterAdded:wait()
            repeat game:GetService("RunService").Heartbeat:wait() until Player.Character:FindFirstChild("HumanoidRootPart")
            Player.Character.HumanoidRootPart.CFrame = OldCFrame
        end
        
        if not LoopKill then
            Kill()
        else
            while LoopKill == true do
                Kill()
            end
        end
        end
    )

    AddCommand(
        "antifling",
        "prevents people from flinging you but you keep collisions with objects",
        0,
        {},
        function()
            notify("Changing collisions..")
            plrs = Players
            function nocollision(prt, plr)
                for i, v in pairs(plr:GetDescendants()) do
                    if v:IsA("BasePart") then
                        e = Instance.new("NoCollisionConstraint", v)
                        e.Part0 = v
                        e.Part1 = prt
                    end
                end
            end
            for i, yes in pairs(Player.Character:GetDescendants()) do
                if yes:IsA("BasePart") then
                    if yes:IsA("BasePart") then
                        for i, v in pairs(plrs:GetDescendants()) do
                            if v:IsA("Player") then
                                nocollision(yes, v.Character)
                            end
                        end
                    end
                end
            end
        end
    )

    AddCommand(
        "unantifling",
        "gain back normal collisions",
        0,
        {},
        function()
            notify("Giving back normal collisions..")
            for i, v in pairs(workspace:GetDescendants()) do
                if v:IsA("NoCollisionConstraint") then
                    v:Destroy()
                end
            end
        end
    )
    AddCommand(
        "anim",
        "plays an animation",
        1,
        {"loadanim"},
        function(animid)
            Animate = Player.Character.Animate
            Anim = Instance.new("Animation")
            rbxasset = true
            local suc, err =
                pcall(
                function()
                    animid = Animate:FindFirstChild(animid):FindFirstChildOfClass("Animation").AnimationId
                end
            )
            if suc then
                rbxasset = false
            end
            print(animid)
            if rbxasset == true then
                notify("Playing animation id " .. animid .. "!")
                Anim.AnimationId = ("rbxassetid://" .. animid)
            else
                notify("Playing animation id" .. animid .. "!")
                Anim.AnimationId = (animid)
            end
            Hi = Player.Character.Humanoid:LoadAnimation(Anim)
            Hi:Play()
            Hi:AdjustSpeed(1)
        end
    )
    AddCommand(
        "dance",
        "plays a dance animation",
        0,
        {},
        function()
            local humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
            Anim = Instance.new("Animation")
            if humanoid.RigType == Enum.HumanoidRigType.R15 then
                r15dances = {4555808220, 4555782893, 3333432454, 4049037604}
                local value = math.random(1, #r15dances)
                picked_value = r15dances[value]
            else
                r6dances = {33796059, 429730430, 429730430, 45834924}
                local value = math.random(1, #r6dances)
                picked_value = r6dances[value]
            end
            notify("Playing dance animation! ID: " .. picked_value)
            Anim.AnimationId = ("rbxassetid://" .. picked_value)
            Hi = Player.Character.Humanoid:LoadAnimation(Anim)
            Hi:Play()
            Hi:AdjustSpeed(1)
        end
    )

    AddCommand(
        "undance",
        "stops the dance animation",
        0,
        {},
        function()
            notify("Undancing..")
            local ActiveTracks = Player.Character.Humanoid:GetPlayingAnimationTracks()
            for _, v in pairs(ActiveTracks) do
                v:Stop()
            end
        end
    )

    AddCommand(
        "ui",
        "changes ui to one of options",
        1,
        {"changeui"},
        function(name)
            if name == "v4" then
                ToCustomUI()
                loadstring(
                    game:HttpGetAsync("https://raw.githubusercontent.com/mgamingpro/HomebrewAdmin/master/uis/v4hbadmin.lua")
                )()
            elseif name == "normal" then
                ToCustomUI()
                createui()
            elseif name == "destroy" then
                ToCustomUI()
            elseif name == "custom" then
                ToCustomUI()
            end
        end
    )

    AddCommand(
        "stopanims",
        "stops the current playing anim tracks",
        0,
        {"stoptracks"},
        function()
            notify("Stopping animations..")
            local ActiveTracks = Player.Character.Humanoid:GetPlayingAnimationTracks()
            for _, v in pairs(ActiveTracks) do
                v:Stop()
            end
        end
    )

    AddCommand(
        "chat",
        "chats specified message",
        1,
        {},
        function(msg)
            notify("Chatting " .. msg .. "!")
            wait()
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("" .. msg, "All")
        end
    )

    AddCommand(
        "spinfling",
        "Spins you!",
        0,
        {},
        function()
            local fun = Instance.new("BodyAngularVelocity")
            fun.Name = "funfunfun"
            fun.MaxTorque = Vector3.new(0, math.huge, 0)
            fun.AngularVelocity = Vector3.new(0, 50, 0)
            fun.Parent = Player.Character.HumanoidRootPart
            notify("Flinging!")
        end
    )

    AddCommand(
        "unspinfling",
        "Stops you from spin flinging!",
        0,
        {},
        function()
            local succ, err =
                pcall(
                function()
                    Player.Character.HumanoidRootPart.funfunfun:Destroy()
                end
            )
            if err then
                notify("Something went wrong.")
            end
        end
    )

    AddCommand(
        "netlag",
        "Lag annoying network skids!",
        1,
        {},
        function(p)
            target = GetPlayer(p)
            notify("Lagging " .. target.Name .. "!")
            while RunService.Stepped:wait() do
                if target.Character then
                    for _, x in next, target.Character:GetDescendants() do
                        if x:IsA("BasePart") then
                            sethiddenproperty(x, "NetworkIsSleeping", true)
                            print("hi")
                        end
                    end
                end
            end
        end
    )

    AddCommand(
        "loopchat",
        "loop chats specified message",
        1,
        {},
        function(msg)
            notify("Loop chatting " .. msg .. "!")
            wait()
            getgenv().chattin = true
            chattin =
                RunService.Heartbeat:connect(
                function()
                    if getgenv().chattin == true then
                        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("" .. msg, "All")
                    else
                        chattin:Disconnect()
                    end
                end
            )
        end
    )

    AddCommand(
        "unloopchat",
        "unloop chats the previous message",
        0,
        {},
        function()
            notify("Unloop chatting!")
            getgenv().chattin = false
        end
    )
    AddCommand(
        "animspeed",
        "adjusts the current animation's speed",
        1,
        {"anispeed"},
        function(Speed)
            notify("Adjusting speed..")
            local ActiveTracks = Player.Character.Humanoid:GetPlayingAnimationTracks()
            for _, v in pairs(ActiveTracks) do
                v:AdjustSpeed(Speed)
            end
        end
    )

    AddCommand(
        "music",
        "players music [clientsided]",
        1,
        {},
        function(id)
            notify("Playing " .. id)
            music = Instance.new("Sound", Player.Character.HumanoidRootPart)
            music.Volume = 100
            music.TimePosition = 0
            music.PlaybackSpeed = 1
            music.Pitch = 1
            music.SoundId = ("rbxassetid://" .. id)
            music.Name = "wrecked"
            music.Looped = true
            music:Play()
        end
    )

    AddCommand(
        "nomusic",
        "stops playing music",
        0,
        {"unmusic"},
        function()
            local succ, err =
                pcall(
                function()
                    Player.Character.HumanoidRootPart.wrecked:Destroy()
                end
            )
            if succ then
                notify("Stoped playing music.")
            else
                notify("You aren't playing music!")
            end
        end
    )

    AddCommand(
        "changeprefix",
        "changes your prefix to specified key",
        1,
        {"newprefix", "prefixchange", "prefix"},
        function(symbol)
            if (symbol:match("%A")) then
                notify("Prefix set to: " .. symbol)
                Config:Update({prefix = symbol})
                fireui()
                preffire()
            else
                notify("Must be a symbol!")
            end
        end
    )

    AddCommand(
        "spotikey",
        "changes your spotify api key to specified text",
        1,
        {"spotifykey", "spotifyapikey"},
        function(k)
            notify("Updating key.. (renew after an hour)")
            keyfire(k)
        end
    )

    AddCommand(
        "rj",
        "rejoins your game",
        0,
        {"rejoin"},
        function()
            count = #Players:GetPlayers()
            if count <= 1 then
                game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
            else
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
            end
        end
    )

    AddCommand(
        "banish",
        "banishes player [needs tool]",
        1,
        {"punish", "stuckvoid"},
        function(name)
            user = GetPlayer(name)
            plr = user.name
            notify("Banishing " .. plr .. "!")
            Target = plr
            Player.Character.Humanoid.Name = 1
            local l = Player.Character["1"]:Clone()
            l.Parent = Player.Character
            l.Name = "Humanoid"
            wait()
            Player.Character["1"]:Destroy()
            game.Workspace.CurrentCamera.CameraSubject = Player.Character
            Player.Character.Animate.Disabled = true
            wait()
            Player.Character.Animate.Disabled = false
            Player.Character.Humanoid.DisplayDistanceType = "None"
            for i, v in pairs(game:GetService "Players".LocalPlayer.Backpack:GetChildren()) do
                Player.Character.Humanoid:EquipTool(v)
            end
            wait()
            Player.Character.HumanoidRootPart.CFrame = Players[Target].Character.HumanoidRootPart.CFrame
            wait()
            Player.Character.HumanoidRootPart.CFrame = Players[Target].Character.HumanoidRootPart.CFrame
            wait()
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-100000, 1000000000000000000000, -100000))
            wait()
            local prt = Instance.new("Model", workspace)
            Instance.new("Part", prt).Name = "Torso"
            Instance.new("Part", prt).Name = "Head"
            Instance.new("Humanoid", prt).Name = "Humanoid"
            Player.Character = prt
        end
    )


    AddCommand(
        "unbanish",
        "unbanishes player [needs tool]",
        1,
        {"unpunish", "unstuckvoid"},
        function(name)
            user = GetPlayer(name)
            plr = user.name
            notify("Unbanishing " .. plr .. "!")
            Target = plr
            Player.Character.Humanoid.Name = 1
            local l = Player.Character["1"]:Clone()
            l.Parent = Player.Character
            l.Name = "Humanoid"
            wait()
            Player.Character["1"]:Destroy()
            game.Workspace.CurrentCamera.CameraSubject = Player.Character
            Player.Character.Animate.Disabled = true
            wait()
            Player.Character.Animate.Disabled = false
            Player.Character.Humanoid.DisplayDistanceType = "None"
            for i, v in pairs(game:GetService "Players".LocalPlayer.Backpack:GetChildren()) do
                Player.Character.Humanoid:EquipTool(v)
            end
            wait()
            Player.Character.HumanoidRootPart.CFrame = Players[Target].Character.HumanoidRootPart.CFrame
            wait()
            Player.Character.HumanoidRootPart.CFrame = Players[Target].Character.HumanoidRootPart.CFrame
            wait()
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(0, 0, 0))
            wait()
            local prt = Instance.new("Model", workspace)
            Instance.new("Part", prt).Name = "Torso"
            Instance.new("Part", prt).Name = "Head"
            Instance.new("Humanoid", prt).Name = "Humanoid"
            Player.Character = prt
        end
    )

    AddCommand(
        "freefall",
        "freefalls player [needs tool]",
        1,
        {"skydive"},
        function(Target)

        local Character = Player.Character

        local PlayerGui = Player:WaitForChild("PlayerGui")
        local Backpack = Player:WaitForChild("Backpack")

        local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
        local RootPart = Character and Humanoid and Humanoid.RootPart or false
        local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
        if not Humanoid or not RootPart or not RightArm then
            return
        end


        local CreateRightGrip = function(Tool)
            if Tool and RightArm then
                local Handle = Tool and Tool:FindFirstChild("Handle") or false
                if Handle then
                    local Weld = Instance.new("Weld")
                    Weld.Name = "RightGrip"
                    Weld.Part0 = RightArm
                    Weld.Part1 = Handle
                    Weld.C0 = CFrame.new(0, 7000, -7)
                    Weld.C1 = Tool.Grip
                    Weld.Parent = RightArm
                    return Weld
                end
            end
        end

        Humanoid:UnequipTools()
        local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
        if not MainTool or not MainTool:FindFirstChild("Handle") then
            return
        end

        local TPlayer = GetPlayer(Target)
        local TCharacter = TPlayer and TPlayer.Character
        --workspace.CurrentCamera.CameraSubject = TCharacter
        local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
        local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
        if not THumanoid or not TRootPart then
            return
        end

        if Character:FindFirstChild("Animate") then
            Character:FindFirstChild("Animate").Disabled = true
        end
        for _, x in next, Humanoid:GetPlayingAnimationTracks() do
            x:Stop()
        end
        CreateRightGrip(MainTool)
        MainTool.Parent = Character
        MainTool.Handle:BreakJoints()
        MainTool.Parent = Backpack
        MainTool.Parent = Humanoid
        CreateRightGrip(MainTool)
        if firetouchinterest then
            firetouchinterest(MainTool.Handle, TRootPart, 0)
            firetouchinterest(MainTool.Handle, TRootPart, 1)
            MainTool.Handle.AncestryChanged:Wait()
            wait(.3)
            if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                Character["Right Arm"].RightGrip:Destroy()
            else
                Character["RightHand"].RightGripAttachment:Destroy()
                Character["RightHand"].RightGrip:Destroy()
            end
        else
            if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                local OldCFrame = RootPart.CFrame
                local OldTick = tick()
                repeat
                    task.wait()
                    RootPart.CFrame = TRootPart.CFrame * CFrame.new(0, 2, 2)
                    if MainTool.Parent ~= Humanoid then
                        break
                    end
                until (tick() - OldTick) > 3
                RootPart.CFrame = OldCFrame
            else
                return
            end
        end

        THumanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
        THumanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)


        if Character:FindFirstChild("Animate") then
            Character:FindFirstChild("Animate").Disabled = false
        end
        notify("Done.")
        end
    )

    AddCommand(
        "fly",
        "makes your character fly",
        0,
        {},
        function()
            --notify("Flying character..")
            _G.Flying = true

            local function Fly()
                Flying = true
                local Speed = 0
                local keys = {a = false, d = false, w = false, s = false}
                local Part = Instance.new("Part")
                local Weld = Instance.new("Weld", Part)
                Weld.Part0 = Part
                local Player = game:GetService("Players").LocalPlayer
                local Character = Player.Character
                repeat
                    RunService.Heartbeat:wait()
                until Character:FindFirstChildOfClass("Humanoid")
                local HumanoidRootPart = Character.Humanoid.RootPart
                Part.Parent = workspace
                Weld.Parent = Part
                Part.Size = HumanoidRootPart.Size
                Part.CanCollide = false
                Part.Transparency = 1
                Weld.Part1 = HumanoidRootPart

                local pos = Instance.new("BodyPosition", Part)
                local gyro = Instance.new("BodyGyro", Part)

                pos.Name = "homebrew admin"
                gyro.Name = "winning"
                pos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                pos.Position = HumanoidRootPart.Position
                gyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                gyro.CFrame = HumanoidRootPart.CFrame

                local UserInputService = game:GetService("UserInputService")

                local ConnectA =
                    UserInputService.InputBegan:Connect(
                    function(Input, GameProcess)
                        if not GameProcess then
                            if Input.KeyCode == Enum.KeyCode.W then
                                keys.w = true
                            elseif Input.KeyCode == Enum.KeyCode.S then
                                keys.s = true
                            elseif Input.KeyCode == Enum.KeyCode.A then
                                keys.a = true
                            elseif Input.KeyCode == Enum.KeyCode.D then
                                keys.d = true
                            end
                        end
                    end
                )

                local ConnectB =
                    UserInputService.InputEnded:Connect(
                    function(Input, GameProcess)
                        if not GameProcess then
                            if Input.KeyCode == Enum.KeyCode.W then
                                keys.w = false
                            elseif Input.KeyCode == Enum.KeyCode.S then
                                keys.s = false
                            elseif Input.KeyCode == Enum.KeyCode.A then
                                keys.a = false
                            elseif Input.KeyCode == Enum.KeyCode.D then
                                keys.d = false
                            end
                        end
                    end
                )

                repeat
                    RunService.Heartbeat:wait()
                    Character:FindFirstChildOfClass("Humanoid").PlatformStand = true
                    local new = gyro.cframe - gyro.cframe.p + pos.position
                    if not keys.w and not keys.s and not keys.a and not keys.d then
                        Speed = 1
                    end

                    if keys.w then
                        new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * Speed
                        Speed = Speed + 0.01
                    end

                    if keys.s then
                        new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * Speed
                        Speed = Speed + 0.01
                    end

                    if keys.d then
                        new = new * CFrame.new(Speed, 0, 0)
                        Speed = Speed + 0.01
                    end

                    if keys.a then
                        new = new * CFrame.new(-Speed, 0, 0)
                        Speed = Speed + 0.01
                    end

                    if Speed > 5 then
                        Speed = 5
                    end

                    pos.position = new.p

                    if keys.w then
                        gyro.cframe = workspace.CurrentCamera.CoordinateFrame
                    elseif keys.s then
                        gyro.cframe = workspace.CurrentCamera.CoordinateFrame
                    else
                        gyro.cframe = workspace.CurrentCamera.CoordinateFrame
                    end
                until not Flying

                if gyro then
                    gyro:Destroy()
                end
                if pos then
                    pos:Destroy()
                end
                Part:Destroy()
                Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
                Speed = 0
                ConnectA:Disconnect()
                ConnectB:Disconnect()
            end
            Fly()
        end
    )

    AddCommand(
        "unfly",
        "makes your character unfly",
        0,
        {},
        function()
            Flying = false
            notify("Unflying character..")
        end
    )

    AddCommand(
        "speed",
        "manipulates your humanoids speed",
        1,
        {"ws"},
        function(speed)
            notify("Changing humanoid speed to " .. speed .. "!")
            Player.Character.Humanoid.WalkSpeed = speed
        end
    )

    AddCommand(
        "jp",
        "manipulates your humanoids jump power",
        1,
        {"jumppower"},
        function(power)
            notify("Changing humanoid jump power to " .. power .. "!")
            Player.Character.Humanoid.UseJumpPower = true
            Player.Character.Humanoid.JumpPower = power
        end
    )

    AddCommand(
        "totalcmds",
        "notifies total cmds",
        0,
        {},
        function()
            notify("Total of: " .. #CommandController.Commands .. " commands in version " .. '"' .. VERSION .. '"' .. "!")
        end
    )

    AddCommand(
        "cmds",
        "Opens commands",
        0,
        {},
        function()
            CommandsUI:Show()
        end
    )

    AddCommand(
        "goto",
        "teleports to specified user",
        1,
        {"tpto"},
        function(user)
            user = GetPlayer(user)
            plr = user.Name
            notify("Going to " .. plr .. "!")
            targ = workspace:FindFirstChild(plr)
            Player.Character:SetPrimaryPartCFrame(targ:FindFirstChildOfClass("Part").CFrame)
        end
    )

    AddCommand(
        "realname",
        "gets the real username of target",
        1,
        {"rname", "getname"},
        function(user)
            pl = GetPlayer(user)
            notify(user .. "'s real name is " .. pl.Name .. "!")
        end
    )

    AddCommand(
        "dpos",
        "Teleports to the last place you died",
        0,
        {"deathpoint", "oldpos"},
        function()
            dpos = getgenv().spawn
            local suc, err =
                pcall(
                function()
                    dp = getgenv().spawn.X .. "  " .. getgenv().spawn.Y, "  " .. getgenv().spawn.Z
                end
            )
            if suc then
                notify("Teleporting to " .. dp .. "!")
                Player.Character:SetPrimaryPartCFrame(dpos)
            else
                notify("You have not died yet!")
            end
        end
    )
    AddCommand(
        "loopgoto",
        "loop teleports to specified user",
        1,
        {"looptpto"},
        function(user)
            user = GetPlayer(user)
            plr = user.Name
            notify("Loop-going to " .. plr .. "!")
            targ = workspace:FindFirstChild(plr)
            getgenv().looping = true
            loopin =
                RunService.Heartbeat:connect(
                function()
                    if getgenv().looping == true then
                        Player.Character:SetPrimaryPartCFrame(targ.HumanoidRootPart.CFrame)
                    else
                        loopin:Disconnect()
                    end
                end
            )
        end
    )

    AddCommand(
        "noclip",
        "turns off collisions for your bodyparts",
        0,
        {"nocol"},
        function(user)
            if Player.Character.HumanoidRootPart.CanCollide == false then
                notify("You are already noclipped!")
            else
                notify("Noclipping..")
            end
            local function nocl()
                for _, part in pairs(Player.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide == true then
                        part.CanCollide = false
                    end
                end
            end
            connectcl = RunService.Stepped:Connect(nocl)
        end
    )

    AddCommand(
        "loopws",
        "Loops walkspeed to specified value",
        1,
        {"loopwalkspeed"},
        function(speed)
            if wsloop then
                wsloop:Disconnect()
            end
            local function ws()
                if Player.Character.Humanoid ~= nil then
                    Player.Character.Humanoid.WalkSpeed = speed
                end
            end
            wsloop = RunService.Stepped:Connect(ws)
            notify("Looped walkspeed!")
        end
    )

    AddCommand(
        "unloopws",
        "Unloops walkspeed",
        0,
        {"unloopwalkspeed"},
        function()
            if wsloop then
                wsloop:Disconnect()
                notify("Walkspeed has been unlooped.")
            end
        end
    )

    AddCommand(
        "loopjp",
        "Loops JumpPower to specified value",
        1,
        {"loopjumppower"},
        function(height)
            if jploop then
                jploop:Disconnect()
            end
            local function jp()
                if Player.Character.Humanoid ~= nil then
                    Player.Character.Humanoid.UseJumpPower = true
                    Player.Character.Humanoid.JumpPower = height
                end
            end
            jploop = RunService.Stepped:Connect(jp)
            notify("Looped JumpPower!")
        end
    )

    AddCommand(
        "unloopjp",
        "Unloops JumpPower",
        0,
        {"unloopjumppower"},
        function()
            if jploop then
                jploop:Disconnect()
                notify("JumpPower has been unlooped.")
            end
        end
    )

    AddCommand(
        "chardelete",
        "Deletes specified part from character",
        1,
        {"characterdelete"},
        function(partn)
            local succ, err =
                pcall(
                function()
                    Player.Character[partn]:Destroy()
                end
            )
            if err then
                notify("Something went wrong..")
            else
                notify("Deleted!")
            end
        end
    )

    AddCommand(
        "clip",
        "turns on collisions for your bodyparts",
        0,
        {"col"},
        function(user)
            if connectcl then
                notify("Clipping..")
                connectcl:Disconnect()
            else
                notify("You are already clipped!")
            end
        end
    )
    AddCommand(
        "unloopgoto",
        "unloop teleports to specified user",
        0,
        {"unlooptpto"},
        function()
            notify("Unlooping " .. "!")
            getgenv().looping = false
        end
    )
end

return Commands
