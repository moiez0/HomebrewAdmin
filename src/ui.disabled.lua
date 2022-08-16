
-- Gui to Lua
-- Version: 3.2
-- Instances:
function secure_request(...)
	if syn then
		return syn.request(...)
	elseif SENTINEL_V2 then
		return request(...)
	elseif PROTOSMASHER_LOADED then
		return request(...)
	elseif Sirhurt then
		return http_request(...)
	end
end

local hbAdmin = script:FindFirstAncestor("HBAdmin")

local ChatController = require(hbAdmin.Chat.ChatController)
local CommandController = require(hbAdmin.Commands.CommandController)
local Config = require(hbAdmin.Filesystem.Config)

local HBADMIN = Instance.new("ScreenGui")
local HBADMIN_2 = Instance.new("Frame")
local Toolbar = Instance.new("Frame")
local Close = Instance.new("TextButton")
local Minimize = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local ImageLabel = Instance.new("ImageLabel")
local cmdpromptthing = Instance.new("TextLabel")
local reserved = Instance.new("TextLabel")
local user = Instance.new("TextLabel")
local CB = Instance.new("TextBox")
local cmdlist = Instance.new("ScrollingFrame")
local commandlabels = Instance.new("Folder")
local killall = Instance.new("TextLabel")
local killothers = Instance.new("TextLabel")
local killplayername = Instance.new("TextLabel")
local knifegrabknife = Instance.new("TextLabel")
local r6 = Instance.new("TextLabel")
local respawn = Instance.new("TextLabel")
local jojo = Instance.new("TextLabel")
local neko = Instance.new("TextLabel")
local cop = Instance.new("TextLabel")
local jojo2 = Instance.new("TextLabel")
local UIGridLayout = Instance.new("UIGridLayout")
local dragon = Instance.new("TextLabel")
local bat = Instance.new("TextLabel")
local car = Instance.new("TextLabel")
local shotgun = Instance.new("TextLabel")
local chainsaw = Instance.new("TextLabel")
local icewalker = Instance.new("TextLabel")
local noobicider = Instance.new("TextLabel")
local xester = Instance.new("TextLabel")
local ravenger = Instance.new("TextLabel")
local executor = Instance.new("TextLabel")
local magic = Instance.new("TextLabel")
local music = Instance.new("TextLabel")
local galacta = Instance.new("TextLabel")
local boie = Instance.new("TextLabel")
local creep = Instance.new("TextLabel")
local nootnoot = Instance.new("TextLabel")
local bong = Instance.new("TextLabel")
local skullkid = Instance.new("TextLabel")
local hang = Instance.new("TextLabel")
local guns = Instance.new("TextLabel")
local revolver = Instance.new("TextLabel")
local knife2 = Instance.new("TextLabel")
local gunjourer = Instance.new("TextLabel")
local mech = Instance.new("TextLabel")
local ar = Instance.new("TextLabel")
local gladiator = Instance.new("TextLabel")
local dex = Instance.new("TextLabel")
local gd = Instance.new("TextLabel")
local color1 = Instance.new("TextLabel")
local color2 = Instance.new("TextLabel")
local color3 = Instance.new("TextLabel")
local color4 = Instance.new("TextLabel")
local color5 = Instance.new("TextLabel")
local color6 = Instance.new("TextLabel")
local color7 = Instance.new("TextLabel")
local color8 = Instance.new("TextLabel")
local Toolbar_2 = Instance.new("Frame")
local Minimize_2 = Instance.new("TextButton")
local TextLabel_2 = Instance.new("TextLabel")
local ImageLabel_2 = Instance.new("ImageLabel")
local Close_2 = Instance.new("TextButton")
local PR = Instance.new("ScreenGui")
local Holder = Instance.new("ImageLabel")
local EditorFrame = Instance.new("ImageLabel")
local Source = Instance.new("TextBox")
local Comments_ = Instance.new("TextLabel")
local Globals_ = Instance.new("TextLabel")
local Keywords_ = Instance.new("TextLabel")
local RemoteHighlight_ = Instance.new("TextLabel")
local Strings_ = Instance.new("TextLabel")
local Tokens_ = Instance.new("TextLabel")
local Numbers_ = Instance.new("TextLabel")
local Hide = Instance.new("ImageLabel")
local Lines = Instance.new("TextLabel")
local Execute = Instance.new("TextButton")
local TextButton_Roundify_5px = Instance.new("ImageLabel")
local Circle = Instance.new("ImageLabel")
local Clear = Instance.new("TextButton")
local TextButton_Roundify_5px_2 = Instance.new("ImageLabel")
local Circle_2 = Instance.new("ImageLabel")
local Respawn = Instance.new("TextButton")
local TextButton_Roundify_5px_3 = Instance.new("ImageLabel")
local Circle_3 = Instance.new("ImageLabel")
local Close_3 = Instance.new("TextButton")
local R6 = Instance.new("TextButton")
local TextButton_Roundify_5px_4 = Instance.new("ImageLabel")
local Circle_4 = Instance.new("ImageLabel")
local ImageLabel_3 = Instance.new("ImageLabel")
local Open = Instance.new("Frame")
local TextButton = Instance.new("TextButton")
local Loading = Instance.new("Frame")
local checking = Instance.new("TextLabel")
local whitelisted = Instance.new("TextLabel")
local info = Instance.new("TextLabel")
local blacklisted = Instance.new("TextLabel")
local line = Instance.new("ImageButton")
local PROMPT = Instance.new("TextLabel")
local COMMAND = Instance.new("TextLabel")
local system32 = Instance.new("TextLabel")
local Toolbar_3 = Instance.new("Frame")
local Close_4 = Instance.new("TextButton")
local Minimize_3 = Instance.new("TextButton")
local TextLabel_3 = Instance.new("TextLabel")
local ImageLabel_4 = Instance.new("ImageLabel")

--Properties:

HBADMIN.Name = "HBADMIN"
HBADMIN.Parent = game.CoreGui
HBADMIN.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
HBADMIN.ResetOnSpawn = false


HBADMIN_2.Name = "HBADMIN"
HBADMIN_2.Parent = HBADMIN
HBADMIN_2.Active = true
HBADMIN_2.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
HBADMIN_2.BorderColor3 = Color3.fromRGB(255, 255, 255)
HBADMIN_2.BorderSizePixel = 0
HBADMIN_2.Position = UDim2.new(0.676999986, 0, 1, 0)
HBADMIN_2.Size = UDim2.new(0, 482, 0, 329)
HBADMIN_2.Active = true
HBADMIN_2.Draggable = true
Toolbar.Name = "Toolbar"
Toolbar.Parent = HBADMIN_2
Toolbar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toolbar.BorderColor3 = Color3.fromRGB(27, 42, 53)
Toolbar.BorderSizePixel = 0
Toolbar.ClipsDescendants = true
Toolbar.Size = UDim2.new(0, 482, 0, 28)

Close.Name = "Close"
Close.Parent = Toolbar
Close.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Close.BorderSizePixel = 0
Close.ClipsDescendants = true
Close.Position = UDim2.new(0.933794022, 0, 0, 0)
Close.Size = UDim2.new(0, 32, 0, 28)
Close.Font = Enum.Font.SourceSansLight
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 23.000
Close.TextWrapped = true

Minimize.Name = "Minimize"
Minimize.Parent = Toolbar
Minimize.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Minimize.BorderSizePixel = 0
Minimize.ClipsDescendants = true
Minimize.Position = UDim2.new(0.866992772, 0, 0, 0)
Minimize.Size = UDim2.new(0, 32, 0, 28)
Minimize.Font = Enum.Font.SourceSansLight
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize.TextSize = 23.000
Minimize.TextWrapped = true

TextLabel.Parent = Toolbar
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 10.000
TextLabel.ClipsDescendants = true
TextLabel.Size = UDim2.new(0, 141, 0, 25)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Command Prompt"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

