local hbAdmin = script:FindFirstAncestor("HBAdmin")
local Command = require(hbAdmin.Commands.Command)
local Config = require(hbAdmin.Filesystem.Config)
local UI = require(hbAdmin.UI)
local Loading = require(hbAdmin.Loading.Maid)

local OldCommands = require(script.Parent.OldCommands)
local Commands = {
    _commands = {}
}
local IYLOADED = false
local Players = game:FindService("Players")
local CoreGui = game:FindService("CoreGui")
local StarterGui = game:FindService("StarterGui")
local GuiService = game:FindService("GuiService")
local RunService = game:FindService("RunService")
local TweenService = game:FindService("TweenService")
local PhysicsService = game:FindService("PhysicsService")
local TeleportService = game:FindService("TeleportService")
local UserInputService = game:FindService("UserInputService")
local HttpService = game:FindService("HttpService")
local ReplicatedStorage = game:FindService("ReplicatedStorage")
local Chat = game:FindService("Chat")
local Lighting = game:FindService("Lighting")

local Player = Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer

function Commands:Command(table)
    local title, desc, args, alternatives, func, init = table.title or table.name, table.desc or table.description, table.args or table.arguments, table.aliases or table.alternatives, table.func or table.executor, table.init
    title = title or "Homebrew Command"
    desc = desc or "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    args = args or 0
    alternatives = alternatives or {}
    func = func or function() end
    init = init or function() end

    local command = Command.new(title, desc, args, alternatives, func)
    task.delay(.3, function()
        local s,e = pcall(init, command)
        if not s then
            UI:Notify("Error", "Error loading command "..command:GetName()..". Check Console for more info", 5)
            warn("Error loading command "..command:GetName()..". \n\n"..e.."\n"..debug.traceback())
        end
    end)
    self._commands[#self._commands+1] = command
    return command
end

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

function _G.notify(title, desc)
    UI:Notify("IY: "..title, desc,5)
end

function Commands:Init(CommandController)
    OldCommands:Init(CommandController)

    local antikill
    antikill = self:Command{
        name="AntiKill",
        aliases = {"antikill", "ak", "atk", "antitkill"},
        desc = "Prevents you from being tkilled",
        executor = function()
            local enabled = antikill:GetStore("enabled")
            if not enabled then
                UI:Notify("Anti Kill", "Anti Kill enabled", 5)
                Player.Character.Humanoid:SetStateEnabled("Seated", false)
                Player.Character.Humanoid.Sit = true
            else
                UI:Notify("Anti Kill", "Anti Kill disabled", 5)
                Player.Character.Humanoid:SetStateEnabled("Seated", true)
                Player.Character.Humanoid.Sit = false
            end
            antikill:SetStore("enabled", not enabled)
        end,
        init = function(self)
            self:SetStore("enabled", false)
        end
    }

    self:Command{
        title="Unload",
        desc="Unloads the admin",
        aliases={"panic", "unload", "exit"},
        executor=function()
            Loading:Unload(Config)
        end
    }

    self:Command{
        title="test",
        desc="this is a test",
        aliases={},
        executor=function(...)
            print(...)
        end
    }

    self:Command{
        title="iy",
        desc="Grab a command from IY",
        aliases={},
        executor=function(...)
            if IYLOADED == false then
                local function copytable(tbl) local copy = {} for i,v in pairs(tbl) do copy[i] = v end return copy end
                local sandbox_env = copytable(getfenv())
                setmetatable(sandbox_env, {
                __index = function(self, i)
                    if rawget(sandbox_env, i) then
                        return rawget(sandbox_env, i)
                    elseif getfenv()[i] then
                        return getfenv()[i]
                    end
                end
                })
                sandbox_env.game = nil
                iy, _ = game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"):gsub("local Main", "Main"):gsub("Players.LocalPlayer.Chatted","Funny = Players.LocalPlayer.Chatted"):gsub("local lastMessage","notify = _G.notify\nlocal lastMessage")
                setfenv(loadstring(iy),sandbox_env)()
                iy_cmds_table = sandbox_env.CMDs
                iy_gui = sandbox_env.Main
                iy_chathandler = sandbox_env.Funny
                execCmd = sandbox_env.execCmd
                iy_gui:Destroy()
                pcall(function()
                    iy_chathandler:Disconnect()
                end)
                IYLOADED = true
            end
            execCmd((...))
        end
    }

    self:Command{
        title="clicktp",
        desc="Enables clicktp (CRTL + LEFTCLICK)",
        aliases={},
        executor=function()
            Mouse = Player:GetMouse()
            CLICKTPLOOP = Mouse.Button1Down:connect(function()
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(Mouse.Hit.p))
                end
            end)
            UI:Notify("clicktp", "Enabled!", 5)
        end
    }

    self:Command{
        title="unclicktp",
        desc="Disables clicktp",
        aliases={},
        executor=function()
            if CLICKTPLOOP then
                CLICKTPLOOP:Disconnect()
            end
            UI:Notify("clicktp", "Disabled!", 5)
        end
    }

    self:Command{
        title="sit",
        desc="Makes you sit!",
        aliases={},
        executor=function()
            Player.Character:FindFirstChildOfClass('Humanoid').Sit = true
            UI:Notify("Sit", "Sitting!", 5)
        end
    }

    self:Command{
        title="unsit",
        desc="Makes you get up!",
        aliases={},
        executor=function()
            Player.Character:FindFirstChildOfClass('Humanoid').Sit = false
            UI:Notify("Sit", "Unsitting!", 5)
        end
    }

    self:Command{
        title="pathfindgoto",
        desc="Uses pathfinding to go to player!",
        aliases={"pfgoto", "pfg"},
        executor=function(Target)
            local SimplePath = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/V3N0M-Z/RBLX-SimplePath/main/src/SimplePath.lua"))()
            Goal = GetPlayer(Target).Character.PrimaryPart
            Path = SimplePath.new(Player.Character)
            Path.Blocked:Connect(function()
                Path:Run(Goal)
            end)
            Path.WaypointReached:Connect(function()
                Path:Run(Goal)
            end)
            Path.Error:Connect(function(errorType)
                Path:Run(Goal)
            end)
            Path:Run(Goal)
            UI:Notify("Pathfind", "Going to target!", 5)
        end
    }

    self:Command{
        title="unpathfindgoto",
        desc="Stops the current pathfinding run.",
        aliases={"unpfgoto", "unpfg"},
        executor=function()
            if Path then
                Path:Stop()
                Path:Destroy()
                UI:Notify("Pathfind", "Stopped!", 5)
            end
        end
    }

    self:Command{
        title="btools",
        desc="Gives you btools [CLIENT].",
        aliases={},
        executor=function()
            A = Instance.new("HopperBin", Player.Backpack)
            A.BinType = 2
            A = Instance.new("HopperBin", Player.Backpack)
            A.BinType = 3
            A = Instance.new("HopperBin", Player.Backpack)
            A.BinType = 4
            UI:Notify("Btools", "Got btools!", 5)
        end
    }

    self:Command{
        title="naked",
        desc="Removes your clothing!",
        aliases={},
        executor=function()
            for i,v in pairs(Player.Character:GetDescendants()) do
                if v:IsA("ShirtGraphic") or v:IsA("Clothing") then
                    v:Destroy()
                end
            end
            UI:Notify("Naked", "Clothes removed!", 5)
        end
    }

    self:Command{
        title="newbubblechat",
        desc="Enables the new bubblechat on client",
        aliases={"bubblechat"},
        executor=function()
            Chat.BubbleChatEnabled = true
            UI:Notify("Bubble Chat", "Enabled!", 5)
        end
    }

    self:Command{
        title="unnewbubblechat",
        desc="Disables the new bubblechat on client",
        aliases={"nobubblechat","unbubblechat"},
        executor=function()
            Chat.BubbleChatEnabled = false
            UI:Notify("Bubble Chat", "Disabled!", 5)
        end
    }

    self:Command{
        title="Unload",
        desc="Unloads the admin",
        aliases={"panic", "unload", "exit"},
        executor=function()
            Loading:Unload(Config)
        end
    }

    self:Command{
        title="saura",
        desc="Automatically kills the nearest players",
        aliases={},
        executor=function()
            funnyloop = true
            local Backpack = Player:WaitForChild("Backpack")
            local Character = Player.Character
            local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
            local RootPart = Character and Humanoid and Humanoid.RootPart or false
            local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
            if not Humanoid or not RootPart or not RightArm then
                return
            end

            local function GetClosest()
                local Character = LocalPlayer.Character
                local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                if not (Character or HumanoidRootPart) then return end

                local TargetDistance = math.huge
                local Target

                for i,v in ipairs(Players:GetPlayers()) do
                    if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local TargetHRP = v.Character.HumanoidRootPart
                        local mag = (HumanoidRootPart.Position - TargetHRP.Position).magnitude
                        if mag < TargetDistance then
                            TargetDistance = mag
                            Target = v
                        end

                    end
                end

                return Target
            end
            Humanoid:UnequipTools()
            local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
            Humanoid:EquipTool(MainTool)
            UI:Notify("SAura", "SAura ON!", 5)
            repeat
            task.wait()
            MainTool:Activate()
            task.wait()
            MainTool:Activate()
            firetouchinterest(MainTool.Handle, GetClosest().Character.PrimaryPart, 0)
            firetouchinterest(MainTool.Handle,GetClosest().Character.PrimaryPart, 1)
            until funnyloop == false or Character.Humanoid.Health == 0
        end
    }

    self:Command{
        title="unsaura",
        desc="Turns off saura",
        aliases={},
        executor=function()
            if funnyloop then
                funnyloop = false
                UI:Notify("SAura", "SAura OFF!", 5)
            end
        end
    }

    self:Command{
        title="gravity",
        desc="Changes the gravity to arg",
        aliases={"grav"},
        executor=function(arg)
            if arg then
                workspace.Gravity = arg
                UI:Notify("Gravity", "Gravity set!", 5)
            else
                workspace.Gravity = 196.2
                UI:Notify("Gravity", "Gravity set to default!", 5)
            end
        end
    }

    self:Command{
        title="ungravity",
        desc="Changes the gravity to default (196.2)",
        aliases={"ungrav"},
        executor=function()
            workspace.Gravity = 196.2
            UI:Notify("Gravity", "Gravity set to default!", 5)
        end
    }

    self:Command{
        title="maxslopeangle",
        desc="Changes the maxslopeangle to arg",
        aliases={"msa"},
        executor=function(arg)
            if arg then
                Player.Character:FindFirstChildOfClass('Humanoid').MaxSlopeAngle = arg
                UI:Notify("Maxslopeangle", "maxslopeangle set!", 5)
            else
                Player.Character:FindFirstChildOfClass('Humanoid')N.MaxSlopeAngle = 89
                UI:Notify("Maxslopeangle", "maxslopeangle set to default!", 5)
            end
        end
    }

    self:Command{
        title="jump",
        desc="Makes you jump",
        aliases={},
        executor=function()
            Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
        end
    }

    self:Command{
        title="infjump",
        desc="Makes you jump as many times as you want in air",
        aliases={"infinitejump"},
        executor=function()
            pcall(function()
                infjumploop:Disconnect()
            end)
            infjumploop = UserInputService.JumpRequest:connect(function()
                Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
            end)
            UI:Notify("Infinite Jump", "Enabled!", 5)
        end
    }

    self:Command{
        title="uninfjump",
        desc="Disables infinite jump",
        aliases={"uninfinitejump"},
        executor=function()
            if infjumploop then
                infjumploop:Disconnect()
                UI:Notify("Infinite Jump", "Disabled!", 5)
            else
                UI:Notify("Infinite Jump", "Not Enabled!", 5)
            end
        end
    }

    self:Command{
        title="antivoid",
        desc="Prevents people from attaching to you",
        aliases={"antiattach"},
        executor=function()
            local Tools = {}
            for i,v in pairs(LocalPlayer.Character:GetChildren()) do
                if v:IsA("Tool") then
                    table.insert(Tools,v:GetDebugId())
                end
            end
            for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
                if v:IsA("Tool") then
                    table.insert(Tools,v:GetDebugId())
                end
            end
            AAttach = LocalPlayer.Character.ChildAdded:Connect(function(instance)
                if instance:IsA("Tool") and not table.find(Tools,instance:GetDebugId()) then
                    task.wait()
                    instance.Parent = nil
                end
            end)
            UI:Notify("Anti Void", "Enabled!", 5)
        end
    }

    self:Command{
        title="rocket",
        desc="Rockets player [TOOL REQUIRED]",
        aliases={},
        executor=function(Target)
            local TPlayer = GetPlayer(Target)
            TRootPart = TPlayer.Character.HumanoidRootPart
            local Character = Player.Character
            local PlayerGui = Player:WaitForChild("PlayerGui")
            local Backpack = Player:WaitForChild("Backpack")
            local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
            local RootPart = Character and Humanoid and Humanoid.RootPart or false
            local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
            if not Humanoid or not RootPart or not RightArm then
                return
            end
            Humanoid:UnequipTools()
            local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
            if not MainTool or not MainTool:FindFirstChild("Handle") then
                return
            end
            Humanoid.Name = "DAttach"
            local l = Character["DAttach"]:Clone()
            l.Parent = Character
            l.Name = "Humanoid"
            wait()
            Character["DAttach"]:Destroy()
            game.Workspace.CurrentCamera.CameraSubject = Character
            Character.Animate.Disabled = true
            wait()
            Character.Animate.Disabled = false
            
            Character.Humanoid:EquipTool(MainTool)
            wait()
            UI:Notify("Rocket", "Sending target to space!", 5)
            CF = Player.Character.PrimaryPart.CFrame
            if firetouchinterest then
                local flag = false
                task.defer(function()
                    MainTool.Handle.AncestryChanged:wait()
                    flag = true
                end)
                repeat
                    firetouchinterest(MainTool.Handle, TRootPart, 0)
                    firetouchinterest(MainTool.Handle, TRootPart, 1)
                    wait()
                    local a = Instance.new("BodyForce",Character.HumanoidRootPart)
                    a.Force = Vector3.new(0,9e3,0)
                    Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
                until flag
            else
                Player.Character.HumanoidRootPart.CFrame =
                TCharacter.HumanoidRootPart.CFrame
                wait()
                Player.Character.HumanoidRootPart.CFrame =
                TCharacter.HumanoidRootPart.CFrame
                wait()
                local a = Instance.new("BodyForce",Character.HumanoidRootPart)
                a.Force = Vector3.new(0,9e3,0)
                Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
                wait()
            end
            Player.CharacterAdded:wait():waitForChild("HumanoidRootPart").CFrame = CF
        end
    }

    self:Command{
        title="attach",
        desc="Attaches to player [TOOL REQUIRED]",
        aliases={},
        executor=function(Target)
            local TPlayer = GetPlayer(Target)
            TRootPart = TPlayer.Character.HumanoidRootPart
            local Character = Player.Character
            local PlayerGui = Player:WaitForChild("PlayerGui")
            local Backpack = Player:WaitForChild("Backpack")
            local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
            local RootPart = Character and Humanoid and Humanoid.RootPart or false
            local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
            if not Humanoid or not RootPart or not RightArm then
                return
            end
            Humanoid:UnequipTools()
            local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
            if not MainTool or not MainTool:FindFirstChild("Handle") then
                return
            end
            Humanoid.Name = "DAttach"
            local l = Character["DAttach"]:Clone()
            l.Parent = Character
            l.Name = "Humanoid"
            wait()
            Character["DAttach"]:Destroy()
            game.Workspace.CurrentCamera.CameraSubject = Character
            Character.Animate.Disabled = true
            wait()
            Character.Animate.Disabled = false
            Character.Humanoid:EquipTool(MainTool)
            wait()
            UI:Notify("Attach", "Attaching to target!", 5)
            CF = Player.Character.PrimaryPart.CFrame
            if firetouchinterest then
                local flag = false
                task.defer(function()
                    MainTool.Handle.AncestryChanged:wait()
                    flag = true
                end)
                repeat
                    firetouchinterest(MainTool.Handle, TRootPart, 0)
                    firetouchinterest(MainTool.Handle, TRootPart, 1)
                    wait()
                until flag
            else
                Player.Character.HumanoidRootPart.CFrame =
                TCharacter.HumanoidRootPart.CFrame
                wait()
                Player.Character.HumanoidRootPart.CFrame =
                TCharacter.HumanoidRootPart.CFrame
                wait()
            end
            Player.CharacterAdded:wait():waitForChild("HumanoidRootPart").CFrame = CF
        end
    }

    self:Command{
        title="unantivoid",
        desc="Disables anti void",
        aliases={"unantiattach"},
        executor=function()
            if AAttach then
                AAttach:Disconnect()
                UI:Notify("Anti Void", "Disabled!", 5)
            else
                UI:Notify("Anti Void", "Disabled!", 5)
            end
        end
    }

    self:Command{
        title="delete",
        desc="Removes player from workspace",
        aliases={"remove"},
        executor=function(Target)
            TPlayer = GetPlayer(Target)
            TPlayer.Character.Parent = game.Lighting
            UI:Notify("Delete", "Player now in lighting!", 5)
        end
    }

    self:Command{
        title="setspawn",
        desc="Sets spawn to where you execute",
        aliases={},
        executor=function()
            CF = Player.Character.HumanoidRootPart.CFrame
            SpawnLoop = Player.CharacterAdded:Connect(function()
                task.wait()
                Player.Character.HumanoidRootPart.CFrame = CF
            end)
            UI:Notify("Spawn", "Spawn set!", 5)
        end
    }

    self:Command{
        title="removespawn",
        desc="Removes spawn (set with setspawn)",
        aliases={},
        executor=function()
            if SpawnLoop then
                SpawnLoop:Disconnect()
                UI:Notify("Spawn", "Spawn removed!", 5)
            end
        end
    }

    self:Command{
        title="savepos",
        desc="Saves the position you execute, can be loaded with loadpos",
        aliases={},
        executor=function()
            GLSavePos = Player.Character.HumanoidRootPart.CFrame
            UI:Notify("Savepos", "Position set!", 5)
        end
    }

    self:Command{
        title="saydiscord",
        desc="Makes you say the discord invite in chat",
        aliases={},
        executor=function()
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("" .. "HB Admin Invite: rZsAbyRasw", "All")
            UI:Notify("Discord", "Sent invite!", 5)
        end
    }

    
    -- add a command called volume that takes a number as an argument and adjusts the mastervolume of the game
    self:Command{
        title="volume",
        desc="Sets the volume of the game",
        aliases={},
        executor=function(Target)
            UserSettings():GetService("UserGameSettings").MasterVolume = Target/10
            UI:Notify("Volume", "Volume set to " .. Target, 5)
        end
    }

    self:Command{
        title="audiolog",
        desc="Logs the audio id the target is playing",
        aliases={},
        executor=function(Target)
            TPlayer = GetPlayer(Target)
            for i,v in pairs(TPlayer.Character:GetDescendants()) do
                if v:IsA("Tool") then
                    for a,b in pairs(v:GetDescendants()) do
                        if b:IsA("Sound") then
                            setclipboard(b.SoundId)
                            UI:Notify("Audio Log", "Audio ID: " .. b.SoundId, 5)
                        end
                    end
                end
            end
        end
    }

    self:Command{
        title="jobid",
        desc="Gets the job id of the game",
        aliases={},
        executor=function()
            setclipboard(game.JobId)
            UI:Notify("Job ID", "Job ID: " .. game.JobId, 5)
        end
    }

    self:Command{
        title="autorj",
        desc="Automatically rejoins when you are kicked",
        aliases={},
        executor=function()
            RJLoop = game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(Child)
                if Child.Name == 'ErrorPrompt' and Child:FindFirstChild('MessageArea') and Child.MessageArea:FindFirstChild("ErrorFrame") then
                    wait(1)
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
                end
            end)
            UI:Notify("Auto RJ", "Enabled!", 5)
        end
    }
    
    self:Command{
        title="loadpos",
        desc="Loads the position you saved with savepos",
        aliases={},
        executor=function()
            if GLSavePos then
                Player.Character.HumanoidRootPart.CFrame = GLSavePos
                UI:Notify("Loadpos", "Position loaded!", 5)
            end
        end
    }

    self:Command{
        title="removespawn",
        desc="Removes spawn (set with setspawn)",
        aliases={},
        executor=function()
            if SpawnLoop then
                SpawnLoop:Disconnect()
                UI:Notify("Spawn", "Spawn removed!", 5)
            end
        end
    }

    self:Command{
        title="ping",
        desc="Returns your current ping",
        aliases={},
        executor=function()
            local Ping = math.floor(tonumber(string.split(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(), " ")[1]))
            UI:Notify("Ping", "Your ping is "..Ping.."ms", 5)
        end
    }

    self:Command{
        title="headsit",
        desc="Sit on the targets head!",
        aliases={"ride"},
        executor=function(Target)
            TPlayer = GetPlayer(Target)
            Player.Character.Humanoid.Sit = true
            HSLoop = RunService.Heartbeat:connect(function()
                if TPlayer.Character and Player.Character then
                    Player.Character.HumanoidRootPart.CFrame = TPlayer.Character.Head.CFrame * CFrame.new(0, 2, 0)
                    if Player.Character.Humanoid.Sit == false then
                        Player.Character.Humanoid.Sit = true
                    end
                end
            end)
            UI:Notify("Headsit", "Sitting on "..Target.Name.."'s head!", 5)
        end
    }

    self:Command{
        title="unheadsit",
        desc="Unheadsit on the target",
        aliases={"unride"},
        executor=function()
            if HSLoop then
                HSLoop:Disconnect()
                Player.Character.Humanoid.Sit = false
                UI:Notify("Headsit", "Unheadsitting!", 5)
            end
        end
    }

    self:Command{
        title="headsit",
        desc="Sit on the targets head!",
        aliases={"ride"},
        executor=function(Target)
            TPlayer = GetPlayer(Target)
            Player.Character.Humanoid.Sit = true
            HSLoop = RunService.Heartbeat:connect(function()
                if TPlayer.Character and Player.Character then
                    Player.Character.HumanoidRootPart.CFrame = TPlayer.Character.Head.CFrame * CFrame.new(0, 2, 0)
                    if Player.Character.Humanoid.Sit == false then
                        Player.Character.Humanoid.Sit = true
                    end
                end
            end)
            UI:Notify("Headsit", "Sitting on "..Target.Name.."'s head!", 5)
        end
    }

    self:Command{
        title="headstand",
        desc="Standing on the targets head!",
        aliases={"ride"},
        executor=function(Target)
            TPlayer = GetPlayer(Target)
            HStLoop = RunService.Heartbeat:connect(function()
                if TPlayer.Character and Player.Character then
                    Player.Character.HumanoidRootPart.CFrame = TPlayer.Character.Head.CFrame * CFrame.new(0, 4, 0)
                end
            end)
            UI:Notify("Headstand", "Standing on "..Target.Name.."'s head!", 5)
        end
    }

    self:Command{
        title="freeze",
        desc="Freezes yourself",
        aliases={},
        executor=function()
            if not Player.Character then
                return
            end
            for i,v in pairs(Player.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    v.Anchored = true
                end
            end
            UI:Notify("Freeze", "Freezing!", 5)
        end
    }

    self:Command{
        title="unfreeze",
        desc="Unfreezes yourself",
        aliases={},
        executor=function()
            if not Player.Character then
                return
            end
            for i,v in pairs(Player.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    v.Anchored = false
                end
            end
            UI:Notify("Freeze", "Unfreezing!", 5)
        end
    }



    self:Command{
        title="unheadstand",
        desc="Unheadstand on the target",
        aliases={},
        executor=function()
            if HStLoop then
                HStLoop:Disconnect()
                UI:Notify("Headstand", "Unheadstanding!", 5)
            end
        end
    }

    self:Command{
        title="lvoid",
        desc="Use leg resize and void plr",
        aliases={"lkill"},
        executor=function(Target)
            TPlayer = GetPlayer(Target)
            local Character = Player.Character
            local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
            local PlayerGui = Player:WaitForChild("PlayerGui")
            local Backpack = Player:WaitForChild("Backpack")
            local WaitFunc = function(x) x.DescendantAdded:wait() task.wait() end
            if Humanoid.RigType == Enum.HumanoidRigType.R6 then UI:Notify("Leg Void", "R15 Only!", 5) return end
            local Settings = { -- Credit to whitearmor#0001
                Values = {
                    BodyTypeScale = true;
                    BodyProportionScale = true;
                    BodyWidthScale = true;
                    BodyHeightScale = true;
                    BodyDepthScale = true;
                    HeadScale = true;
                };
                OriginalSize = true;
                OriginalPosition = false;
            }
            Character.LeftUpperLeg.LeftKneeRigAttachment:Destroy()
            Character.LeftLowerLeg.LeftAnkleRigAttachment:Destroy()
            Character.LeftFoot.LeftFootAttachment:Destroy()
            for _,x in next, Settings.Values do
                if x then
                    if Settings.OriginalSize then
                        for _, _os in next, Character:GetDescendants() do
                            if _os.Name == "OriginalSize" and _os:IsA("ValueBase") then
                                _os:Destroy()
                            end
                        end
                    end
                    if Settings.OriginalPosition then
                        for _, _op in next, Character:GetDescendants() do
                            if _op.Name == "OriginalPosition" and _op:IsA("ValueBase") then
                                _op:Destroy()
                            end
                        end
                    end
                    if Humanoid:FindFirstChild(tostring(_)) then
                        Humanoid:FindFirstChild(tostring(_)):Destroy()
                    end
                    WaitFunc(Character)
                end
            end
            Humanoid:UnequipTools()
            local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
            if not MainTool or not MainTool:FindFirstChild("Handle") then
                return
            end
            local TCharacter = TPlayer and TPlayer.Character
            local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
            local TRootPart = TCharacter.HumanoidRootPart
            if not THumanoid or not TRootPart then
                return
            end

            function hwait() return game:GetService("RunService").Heartbeat:Wait() end

            Character.Humanoid.Name = "DAttach"
            local l = Character["DAttach"]:Clone()
            l.Parent = Character
            l.Name = "Humanoid"
            hwait()
            Character["DAttach"]:Destroy()
            game.Workspace.CurrentCamera.CameraSubject = Character
            Character.Animate.Disabled = true
            hwait()
            Character.Animate.Disabled = false
            Character.Humanoid:EquipTool(MainTool)
            hwait()
            CF = Player.Character.PrimaryPart.CFrame
            --workspace.CurrentCamera.CameraType = "Scriptable"
            UI:Notify("Leg Void", "Leg Voiding "..TPlayer.Name.."!", 5)
            if firetouchinterest then
                local flag = false
                task.defer(function()
                    MainTool.Handle.AncestryChanged:wait()
                    flag = true
                end)
                repeat
                    firetouchinterest(MainTool.Handle, TRootPart, 0)
                    firetouchinterest(MainTool.Handle, TRootPart, 1)
                    wait(.1)
                    for i,v in pairs(Player.Character:GetChildren()) do
                            if v:IsA("BasePart") then
                                v.CFrame = CFrame.new(0,workspace.FallenPartsDestroyHeight+(1.09),0)
                        end
                    end
                until flag
            end                  
            Player.CharacterAdded:Wait()
            Player.Character.HumanoidRootPart.CFrame = CF
        end
    }

    self:Command{
        title="hipheight",
        desc="Changes the hipheight to arg",
        aliases={"hh"},
        executor=function(arg)
            if arg then
                Player.Character:FindFirstChildOfClass("Humanoid").HipHeight = arg
                UI:Notify("HipHeight", "HipHeight set!", 5)
            else
                if Player.Character:FindFirstChildOfClass('Humanoid').RigType == Enum.HumanoidRigType.R15 then
                    Player.Character:FindFirstChildOfClass("Humanoid").HipHeight = 2.1
                else
                    Player.Character:FindFirstChildOfClass("Humanoid").HipHeight = 0
                end
                UI:Notify("HipHeight", "HipHeight set to default!", 5)
            end
        end
    }

    self:Command{
        title="unhipheight",
        desc="Changes the hipheight to default",
        aliases={"unhh"},
        executor=function()
            if Player.Character:FindFirstChildOfClass('Humanoid').RigType == Enum.HumanoidRigType.R15 then
                Player.Character:FindFirstChildOfClass("Humanoid").HipHeight = 2.1
            else
                Player.Character:FindFirstChildOfClass("Humanoid").HipHeight = 0
            end
            UI:Notify("HipHeight", "HipHeight set to default!", 5)
        end
    }

    local reCommand

    reCommand = self:Command{
        title="refresh",
        desc="Refreshes your character",
        aliases = {"re", "kys", "suicide", "refresh"},
        executor=function()
            if reCommand:GetStore("running") then
                UI:Notify("Refresh", "Already refreshing character!", 3)
                return
            end
            reCommand:SetStore("running", true)
            local Character = Player.Character
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")

            local function anchor(model)
                for i,v in pairs(model:GetChildren()) do
                    if v:IsA("BasePart") then v.Anchored = true end
                    anchor(v)
                end
            end
            anchor(Character)
            local SavePos = Character.HumanoidRootPart.CFrame
            Humanoid.Health = 0
            Player.CharacterAdded:Wait():WaitForChild("HumanoidRootPart").CFrame = SavePos
            reCommand:SetStore("running", false)
        end,
        init=function()
            reCommand:SetStore("running", false)
        end
    }

    local grCommand
    grCommand = self:Command{
        title="respawn",
        desc="Respawns your character",
        aliases = {"gr"},
        executor=function()
            if reCommand:GetStore("running") then
                UI:Notify("Refresh", "Already respawning character!", 3)
                return
            end
            reCommand:SetStore("running", true)
            local Character = Player.Character
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")

            local function anchor(model)
                for i,v in pairs(model:GetChildren()) do
                    if v:IsA("BasePart") then v.Anchored = true end
                    anchor(v)
                end
            end
            anchor(Character)
            Humanoid.Health = 0
            reCommand:SetStore("running", false)
        end,
        init=function()
            reCommand:SetStore("running", false)
        end
    }

    self:Command{
        title = "fireclickdetectors",
        desc = "Fires all ClickDetectors in the Workspace",
        aliases = { "clickdetectors", "firecd" },
        executor = function()
            if fireclickdetector == nil then
                UI:Notify("Fire ClickDetectors", "Unsupported exploit: missing fireclickdetector")
                return
            end

            for _, ins in ipairs(workspace:GetDescendants()) do
                if not ins:IsA("ClickDetector") then
                    continue
                end

                fireclickdetector(ins)
            end
        end
    }

    self:Command{
        title = "fireproximityprompts",
        desc = "Fires all ProximityPrompts in the Workspace",
        aliases = { "proximityprompts", "fireprompts", "firepp" },
        executor = function()
            if fireproximityprompt == nil then
                UI:Notify("Fire ProximityPrompts", "Unsupported exploit: missing fireproximityprompt")
                return
            end

            for _, ins in ipairs(workspace:GetDescendants()) do
                if not ins:IsA("ProximityPrompt") then
                    continue
                end

                fireproximityprompt(ins)
            end
        end
    }

    self:Command{
        title = "firetouchinterests",
        desc = "Fires all TouchInterests in the Workspace",
        aliases = { "touchinterests", "firetouch", "fireti" },
        executor = function()
            if firetouchinterest == nil then
                UI:Notify("Fire TouchInterests", "Unsupported exploit: missing firetouchinterest")
                return
            end

            local pl = game.Players.LocalPlayer
            local hrp = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")

            if (hrp == nil) then
                UI:Notify("Fire TouchInterests", "Failed: character has no root part")
                return
            end

            for _, ins in ipairs(workspace:GetDescendants()) do
                if not ins:IsA("TouchTransmitter") or not ins.Parent:IsA("BasePart") then
                    continue
                end

                local part = ins.Parent
                firetouchinterest(part, hrp, 1)
                task.delay(0, firetouchinterest, part, hrp, 0)
            end
        end
    }

    self:LoadCommands(CommandController)
end

function Commands:LoadCommands(CommandController)
    for _, cmd in next, self._commands do
        CommandController:AddCommand(cmd)
    end
end

return Commands