ImageLabel.Parent = Toolbar
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BackgroundTransparency = 10.000
ImageLabel.Position = UDim2.new(0, 0, 0.214000002, 0)
ImageLabel.Size = UDim2.new(0, 22, 0, 15)
ImageLabel.Image = "http://www.roblox.com/asset/?id=5533575307"
ImageLabel.ScaleType = Enum.ScaleType.Fit

cmdpromptthing.Name = "cmdpromptthing"
cmdpromptthing.Parent = HBADMIN_2
cmdpromptthing.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
cmdpromptthing.BackgroundTransparency = 10.000
cmdpromptthing.Position = UDim2.new(0.00600000005, 0, 0.074000001, 0)
cmdpromptthing.Size = UDim2.new(0, 160, 0, 22)
cmdpromptthing.Font = Enum.Font.SourceSans
cmdpromptthing.Text = "Command Prompt [Version 1.0]"
cmdpromptthing.TextColor3 = Color3.fromRGB(255, 255, 255)
cmdpromptthing.TextSize = 14.000

reserved.Name = "reserved"
reserved.Parent = HBADMIN_2
reserved.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
reserved.BackgroundTransparency = 10.000
reserved.Position = UDim2.new(0.0890622437, 0, 0.128632218, 0)
reserved.Size = UDim2.new(0, 167, 0, 22)
reserved.Font = Enum.Font.SourceSans
reserved.Text = "(c) 2022 Homebrew Corp.  This UI is a placeholder."
reserved.TextColor3 = Color3.fromRGB(255, 255, 255)
reserved.TextSize = 14.000

user.Name = "user"
user.Parent = HBADMIN_2
user.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
user.BackgroundTransparency = 10.000
user.Position = UDim2.new(0.0438506231, 0, 0.214000002, 0)
user.Size = UDim2.new(0, 51, 0, 22)
user.Font = Enum.Font.SourceSans
user.Text = "C:\\Users\\Admin>"
user.TextColor3 = Color3.fromRGB(255, 255, 255)
user.TextSize = 14.000

CB.Name = "CB"
CB.Parent = HBADMIN_2
CB.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
CB.BorderColor3 = Color3.fromRGB(27, 42, 53)
CB.BorderSizePixel = 0
CB.Position = UDim2.new(0.194999978, 0, 0.227000043, 0)
CB.Size = UDim2.new(0, 387, 0, 254)
CB.Font = Enum.Font.SourceSans
CB.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
CB.Text = ""
CB.TextColor3 = Color3.fromRGB(255, 255, 255)
CB.TextSize = 14.000
CB.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
CB.TextXAlignment = Enum.TextXAlignment.Left
CB.TextYAlignment = Enum.TextYAlignment.Top

cmdlist.Name = "cmdlist"
cmdlist.Parent = HBADMIN
cmdlist.Active = true
cmdlist.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
cmdlist.BorderColor3 = Color3.fromRGB(27, 27, 27)
cmdlist.BorderSizePixel = 0
cmdlist.Position = UDim2.new(0.40200001, 0, 0.428000003, 0)
cmdlist.Size = UDim2.new(0, 356, 0, 0)
cmdlist.ZIndex = 2
cmdlist.BottomImage = ""
cmdlist.MidImage = ""
cmdlist.ScrollBarThickness = 5
cmdlist.TopImage = ""
cmdlist.Draggable = true

commandlabels.Name = "commandlabels"
commandlabels.Parent = cmdlist

UIGridLayout.Parent = commandlabels
UIGridLayout.FillDirection = Enum.FillDirection.Vertical
UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellSize = UDim2.new(0, 200, 0, 20)



Toolbar_2.Name = "Toolbar"
Toolbar_2.Parent = cmdlist
Toolbar_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toolbar_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
Toolbar_2.BorderSizePixel = 0
Toolbar_2.Size = UDim2.new(0, 356, 0, 28)

Minimize_2.Name = "Minimize"
Minimize_2.Parent = Toolbar_2
Minimize_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Minimize_2.BorderSizePixel = 0
Minimize_2.ClipsDescendants = true
Minimize_2.Position = UDim2.new(0.815999925, 0, 0, 0)
Minimize_2.Size = UDim2.new(0, 32, 0, 28)
Minimize_2.Font = Enum.Font.SourceSansLight
Minimize_2.Text = "-"
Minimize_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize_2.TextSize = 23.000
Minimize_2.TextWrapped = true

TextLabel_2.Parent = Toolbar_2
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 10.000
TextLabel_2.ClipsDescendants = true
TextLabel_2.Size = UDim2.new(0, 141, 0, 25)
TextLabel_2.Font = Enum.Font.SourceSans
TextLabel_2.Text = "Command Prompt"
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextSize = 14.000
TextLabel_2.TextWrapped = true

ImageLabel_2.Parent = Toolbar_2
ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_2.BackgroundTransparency = 10.000
ImageLabel_2.Position = UDim2.new(0, 0, 0.214000002, 0)
ImageLabel_2.Size = UDim2.new(0, 22, 0, 15)
ImageLabel_2.Image = "http://www.roblox.com/asset/?id=5533575307"
ImageLabel_2.ScaleType = Enum.ScaleType.Fit

Close_2.Name = "Close"
Close_2.Parent = Toolbar_2
Close_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Close_2.BorderSizePixel = 0
Close_2.ClipsDescendants = true
Close_2.Position = UDim2.new(0.899999976, 0, 0, 0)
Close_2.Size = UDim2.new(0, 32, 0, 28)
Close_2.Font = Enum.Font.SourceSansLight
Close_2.Text = "X"
Close_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Close_2.TextSize = 23.000
Close_2.TextWrapped = true

PR.Name = "PR"
PR.Parent = HBADMIN
PR.ResetOnSpawn = false

Holder.Name = "Holder"
Holder.Parent = PR
Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Holder.BackgroundTransparency = 1.000
Holder.Position = UDim2.new(0.541502237, 0, 0.287124187, 0)
Holder.Size = UDim2.new(0, 440, 0, 239)
Holder.Visible = false
Holder.Image = "rbxassetid://3570695787"
Holder.ImageColor3 = Color3.fromRGB(27, 27, 27)
Holder.ScaleType = Enum.ScaleType.Slice
Holder.SliceCenter = Rect.new(100, 100, 100, 100)
Holder.SliceScale = 0.050

EditorFrame.Name = "EditorFrame"
EditorFrame.Parent = Holder
EditorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EditorFrame.BackgroundTransparency = 1.000
EditorFrame.Position = UDim2.new(0.0682900175, 0, 0.141047776, 0)
EditorFrame.Size = UDim2.new(0, 386, 0, 155)
EditorFrame.Image = "rbxassetid://3570695787"
EditorFrame.ImageColor3 = Color3.fromRGB(31, 31, 31)
EditorFrame.ScaleType = Enum.ScaleType.Slice
EditorFrame.SliceCenter = Rect.new(100, 100, 100, 100)
EditorFrame.SliceScale = 0.050

Source.Name = "Source"
Source.Parent = EditorFrame
Source.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Source.BackgroundTransparency = 1.000
Source.Position = UDim2.new(0, 27, 0, 9)
Source.Size = UDim2.new(0.930083036, 0, 0.94193548, 0)
Source.ZIndex = 3
Source.ClearTextOnFocus = false
Source.Font = Enum.Font.Code
Source.MultiLine = true
Source.PlaceholderColor3 = Color3.fromRGB(204, 204, 204)
Source.Text = "print(\"PRX!)"
Source.TextColor3 = Color3.fromRGB(204, 204, 204)
Source.TextSize = 15.000
Source.TextXAlignment = Enum.TextXAlignment.Left
Source.TextYAlignment = Enum.TextYAlignment.Top

Comments_.Name = "Comments_"
Comments_.Parent = Source
Comments_.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Comments_.BackgroundTransparency = 1.000
Comments_.Size = UDim2.new(1, 0, 1, 0)
Comments_.ZIndex = 5
Comments_.Font = Enum.Font.Code
Comments_.Text = ""
Comments_.TextColor3 = Color3.fromRGB(59, 200, 59)
Comments_.TextSize = 15.000
Comments_.TextXAlignment = Enum.TextXAlignment.Left
Comments_.TextYAlignment = Enum.TextYAlignment.Top

Globals_.Name = "Globals_"
Globals_.Parent = Source
Globals_.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Globals_.BackgroundTransparency = 1.000
Globals_.Size = UDim2.new(1, 0, 1, 0)
Globals_.ZIndex = 5
Globals_.Font = Enum.Font.Code
Globals_.Text = ""
Globals_.TextColor3 = Color3.fromRGB(132, 214, 247)
Globals_.TextSize = 15.000
Globals_.TextXAlignment = Enum.TextXAlignment.Left
Globals_.TextYAlignment = Enum.TextYAlignment.Top

Keywords_.Name = "Keywords_"
Keywords_.Parent = Source
Keywords_.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Keywords_.BackgroundTransparency = 1.000
Keywords_.Size = UDim2.new(1, 0, 1, 0)
Keywords_.ZIndex = 5
Keywords_.Font = Enum.Font.Code
Keywords_.Text = ""
Keywords_.TextColor3 = Color3.fromRGB(248, 109, 124)
Keywords_.TextSize = 15.000
Keywords_.TextXAlignment = Enum.TextXAlignment.Left
Keywords_.TextYAlignment = Enum.TextYAlignment.Top

RemoteHighlight_.Name = "RemoteHighlight_"
RemoteHighlight_.Parent = Source
RemoteHighlight_.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RemoteHighlight_.BackgroundTransparency = 1.000
RemoteHighlight_.Size = UDim2.new(1, 0, 1, 0)
RemoteHighlight_.ZIndex = 5
RemoteHighlight_.Font = Enum.Font.Code
RemoteHighlight_.Text = ""
RemoteHighlight_.TextColor3 = Color3.fromRGB(0, 144, 255)
RemoteHighlight_.TextSize = 15.000
RemoteHighlight_.TextXAlignment = Enum.TextXAlignment.Left
RemoteHighlight_.TextYAlignment = Enum.TextYAlignment.Top

Strings_.Name = "Strings_"
Strings_.Parent = Source
Strings_.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Strings_.BackgroundTransparency = 1.000
Strings_.Size = UDim2.new(1, 0, 1, 0)
Strings_.ZIndex = 5
Strings_.Font = Enum.Font.Code
Strings_.Text = ""
Strings_.TextColor3 = Color3.fromRGB(173, 241, 149)
Strings_.TextSize = 15.000
Strings_.TextXAlignment = Enum.TextXAlignment.Left
Strings_.TextYAlignment = Enum.TextYAlignment.Top

Tokens_.Name = "Tokens_"
Tokens_.Parent = Source
Tokens_.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tokens_.BackgroundTransparency = 1.000
Tokens_.Size = UDim2.new(1, 0, 1, 0)
Tokens_.ZIndex = 5
Tokens_.Font = Enum.Font.Code
Tokens_.Text = ""
Tokens_.TextColor3 = Color3.fromRGB(255, 255, 255)
Tokens_.TextSize = 15.000
Tokens_.TextXAlignment = Enum.TextXAlignment.Left
Tokens_.TextYAlignment = Enum.TextYAlignment.Top

Numbers_.Name = "Numbers_"
Numbers_.Parent = Source
Numbers_.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Numbers_.BackgroundTransparency = 1.000
Numbers_.Size = UDim2.new(1, 0, 1, 0)
Numbers_.ZIndex = 4
Numbers_.Font = Enum.Font.Code
Numbers_.Text = ""
Numbers_.TextColor3 = Color3.fromRGB(255, 198, 0)
Numbers_.TextSize = 15.000
Numbers_.TextXAlignment = Enum.TextXAlignment.Left
Numbers_.TextYAlignment = Enum.TextYAlignment.Top

Hide.Name = "Hide"
Hide.Parent = Source
Hide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Hide.BackgroundTransparency = 1.000
Hide.Position = UDim2.new(-0.00372214313, 0, 0, 0)
Hide.Size = UDim2.new(0, 379, 0, 189)
Hide.ZIndex = 6
Hide.Image = "rbxassetid://3570695787"
Hide.ImageColor3 = Color3.fromRGB(33, 33, 33)
Hide.ImageTransparency = 1.000
Hide.ScaleType = Enum.ScaleType.Slice
Hide.SliceCenter = Rect.new(100, 100, 100, 100)
Hide.SliceScale = 0.120

Lines.Name = "Lines"
Lines.Parent = EditorFrame
Lines.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Lines.BackgroundTransparency = 1.000
Lines.Position = UDim2.new(0, 0, 0.0580645166, 0)
Lines.Size = UDim2.new(-0.0236694496, 30, 0.94193548, 0)
Lines.ZIndex = 4
Lines.Font = Enum.Font.Code
Lines.Text = "1"
Lines.TextColor3 = Color3.fromRGB(255, 255, 255)
Lines.TextSize = 15.000
Lines.TextYAlignment = Enum.TextYAlignment.Top

Execute.Name = "Execute"
Execute.Parent = Holder
Execute.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Execute.BackgroundTransparency = 1.000
Execute.BorderSizePixel = 0
Execute.Position = UDim2.new(0.0682900175, 0, 0.827969491, 0)
Execute.Size = UDim2.new(0, 83, 0, 30)
Execute.ZIndex = 2
Execute.Font = Enum.Font.SourceSansItalic
Execute.Text = "Execute"
Execute.TextColor3 = Color3.fromRGB(85, 255, 127)
Execute.TextSize = 14.000

TextButton_Roundify_5px.Name = "TextButton_Roundify_5px"
TextButton_Roundify_5px.Parent = Execute
TextButton_Roundify_5px.Active = true
TextButton_Roundify_5px.AnchorPoint = Vector2.new(0.5, 0.5)
TextButton_Roundify_5px.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_Roundify_5px.BackgroundTransparency = 1.000
TextButton_Roundify_5px.Position = UDim2.new(0.5, 0, 0.5, 0)
TextButton_Roundify_5px.Selectable = true
TextButton_Roundify_5px.Size = UDim2.new(1, 0, 1, 0)
TextButton_Roundify_5px.Image = "rbxassetid://3570695787"
TextButton_Roundify_5px.ImageColor3 = Color3.fromRGB(31, 31, 31)
TextButton_Roundify_5px.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_5px.SliceCenter = Rect.new(100, 100, 100, 100)
TextButton_Roundify_5px.SliceScale = 0.050



Clear.Name = "Clear"
Clear.Parent = Holder
Clear.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Clear.BackgroundTransparency = 1.000
Clear.BorderSizePixel = 0
Clear.Position = UDim2.new(0.282207817, 0, 0.827969491, 0)
Clear.Size = UDim2.new(0, 83, 0, 30)
Clear.ZIndex = 2
Clear.Font = Enum.Font.SourceSansItalic
Clear.Text = "Clear"
Clear.TextColor3 = Color3.fromRGB(85, 255, 127)
Clear.TextSize = 14.000

TextButton_Roundify_5px_2.Name = "TextButton_Roundify_5px"
TextButton_Roundify_5px_2.Parent = Clear
TextButton_Roundify_5px_2.Active = true
TextButton_Roundify_5px_2.AnchorPoint = Vector2.new(0.5, 0.5)
TextButton_Roundify_5px_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_Roundify_5px_2.BackgroundTransparency = 1.000
TextButton_Roundify_5px_2.Position = UDim2.new(0.5, 0, 0.5, 0)
TextButton_Roundify_5px_2.Selectable = true
TextButton_Roundify_5px_2.Size = UDim2.new(1, 0, 1, 0)
TextButton_Roundify_5px_2.Image = "rbxassetid://3570695787"
TextButton_Roundify_5px_2.ImageColor3 = Color3.fromRGB(31, 31, 31)
TextButton_Roundify_5px_2.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_5px_2.SliceCenter = Rect.new(100, 100, 100, 100)
TextButton_Roundify_5px_2.SliceScale = 0.050



Respawn.Name = "Respawn"
Respawn.Parent = Holder
Respawn.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Respawn.BackgroundTransparency = 1.000
Respawn.BorderSizePixel = 0
Respawn.Position = UDim2.new(0.755945086, 0, 0.827969491, 0)
Respawn.Size = UDim2.new(0, 83, 0, 30)
Respawn.ZIndex = 2
Respawn.Font = Enum.Font.SourceSansItalic
Respawn.Text = "Respawn"
Respawn.TextColor3 = Color3.fromRGB(85, 255, 127)
Respawn.TextSize = 14.000

TextButton_Roundify_5px_3.Name = "TextButton_Roundify_5px"
TextButton_Roundify_5px_3.Parent = Respawn
TextButton_Roundify_5px_3.Active = true
TextButton_Roundify_5px_3.AnchorPoint = Vector2.new(0.5, 0.5)
TextButton_Roundify_5px_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_Roundify_5px_3.BackgroundTransparency = 1.000
TextButton_Roundify_5px_3.Position = UDim2.new(0.5, 0, 0.5, 0)
TextButton_Roundify_5px_3.Selectable = true
TextButton_Roundify_5px_3.Size = UDim2.new(1, 0, 1, 0)
TextButton_Roundify_5px_3.Image = "rbxassetid://3570695787"
TextButton_Roundify_5px_3.ImageColor3 = Color3.fromRGB(31, 31, 31)
TextButton_Roundify_5px_3.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_5px_3.SliceCenter = Rect.new(100, 100, 100, 100)
TextButton_Roundify_5px_3.SliceScale = 0.050



Close_3.Name = "Close"
Close_3.Parent = Holder
Close_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Close_3.BackgroundTransparency = 10.000
Close_3.BorderSizePixel = 0
Close_3.Position = UDim2.new(0.897727251, 0, 0, 0)
Close_3.Size = UDim2.new(0, 45, 0, 25)
Close_3.Font = Enum.Font.SourceSans
Close_3.Text = "-"
Close_3.TextColor3 = Color3.fromRGB(85, 255, 127)
Close_3.TextScaled = true
Close_3.TextSize = 14.000
Close_3.TextWrapped = true

R6.Name = "R6"
R6.Parent = Holder
R6.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
R6.BackgroundTransparency = 1.000
R6.BorderSizePixel = 0
R6.Position = UDim2.new(0.539754689, 0, 0.827969491, 0)
R6.Size = UDim2.new(0, 83, 0, 30)
R6.ZIndex = 2
R6.Font = Enum.Font.SourceSansItalic
R6.Text = "R6"
R6.TextColor3 = Color3.fromRGB(85, 255, 127)
R6.TextSize = 14.000

TextButton_Roundify_5px_4.Name = "TextButton_Roundify_5px"
TextButton_Roundify_5px_4.Parent = R6
TextButton_Roundify_5px_4.Active = true
TextButton_Roundify_5px_4.AnchorPoint = Vector2.new(0.5, 0.5)
TextButton_Roundify_5px_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_Roundify_5px_4.BackgroundTransparency = 1.000
TextButton_Roundify_5px_4.Position = UDim2.new(0.5, 0, 0.5, 0)
TextButton_Roundify_5px_4.Selectable = true
TextButton_Roundify_5px_4.Size = UDim2.new(1, 0, 1, 0)
TextButton_Roundify_5px_4.Image = "rbxassetid://3570695787"
TextButton_Roundify_5px_4.ImageColor3 = Color3.fromRGB(31, 31, 31)
TextButton_Roundify_5px_4.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_5px_4.SliceCenter = Rect.new(100, 100, 100, 100)
TextButton_Roundify_5px_4.SliceScale = 0.050


ImageLabel_3.Parent = Holder
ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_3.BackgroundTransparency = 10.000
ImageLabel_3.Position = UDim2.new(0, 0, 0, 3)
ImageLabel_3.Size = UDim2.new(0, 53, 0, 32)
ImageLabel_3.Image = "http://www.roblox.com/asset/?id=4957865030"

Open.Name = "Open"
Open.Parent = PR
Open.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
Open.BorderColor3 = Color3.fromRGB(85, 255, 127)
Open.BorderSizePixel = 0
Open.Position = UDim2.new(0.964567602, 0, 0.429322094, 0)
Open.Size = UDim2.new(0, 58, 0, 35)
Open.Visible = false

TextButton.Parent = Open
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 10.000
TextButton.Position = UDim2.new(-3.57627869e-07, 0, -1.04308128e-07, 0)
TextButton.Size = UDim2.new(0, 58, 0, 35)
TextButton.Font = Enum.Font.GothamBold
TextButton.Text = "OPEN"
TextButton.TextColor3 = Color3.fromRGB(85, 255, 127)
TextButton.TextSize = 14.000

Loading.Name = "Loading..."
Loading.Parent = HBADMIN
Loading.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Loading.BorderSizePixel = 0
Loading.ClipsDescendants = true
Loading.Position = UDim2.new(0.370000005, 0, 0.507000029, 0)
Loading.Size = UDim2.new(0, 426, 0, 0)

checking.Name = "checking"
checking.Parent = Loading
checking.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
checking.BackgroundTransparency = 10.000
checking.ClipsDescendants = true
checking.Position = UDim2.new(0.264042228, 0, 0.934000015, 0)
checking.Size = UDim2.new(0, 200, 0, 50)
checking.Font = Enum.Font.SourceSansLight
checking.Text = "Checking Access..."
checking.TextColor3 = Color3.fromRGB(255, 255, 255)
checking.TextScaled = true
checking.TextSize = 30.000
checking.TextWrapped = true

whitelisted.Name = "whitelisted"
whitelisted.Parent = Loading
whitelisted.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
whitelisted.BackgroundTransparency = 10.000
whitelisted.ClipsDescendants = true
whitelisted.Position = UDim2.new(0.305999994, 0, 0.986000001, 0)
whitelisted.Size = UDim2.new(0, 147, 0, 30)
whitelisted.Font = Enum.Font.SourceSansLight
whitelisted.Text = "Access Granted!"
whitelisted.TextColor3 = Color3.fromRGB(17, 255, 0)
whitelisted.TextScaled = true
whitelisted.TextSize = 30.000
whitelisted.TextWrapped = true

info.Name = "info"
info.Parent = Loading
info.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
info.BackgroundTransparency = 10.000
info.ClipsDescendants = true
info.Position = UDim2.new(0.287220657, 0, 0.943904757, 0)
info.Size = UDim2.new(0, 173, 0, 40)
info.Font = Enum.Font.SourceSansLight
info.Text = ""
info.TextColor3 = Color3.fromRGB(255, 255, 255)
info.TextScaled = true
info.TextSize = 30.000
info.TextWrapped = true

blacklisted.Name = "blacklisted"
blacklisted.Parent = Loading
blacklisted.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
blacklisted.BackgroundTransparency = 10.000
blacklisted.ClipsDescendants = true
blacklisted.Position = UDim2.new(0.305999994, 0, 0.986000001, 0)
blacklisted.Size = UDim2.new(0, 147, 0, 30)
blacklisted.Font = Enum.Font.SourceSansLight
blacklisted.Text = "Access Denied!"
blacklisted.TextColor3 = Color3.fromRGB(255, 0, 0)
blacklisted.TextScaled = true
blacklisted.TextSize = 30.000
blacklisted.TextWrapped = true

line.Name = "line"
line.Parent = Loading
line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
line.BackgroundTransparency = 1.000
line.Position = UDim2.new(0.0790000036, 0, 1.03400004, 0)
line.Size = UDim2.new(0, 340, 0, 2)
line.Image = "rbxassetid://2790382281"
line.ScaleType = Enum.ScaleType.Slice
line.SliceCenter = Rect.new(4, 4, 252, 252)

PROMPT.Name = "PROMPT"
PROMPT.Parent = Loading
PROMPT.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PROMPT.BackgroundTransparency = 10.000
PROMPT.ClipsDescendants = true
PROMPT.Position = UDim2.new(0.923399091, 0, 0.191, 0)
PROMPT.Size = UDim2.new(0, 200, 0, 50)
PROMPT.Font = Enum.Font.SourceSansLight
PROMPT.Text = " ADMIN"
PROMPT.TextColor3 = Color3.fromRGB(255, 255, 255)
PROMPT.TextScaled = true
PROMPT.TextSize = 14.000
PROMPT.TextWrapped = true

COMMAND.Name = "COMMAND"
COMMAND.Parent = Loading
COMMAND.Active = true
COMMAND.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
COMMAND.BackgroundTransparency = 10.000
COMMAND.ClipsDescendants = true
COMMAND.Position = UDim2.new(-0.437821597, 0, 0.191, 0)
COMMAND.Size = UDim2.new(0, 200, 0, 50)
COMMAND.Font = Enum.Font.SourceSansLight
COMMAND.Text = "HOMEBREW"
COMMAND.TextColor3 = Color3.fromRGB(255, 255, 255)
COMMAND.TextScaled = true
COMMAND.TextSize = 14.000
COMMAND.TextWrapped = true

system32.Name = "system32"
system32.Parent = Loading
system32.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
system32.BackgroundTransparency = 10.000
system32.Position = UDim2.new(0.256120145, 0, 0.390839636, 0)
system32.Size = UDim2.new(0, 184, 0, 44)
system32.Font = Enum.Font.SourceSansLight
system32.Text = ""
system32.TextColor3 = Color3.fromRGB(255, 255, 255)
system32.TextScaled = true
system32.TextSize = 14.000
system32.TextWrapped = true

Toolbar_3.Name = "Toolbar"
Toolbar_3.Parent = Loading
Toolbar_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toolbar_3.BorderColor3 = Color3.fromRGB(27, 42, 53)
Toolbar_3.BorderSizePixel = 0
Toolbar_3.Size = UDim2.new(0, 426, 0, 27)

Close_4.Name = "Close"
Close_4.Parent = Toolbar_3
Close_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Close_4.BorderSizePixel = 0
Close_4.Position = UDim2.new(0.923399031, 0, 0, 0)
Close_4.Size = UDim2.new(0, 32, 0, 27)
Close_4.Font = Enum.Font.SourceSansLight
Close_4.Text = "X"
Close_4.TextColor3 = Color3.fromRGB(255, 255, 255)
Close_4.TextSize = 23.000
Close_4.TextWrapped = true

Minimize_3.Name = "Minimize"
Minimize_3.Parent = Toolbar_3
Minimize_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Minimize_3.BorderSizePixel = 0
Minimize_3.Position = UDim2.new(0.848281622, 0, 0, 0)
Minimize_3.Size = UDim2.new(0, 32, 0, 25)
Minimize_3.Font = Enum.Font.SourceSansLight
Minimize_3.Text = "-"
Minimize_3.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimize_3.TextSize = 23.000
Minimize_3.TextWrapped = true

TextLabel_3.Parent = Toolbar_3
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 10.000
TextLabel_3.Size = UDim2.new(0, 141, 0, 25)
TextLabel_3.Font = Enum.Font.SourceSans
TextLabel_3.Text = "Command Prompt"
TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.TextSize = 14.000
TextLabel_3.TextWrapped = true

ImageLabel_4.Parent = Loading
ImageLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_4.BackgroundTransparency = 10.000
ImageLabel_4.Position = UDim2.new(0, 0, 0.0238095243, 0)
ImageLabel_4.Size = UDim2.new(0, 22, 0, 15)
ImageLabel_4.Image = "http://www.roblox.com/asset/?id=5533575307"
ImageLabel_4.ScaleType = Enum.ScaleType.Fit

-- Scripts:

local function JRNGOD_fake_script() -- Close.hover 
	local script = Instance.new('LocalScript', Close)

	script.Parent.MouseEnter:Connect(function()
		game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(255, 0, 0)
		}):Play()
		game:GetService("TweenService"):Create(script.Parent.Parent.Close, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(255, 0, 0)
		}):Play()
	end)
	
	script.Parent.MouseLeave:Connect(function()
		game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(0, 0, 0)
		}):Play()
		game:GetService("TweenService"):Create(script.Parent.Parent.Close, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(0, 0, 0)
		}):Play()
	end)
end
coroutine.wrap(JRNGOD_fake_script)()
local function HHNIX_fake_script() -- Close.LocalScript 
	local script = Instance.new('LocalScript', Close)

	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Parent.Parent.HBADMIN:TweenPosition(UDim2.new(0.677, 0, 1, 0, "Out", "Quad", 0.5))
	end)
end
coroutine.wrap(HHNIX_fake_script)()
local function SLHWJJP_fake_script() -- Minimize.hover 
	local script = Instance.new('LocalScript', Minimize)

	script.Parent.MouseEnter:Connect(function()
		game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(20, 20, 20)
		}):Play()
		game:GetService("TweenService"):Create(script.Parent.Parent.Minimize, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(20, 20, 20)
		}):Play()
	end)
	
	script.Parent.MouseLeave:Connect(function()
		game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(0, 0, 0)
		}):Play()
		game:GetService("TweenService"):Create(script.Parent.Parent.Minimize, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(0, 0, 0)
		}):Play()
	end)
end
coroutine.wrap(SLHWJJP_fake_script)()
local function VBNWX_fake_script() -- HBADMIN_2.d=drag 
	local script = Instance.new('LocalScript', HBADMIN_2)

	local a = game:GetService("UserInputService")
	function drag(b)
		dragToggle = nil
		dragSpeed = 0.23
		dragInput = nil
		dragStart = nil
		dragPos = nil
		function updateInput(a)
			Delta = a.Position - dragStart
			Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			game:GetService("TweenService"):Create(b, TweenInfo.new(0.25), {
				Position = Position
			}):Play()
		end
		b.InputBegan:Connect(function(c)
			if (c.UserInputType == Enum.UserInputType.MouseButton1 or c.UserInputType == Enum.UserInputType.Touch) and a:GetFocusedTextBox() == nil then
				dragToggle = true
				dragStart = c.Position
				startPos = b.Position
				c.Changed:Connect(function()
					if c.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end)
		b.InputChanged:Connect(function(a)
			if a.UserInputType == Enum.UserInputType.MouseMovement or a.UserInputType == Enum.UserInputType.Touch then
				dragInput = a
			end
		end)
		game:GetService("UserInputService").InputChanged:Connect(function(a)
			if a == dragInput and dragToggle then
				updateInput(a)
			end
		end)
	end
	drag(script.Parent)
end
coroutine.wrap(VBNWX_fake_script)()
local function VOXX_fake_script() -- cmdlist.d=drag 
	local script = Instance.new('LocalScript', cmdlist)

	local a = game:GetService("UserInputService")
	function drag(b)
		dragToggle = nil
		dragSpeed = 0.23
		dragInput = nil
		dragStart = nil
		dragPos = nil
		function updateInput(a)
			Delta = a.Position - dragStart
			Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			game:GetService("TweenService"):Create(b, TweenInfo.new(0.25), {
				Position = Position
			}):Play()
		end
		b.InputBegan:Connect(function(c)
			if (c.UserInputType == Enum.UserInputType.MouseButton1 or c.UserInputType == Enum.UserInputType.Touch) and a:GetFocusedTextBox() == nil then
				dragToggle = true
				dragStart = c.Position
				startPos = b.Position
				c.Changed:Connect(function()
					if c.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end)
		b.InputChanged:Connect(function(a)
			if a.UserInputType == Enum.UserInputType.MouseMovement or a.UserInputType == Enum.UserInputType.Touch then
				dragInput = a
			end
		end)
		game:GetService("UserInputService").InputChanged:Connect(function(a)
			if a == dragInput and dragToggle then
				updateInput(a)
			end
		end)
	end
	drag(script.Parent)
end
coroutine.wrap(VOXX_fake_script)()
local function QJOHSG_fake_script() -- Minimize_2.hover 
	local script = Instance.new('LocalScript', Minimize_2)

	script.Parent.MouseEnter:Connect(function()
		game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(20, 20, 20)
		}):Play()
		game:GetService("TweenService"):Create(script.Parent.Parent.Minimize, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(20, 20, 20)
		}):Play()
	end)
	
	script.Parent.MouseLeave:Connect(function()
		game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(0, 0, 0)
		}):Play()
		game:GetService("TweenService"):Create(script.Parent.Parent.Minimize, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(0, 0, 0)
		}):Play()
	end)
end
coroutine.wrap(QJOHSG_fake_script)()
local function IAHXQ_fake_script() -- Close_2.hover 
	local script = Instance.new('LocalScript', Close_2)

	script.Parent.MouseEnter:Connect(function()
		game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(255, 0, 0)
		}):Play()
		game:GetService("TweenService"):Create(script.Parent.Parent.Close, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(255, 0, 0)
		}):Play()
	end)
	
	script.Parent.MouseLeave:Connect(function()
		game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(0, 0, 0)
		}):Play()
		game:GetService("TweenService"):Create(script.Parent.Parent.Close, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(0, 0, 0)
		}):Play()
	end)
end
coroutine.wrap(IAHXQ_fake_script)()
local function UZISLFB_fake_script() -- Close_2.LocalScript 
	local script = Instance.new('LocalScript', Close_2)

	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Parent.Parent.cmdlist:TweenPosition(UDim2.new(0.402, 0, 0.428, 0, "Out", "Quad", 0.5))
		script.Parent.Parent.Parent.Parent.cmdlist:TweenSize(UDim2.new(0, 356, 0, 0, "Out", "Quad", 0.5))
	end)
end
coroutine.wrap(UZISLFB_fake_script)()

local function BUNI_fake_script() -- Execute.dad 
	local script = Instance.new('LocalScript', Execute)

	-- scripted by dada
	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.epic:FireServer(script.Parent.Parent.EditorFrame.Source.Text)
	end)
	
	
end
coroutine.wrap(BUNI_fake_script)()



local function HEQSU_fake_script() -- Respawn.Script 
	local script = Instance.new('Script', Respawn)

	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Parent.Parent.Parent:LoadCharacter()
	end)
end
coroutine.wrap(HEQSU_fake_script)()
local function YGOQ_fake_script() -- Close_3.LocalScript 
	local script = Instance.new('LocalScript', Close_3)

	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Parent.Open.Visible = true
		script.Parent.Parent.Parent.Holder.Visible = false
	end)
end
coroutine.wrap(YGOQ_fake_script)()
local function AZMS_fake_script() -- Holder.LocalScript 
	local script = Instance.new('LocalScript', Holder)

	local lua_keywords = {"and","break","do","else","elseif","end","false","for","function","goto","if","in","local","nil","not","or","repeat","return","then","true","until","while"}
	local global_env = {"getrawmetatable","game","workspace","script","math","string","table","print","wait","BrickColor","Color3","next","pairs","ipairs","select","unpack","Instance","Vector2","Vector3","CFrame","Ray","UDim2","Enum","assert","error","warn","tick","loadstring","_G","shared","getfenv","setfenv","newproxy","setmetatable","getmetatable","os","debug","pcall","ypcall","xpcall","rawequal","rawset","rawget","tonumber","tostring","type","typeof","_VERSION","coroutine","delay","require","spawn","LoadLibrary","settings","stats","time","UserSettings","version","Axes","ColorSequence","Faces","ColorSequenceKeypoint","NumberRange","NumberSequence","NumberSequenceKeypoint","gcinfo","elapsedTime","collectgarbage","PhysicalProperties","Rect","Region3","Region3int16","UDim","Vector2int16","Vector3int16"}
	
	local Source = script.Parent.EditorFrame.Source
	local Lines = Source.Parent.Lines
	
	local Highlight = function(string, keywords)
		local K = {}
		local S = string
		local Token =
	    {["="] = true,["."] = true,[","] = true,["("] = true,[")"] = true,["["] = true,["]"] = true,["{"] = true,["}"] = true,[":"] = true,["*"] = true,["/"] = true,["+"] = true,["-"] = true,["%"] = true,[";"] = true,["~"] = true}
		for i, v in pairs(keywords) do
			K[v] = true
		end
		S = S:gsub(".", function(c)
			if Token[c] ~= nil then
				return "\32"
			else
				return c
			end
		end)
		S = S:gsub("%S+", function(c)
			if K[c] ~= nil then
				return c
			else
				return (" "):rep(#c)
			end
		end)
		return S
	end
	
	local hTokens = function(string)
		local Token =
	    {["="] = true,["."] = true,[","] = true,["("] = true,[")"] = true,["["] = true,["]"] = true,["{"] = true,["}"] = true,[":"] = true,["*"] = true,["/"] = true,["+"] = true,["-"] = true,["%"] = true,[";"] = true,["~"] = true}
		local A = ""
		string:gsub(".", function(c)
			if Token[c] ~= nil then
				A = A .. c
			elseif c == "\n" then
				A = A .. "\n"
			elseif c == "\t" then
				A = A .. "\t"
			else
				A = A .. "\32"
			end
		end)
		return A
	end
	
	
	local strings = function(string)
		local highlight = ""
		local quote = false
		string:gsub(".", function(c)
			if quote == false and c == "\"" then
				quote = true
			elseif quote == true and c == "\"" then
				quote = false
			end
			if quote == false and c == "\"" then
				highlight = highlight .. "\""
			elseif c == "\n" then
				highlight = highlight .. "\n"
			elseif c == "\t" then
				highlight = highlight .. "\t"
			elseif quote == true then
				highlight = highlight .. c
			elseif quote == false then
				highlight = highlight .. "\32"
			end
		end)
		return highlight
	end
	
	local comments = function(string)
		local ret = ""
		string:gsub("[^\r\n]+", function(c)
			local comm = false
			local i = 0
			c:gsub(".", function(n)
				i = i + 1
				if c:sub(i, i + 1) == "--" then
					comm = true
				end
				if comm == true then
					ret = ret .. n
				else
					ret = ret .. "\32"
				end
			end)
			ret = ret
		end)
		return ret
	end
	
	local numbers = function(string)
		local A = ""
		string:gsub(".", function(c)
			if tonumber(c) ~= nil then
				A = A .. c
			elseif c == "\n" then
				A = A .. "\n"
			elseif c == "\t" then
				A = A .. "\t"
			else
				A = A .. "\32"
			end
		end)
		return A
	end
	
	local highlight_source = function(type)
		if type == "Text" then
			Source.Text = Source.Text:gsub("\13", "")
			Source.Text = Source.Text:gsub("\t", "      ")
			local s = Source.Text
			Source.Keywords_.Text = Highlight(s, lua_keywords)
			Source.Globals_.Text = Highlight(s, global_env)
			Source.RemoteHighlight_.Text = Highlight(s, {
				"FireServer",
				"fireServer",
				"InvokeServer",
				"invokeServer"
			})
			Source.Tokens_.Text = hTokens(s)
			Source.Numbers_.Text = numbers(s)
			Source.Strings_.Text = strings(s)
			local lin = 1
			s:gsub("\n", function()
				lin = lin + 1
			end)
			Lines.Text = ""
			for i = 1, lin do
				Lines.Text = Lines.Text .. i .. "\n"
			end
		end
	end
	
	highlight_source("Text")
	
	Source.Changed:Connect(highlight_source)
end
coroutine.wrap(AZMS_fake_script)()
local function QYYH_fake_script() -- Holder.d=drag 
	local script = Instance.new('LocalScript', Holder)

	local a = game:GetService("UserInputService")
	function drag(b)
		dragToggle = nil
		dragSpeed = 0.23
		dragInput = nil
		dragStart = nil
		dragPos = nil
		function updateInput(a)
			Delta = a.Position - dragStart
			Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			game:GetService("TweenService"):Create(b, TweenInfo.new(0.25), {
				Position = Position
			}):Play()
		end
		b.InputBegan:Connect(function(c)
			if (c.UserInputType == Enum.UserInputType.MouseButton1 or c.UserInputType == Enum.UserInputType.Touch) and a:GetFocusedTextBox() == nil then
				dragToggle = true
				dragStart = c.Position
				startPos = b.Position
				c.Changed:Connect(function()
					if c.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end)
		b.InputChanged:Connect(function(a)
			if a.UserInputType == Enum.UserInputType.MouseMovement or a.UserInputType == Enum.UserInputType.Touch then
				dragInput = a
			end
		end)
		game:GetService("UserInputService").InputChanged:Connect(function(a)
			if a == dragInput and dragToggle then
				updateInput(a)
			end
		end)
	end
	drag(script.Parent)
end
coroutine.wrap(QYYH_fake_script)()
local function NSPRKS_fake_script() -- Holder.ClearFunction 
	local script = Instance.new('LocalScript', Holder)

	--Variables--
	local Source = script.Parent.EditorFrame.Source
	local Clear = script.Parent.Clear 
	--scripts--
	
	Clear.MouseButton1Click:Connect(function()
		Source.Text = ""
	end)
end
coroutine.wrap(NSPRKS_fake_script)()

local function VLGLAAI_fake_script() -- R6.Script 
	local script = Instance.new('Script', R6)

	script.Parent.MouseButton1Click:Connect(function()
		require(3068366282):Fire(script.Parent.Parent.Parent.Parent.Parent.Name)
	end)
end
coroutine.wrap(VLGLAAI_fake_script)()
local function PMSB_fake_script() -- TextButton.LocalScript 
	local script = Instance.new('LocalScript', TextButton)

	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Parent.Open.Visible = false
		script.Parent.Parent.Parent.Holder.Visible = true
	end)
end
coroutine.wrap(PMSB_fake_script)()
local function GYPUAV_fake_script() -- Loading.functions 
	local script = Instance.new('LocalScript', Loading)

	local text = ">SYSTEM32"
	
	script.Parent:TweenPosition(UDim2.new(0.37, 0, 0.331, 0, "Out", "Quad", 0.5))
	script.Parent:TweenSize(UDim2.new(0, 426, 0, 210, "Out", "Quad", 0.5)
	)
	
	wait(1)
	script.Parent.COMMAND:TweenPosition(UDim2.new(0.079, 0, 0.191, 0, "Out", "Quad", 0.5))
	script.Parent.PROMPT:TweenPosition(UDim2.new(0.477, 0, 0.191, 0, "Out", "Quad", 0.5)
	)
	wait(1)
	for  i = 1, #text do
		script.Parent.system32.Text = string.sub (text, 1, i)
		wait(0.09)
	end
end
coroutine.wrap(GYPUAV_fake_script)()
local function RBUUDS_fake_script() -- Loading.whitelistscript 
	local script = Instance.new('LocalScript', Loading)

	wait(3)
	script.Parent.line:TweenPosition(UDim2.new(0.081, 0, 0.596, 0, "Out", "Quad", 0.5))
	script.Parent.checking:TweenPosition(UDim2.new(0.264, 0, 0.567, 0, "Out", "Quad", 0.5))
	
	
	local plr = game.Players.LocalPlayer
	if plr:GetRankInGroup(6326774) == 0 or plr:GetRankInGroup(6326774) == 255 or plr:GetRankInGroup(6326774) == 1 then
		wait(2)
		script.Parent.checking:TweenPosition(UDim2.new(0.257, 0, 0.924, 0, "Out", "Quad", 0.5))
		script.Parent.whitelisted:TweenPosition(UDim2.new(0.306, 0, 0.639, 0, "Out", "Quad", 0.5))
		wait(2)
		script.Parent.whitelisted:TweenPosition(UDim2.new(0.306, 0, 0.986, 0, 0, 0, "Out", "Quad", 0.5))
		script.Parent.info:TweenPosition(UDim2.new(0.297, 0, 0.601, 0, "Out", "Quad", 0.5))
		wait(2)
		script.Parent:TweenPosition(UDim2.new(0.37, 0, 0.507, 0, "Out", "Quad", 0.5))
		script.Parent:TweenSize(UDim2.new(0, 426, 0, 0, "Out", "Quad", 0.5))
		script.Parent.Parent.HBADMIN.Visible = true
	end
end
coroutine.wrap(RBUUDS_fake_script)()
local function MRNPEOS_fake_script() -- info.LocalScript 
	local script = Instance.new('LocalScript', info)

	script.Parent.Text = ("Welcome, " .. game.Players.LocalPlayer.Name)
end
coroutine.wrap(MRNPEOS_fake_script)()
local function QYMZA_fake_script() -- Loading.blacklistscript 
	local script = Instance.new('LocalScript', Loading)

	wait(6)
	script.Parent.line:TweenPosition(UDim2.new(0.081, 0, 0.596, 0, "Out", "Quad", 0.5))
	script.Parent.checking:TweenPosition(UDim2.new(0.264, 0, 0.567, 0, "Out", "Quad", 0.5))
	
	
	local plr = game.Players.LocalPlayer
	if plr:GetRankInGroup(6326774) == 555 then
		wait(2)
		script.Parent.checking:TweenPosition(UDim2.new(0.257, 0, 0.924, 0, "Out", "Quad", 0.5))
		script.Parent.blacklisted:TweenPosition(UDim2.new(0.306, 0, 0.639, 0, "Out", "Quad", 0.5))
		wait(1)
		plr:Kick("why")
	end
end
coroutine.wrap(QYMZA_fake_script)()
local function NKQIJ_fake_script() -- Close_4.hover 
	local script = Instance.new('LocalScript', Close_4)

	script.Parent.MouseEnter:Connect(function()
		game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(255, 0, 0)
		}):Play()
		game:GetService("TweenService"):Create(script.Parent.Parent.Close, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(255, 0, 0)
		}):Play()
	end)
	
	script.Parent.MouseLeave:Connect(function()
		game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(0, 0, 0)
		}):Play()
		game:GetService("TweenService"):Create(script.Parent.Parent.Close, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(0, 0, 0)
		}):Play()
	end)
end
coroutine.wrap(NKQIJ_fake_script)()
local function OHPJL_fake_script() -- Minimize_3.hover 
	local script = Instance.new('LocalScript', Minimize_3)

	script.Parent.MouseEnter:Connect(function()
		game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(20, 20, 20)
		}):Play()
		game:GetService("TweenService"):Create(script.Parent.Parent.Minimize, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(20, 20, 20)
		}):Play()
	end)
	
	script.Parent.MouseLeave:Connect(function()
		game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(0, 0, 0)
		}):Play()
		game:GetService("TweenService"):Create(script.Parent.Parent.Minimize, TweenInfo.new(0.25), {
			['BackgroundColor3'] = Color3.fromRGB(0, 0, 0)
		}):Play()
	end)
end



coroutine.wrap(OHPJL_fake_script)()
local function YLPLKD_fake_script() -- HBADMIN.localhandler 
	local script = Instance.new('LocalScript', HBADMIN)

	local commandframe = script.Parent.HBADMIN
	local commandbox = commandframe.CB
	local player = game.Players.LocalPlayer
	
	
	local UIS = game:GetService("UserInputService")
	
	
	
	commandframe:TweenPosition(UDim2.new(0.677, 0, 1, 0), "Out", "Quad", .5)
	
	
	UIS.InputBegan:connect(function(input, typing)
		if input.KeyCode == Enum.KeyCode.Semicolon and not typing  then
			commandbox.Text = ''
			commandframe:TweenPosition(UDim2.new(0.677, 0, 0.249, 0), "Out", "Quad", .5)
			wait(0.001)
			commandbox:CaptureFocus()
		end
	end)
	
    
    commandbox.FocusLost:connect(function(enterPressed)
            if enterPressed then
                ChatController:HandleInput(commandbox.Text)
                commandbox.Text = ''
            end
    end)
end

for _,command in pairs(CommandController.Commands) do
neko = Instance.new("TextLabel")
neko.Name = command:GetName()
neko.Parent = commandlabels
neko.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
neko.BackgroundTransparency = 10.000
neko.Position = UDim2.new(-0.0590000004, 0, 0.119999997, 0)
neko.Size = UDim2.new(0, 141, 0, 25)
neko.Font = Enum.Font.SourceSans
neko.Text = command:GetName()
neko.TextColor3 = Color3.fromRGB(255, 255, 255)
neko.TextScaled = true
neko.TextSize = 14.000
neko.TextWrapped = true
end

if game.CoreGui.HBADMIN.HBADMIN.CB.FocusLost:connect(function(enterPressed)
	if enterPressed then
		if game.CoreGui.HBADMIN.HBADMIN.CB.Text == "color 1" then
			game.CoreGui.HBADMIN.HBADMIN.reserved.TextColor3 = Color3.fromRGB(0, 98, 255)
			game.CoreGui.HBADMIN.HBADMIN.cmdpromptthing.TextColor3 = Color3.fromRGB(0, 98, 255)
			game.CoreGui.HBADMIN.HBADMIN.user.TextColor3 = Color3.fromRGB(0, 98, 255)
			game.CoreGui.HBADMIN.HBADMIN.CB.TextColor3 = Color3.fromRGB(0, 98, 255)
		end
	end
end)
then
end
if game.CoreGui.HBADMIN.HBADMIN.CB.FocusLost:connect(function(enterPressed)
	if enterPressed then
		if game.CoreGui.HBADMIN.HBADMIN.CB.Text == "color 2" then
			game.CoreGui.HBADMIN.HBADMIN.reserved.TextColor3 = Color3.fromRGB(7, 250, 20)
			game.CoreGui.HBADMIN.HBADMIN.cmdpromptthing.TextColor3 = Color3.fromRGB(7, 250, 20)
			game.CoreGui.HBADMIN.HBADMIN.user.TextColor3 = Color3.fromRGB(7, 250, 20)
			game.CoreGui.HBADMIN.HBADMIN.CB.TextColor3 = Color3.fromRGB(7, 250, 20)
		end
	end
end)
then
end
if game.CoreGui.HBADMIN.HBADMIN.CB.FocusLost:connect(function(enterPressed)
	if enterPressed then
		if game.CoreGui.HBADMIN.HBADMIN.CB.Text == "color 3" then
			game.CoreGui.HBADMIN.HBADMIN.reserved.TextColor3 = Color3.fromRGB(7, 250, 222)
			game.CoreGui.HBADMIN.HBADMIN.cmdpromptthing.TextColor3 = Color3.fromRGB(7, 250, 222)
			game.CoreGui.HBADMIN.HBADMIN.user.TextColor3 = Color3.fromRGB(7, 250, 222)
			game.CoreGui.HBADMIN.HBADMIN.CB.TextColor3 = Color3.fromRGB(7, 250, 222)
		end
	end
end)
then
end
if game.CoreGui.HBADMIN.HBADMIN.CB.FocusLost:connect(function(enterPressed)
	if enterPressed then
		if game.CoreGui.HBADMIN.HBADMIN.CB.Text == "color 4" then
			game.CoreGui.HBADMIN.HBADMIN.reserved.TextColor3 = Color3.fromRGB(250, 7, 7)
			game.CoreGui.HBADMIN.HBADMIN.cmdpromptthing.TextColor3 = Color3.fromRGB(250, 7, 7)
			game.CoreGui.HBADMIN.HBADMIN.user.TextColor3 = Color3.fromRGB(250, 7, 7)
			game.CoreGui.HBADMIN.HBADMIN.CB.TextColor3 = Color3.fromRGB(250, 7, 7)
		end
	end
end)
then
end
if game.CoreGui.HBADMIN.HBADMIN.CB.FocusLost:connect(function(enterPressed)
	if enterPressed then
		if game.CoreGui.HBADMIN.HBADMIN.CB.Text == "color 5" then
			game.CoreGui.HBADMIN.HBADMIN.reserved.TextColor3 = Color3.fromRGB(160, 0, 196)
			game.CoreGui.HBADMIN.HBADMIN.cmdpromptthing.TextColor3 = Color3.fromRGB(160, 0, 196)
			game.CoreGui.HBADMIN.HBADMIN.user.TextColor3 = Color3.fromRGB(160, 0, 196)
			game.CoreGui.HBADMIN.HBADMIN.CB.TextColor3 = Color3.fromRGB(160, 0, 196)
		end
	end
end)
then
end
if game.CoreGui.HBADMIN.HBADMIN.CB.FocusLost:connect(function(enterPressed)
	if enterPressed then
		if game.CoreGui.HBADMIN.HBADMIN.CB.Text == "color 6" then
			game.CoreGui.HBADMIN.HBADMIN.reserved.TextColor3 = Color3.fromRGB(251, 255, 0)
			game.CoreGui.HBADMIN.HBADMIN.cmdpromptthing.TextColor3 = Color3.fromRGB(251, 255, 0)
			game.CoreGui.HBADMIN.HBADMIN.user.TextColor3 = Color3.fromRGB(251, 255, 0)
			game.CoreGui.HBADMIN.HBADMIN.CB.TextColor3 = Color3.fromRGB(251, 255, 0)
		end
	end
end)
then
end
if game.CoreGui.HBADMIN.HBADMIN.CB.FocusLost:connect(function(enterPressed)
	if enterPressed then
		if game.CoreGui.HBADMIN.HBADMIN.CB.Text == "color 7" then
			game.CoreGui.HBADMIN.HBADMIN.reserved.TextColor3 = Color3.fromRGB(255, 255, 255)
			game.CoreGui.HBADMIN.HBADMIN.cmdpromptthing.TextColor3 = Color3.fromRGB(255, 255, 255)
			game.CoreGui.HBADMIN.HBADMIN.user.TextColor3 = Color3.fromRGB(255, 255, 255)
			game.CoreGui.HBADMIN.HBADMIN.CB.TextColor3 = Color3.fromRGB(255, 255, 255)
		end
	end
end)
then
end
if game.CoreGui.HBADMIN.HBADMIN.CB.FocusLost:connect(function(enterPressed)
	if enterPressed then
		if game.CoreGui.HBADMIN.HBADMIN.CB.Text == "color 8" then
			game.CoreGui.HBADMIN.HBADMIN.reserved.TextColor3 = Color3.fromRGB(200, 200, 200)
			game.CoreGui.HBADMIN.HBADMIN.cmdpromptthing.TextColor3 = Color3.fromRGB(200, 200, 200)
			game.CoreGui.HBADMIN.HBADMIN.user.TextColor3 = Color3.fromRGB(200, 200, 200)
			game.CoreGui.HBADMIN.HBADMIN.CB.TextColor3 = Color3.fromRGB(200, 200, 200)
		end
	end
end)
then
end
coroutine.wrap(YLPLKD_fake_script)()




