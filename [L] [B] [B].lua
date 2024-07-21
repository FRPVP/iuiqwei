 local Sound = Instance.new("Sound",game:GetService("SoundService"))
 Sound.SoundId = "rbxassetid://9120129807"
 Sound:Play()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/FRPVP/iuiqwei/main/library.lua"))()

local gui = Library:create{
    Theme = Library.Themes.Vindicate
}

local tab = gui:tab{
    Icon = "rbxassetid://17771512972",
    Name = "Player"
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local currentWalkSpeed = 16

local slider = tab:slider({
    Name = "Walkspeed",
    Description = "",
    Default = 16,
    Min = 16,
    Max = 300,
    Rounding = 1,
    Callback = function(vv)
        currentWalkSpeed = vv
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = vv
        end
    end
})

-- Function to set the walk speed
local function setWalkSpeed()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = currentWalkSpeed
    end
end

-- Connect CharacterAdded event to reapply walk speed on respawn
LocalPlayer.CharacterAdded:Connect(function()
    -- Wait for the character to be fully loaded
    LocalPlayer.Character:WaitForChild("Humanoid")
    setWalkSpeed()
end)

-- Initial setting of walk speed in case the character is already loaded
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
    setWalkSpeed()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local currentJumpPower = 50

local something = tab:slider({
    Name = "Jump Height",
    Description = "",
    Default = 50,
    Min = 50,
    Max = 300,
    Rounding = 1,
    Callback = function(vv)
        currentJumpPower = vv
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = vv
        end
    end
})

-- Function to set the jump power
local function setJumpPower()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = currentJumpPower
    end
end

-- Connect CharacterAdded event to reapply jump power on respawn
LocalPlayer.CharacterAdded:Connect(function()
    -- Wait for the character to be fully loaded
    LocalPlayer.Character:WaitForChild("Humanoid")
    setJumpPower()
end)

-- Set initial jump power value if the character already exists
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
    setJumpPower()
end

local noclipEnabled = false

-- Function to enable noclip
local function noclip()
    Clip = false
    local function Nocl()
        if Clip == false and game.Players.LocalPlayer.Character then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA('BasePart') and v.CanCollide then
                    v.CanCollide = false
                end
            end
        end
        wait(0.21) -- Basic optimization
    end
    Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

-- Function to disable noclip
local function clip()
    if Noclip then
        Noclip:Disconnect()
    end
    Clip = true
end

tab:toggle({
    Name = "Noclip",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   noclipEnabled = Value
        if noclipEnabled then
            noclip()
        else
            clip()
        end
end,})

local flybutton = "" -- Empty string to remove the key binding
local flyparent = "HumanoidRootPart"
local flyspeed = 40

local invisible_subkey = ""
local invisiblebutton = Enum.KeyCode.R
local invisible_max_distance = 9e10

local controls = {
    front = Enum.KeyCode.W,
    back = Enum.KeyCode.S,
    right = Enum.KeyCode.D,
    left = Enum.KeyCode.A,
    up = Enum.KeyCode.Space,
    down = Enum.KeyCode.LeftControl,
    add_speed = Enum.KeyCode.RightBracket,
    sub_speed = Enum.KeyCode.LeftBracket,
    reset_speed = Enum.KeyCode.Minus
}
local default_flyspeed = flyspeed
-- Configs

local player = game:GetService("Players").LocalPlayer
local mouse = player:GetMouse()
local runservice = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local camera = game:GetService("Workspace").CurrentCamera

local flycontrol = {F = 0, R = 0, B = 0, L = 0, U = 0, D = 0}
local flying = false
local invisible_enabled = false

local function fly()
    local character = player.Character
    if not character then return end
    local hrp = character:FindFirstChild(flyparent)
    if not hrp then return end
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if not humanoid then return end

    flying = true

    humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

    local bv = Instance.new("BodyVelocity")
    local bg = Instance.new("BodyGyro")
    bv.MaxForce = Vector3.new(9e4, 9e4, 9e4)
    bg.CFrame = hrp.CFrame
    bg.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
    bg.P = 9e4
    bv.Parent = hrp
    bg.Parent = hrp

    for i, child in pairs(character:GetDescendants()) do
        if child:IsA("BasePart") then
            coroutine.wrap(function()
                local con = nil
                con = runservice.Stepped:Connect(function()
                    if not flying then
                        con:Disconnect()
                        child.CanCollide = true
                    end
                    child.CanCollide = false
                end)
            end)()
        end
    end

    local con = nil
    con = runservice.Stepped:Connect(function()
        if not flying then
            con:Disconnect()
            bv:Destroy()
            bg:Destroy()
        end

        humanoid.PlatformStand = true
        bv.Velocity = (workspace.Camera.CoordinateFrame.LookVector * ((flycontrol.F - flycontrol.B) * flyspeed)) + (workspace.CurrentCamera.CoordinateFrame.RightVector * ((flycontrol.R - flycontrol.L) * flyspeed)) + (workspace.CurrentCamera.CoordinateFrame.UpVector * ((flycontrol.U - flycontrol.D) * flyspeed))
        bg.CFrame = workspace.Camera.CoordinateFrame
    end)

    repeat wait() until not flying

    while humanoid.PlatformStand == true do
        humanoid.PlatformStand = false
        task.wait()
    end

    humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
end

local function invisible()
    local random = Random.new()

    local character = player.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if not humanoid then return end

    invisible_enabled = true

    humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    humanoid.Sit = false

    local campart = Instance.new("Part")
    campart.CFrame = hrp.CFrame
    campart.Transparency = 0.5
    campart.BrickColor = BrickColor.new("Really red")
    campart.Material = Enum.Material.Neon
    campart.Size = hrp.Size
    campart.CanCollide = false
    campart.Parent = game:GetService("Workspace")
    camera.CameraSubject = campart

    local bv = Instance.new("BodyVelocity")
    local bg = Instance.new("BodyGyro")
    bv.MaxForce = Vector3.new(9e4, 9e4, 9e4)
    bg.CFrame = hrp.CFrame
    bg.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
    bg.P = 9e4
    bv.Parent = campart
    bg.Parent = campart

    local con = nil
    con = runservice.Stepped:Connect(function()
        if not invisible_enabled then
            if campart then
                hrp.CFrame = campart.CFrame
                hrp.Velocity = campart.Velocity
                campart:Destroy()
            end
            if not flying then
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            end
            camera.CameraSubject = player.Character:FindFirstChildWhichIsA("Humanoid")
            con:Disconnect()
            return
        end
        hrp.CFrame = CFrame.new(random:NextNumber(-invisible_max_distance, invisible_max_distance), random:NextNumber(0, invisible_max_distance), random:NextNumber(-invisible_max_distance, invisible_max_distance))
        hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
        bv.Velocity = (workspace.Camera.CoordinateFrame.LookVector * ((flycontrol.F - flycontrol.B) * flyspeed)) + (workspace.CurrentCamera.CoordinateFrame.RightVector * ((flycontrol.R - flycontrol.L) * flyspeed)) + (workspace.CurrentCamera.CoordinateFrame.UpVector * ((flycontrol.U - flycontrol.D) * flyspeed))
        bg.CFrame = workspace.Camera.CoordinateFrame
    end)
end

local function load_textgui()
    local gui = Instance.new("ScreenGui")
    local text = Instance.new("TextLabel")

    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true

    text.Size = UDim2.new(1, 0, 0, 25)
    text.Position = UDim2.fromScale(0, 0.5)
    text.BackgroundTransparency = 1
    text.TextSize = 25
    text.Text = flyspeed
    text.TextColor3 = Color3.new(1, 1, 1)
    text.Font = Enum.Font.SourceSans
    text.TextTransparency = 1

    gui.Parent = game:GetService("Players").LocalPlayer.PlayerGui
    text.Parent = gui

    return text
end

local textgui = load_textgui()

tab:toggle({
    Name = "Fly",
		StartingState = false,
		Description = "R for invisibility",
		Callback = function(Value)
   flying = Value
    if flying then
        fly()
    end
end,})

uis.InputBegan:Connect(function(input, processed)
    if processed then return end

    local key = input.KeyCode

    if key == invisiblebutton then
        if flying then
            if invisible_enabled then
                invisible_enabled = false
            else
                invisible()
            end
        end
    end

    if key == controls.front then
        flycontrol.F = 1
    elseif key == controls.back then
        flycontrol.B = 1
    elseif key == controls.right then
        flycontrol.R = 1
    elseif key == controls.left then
        flycontrol.L = 1
    elseif key == controls.up then
        flycontrol.U = 1
    elseif key == controls.down then
        flycontrol.D = 1
    elseif key == controls.add_speed then
        if flyspeed == 1 then
            flyspeed = 25
        else
            flyspeed = flyspeed + 25
        end
        textgui.TextTransparency = 0
        textgui.Text = flyspeed
        wait(0.1)
        while uis:IsKeyDown(key) do
            flyspeed = flyspeed + 25
            textgui.Text = flyspeed
            wait(0.05)
        end
        textgui.TextTransparency = 1
    elseif key == controls.sub_speed then
        if (flyspeed - 25) < 1 then
            flyspeed = 1
        else
            flyspeed = flyspeed - 25
        end
        textgui.TextTransparency = 0
        textgui.Text = flyspeed
        wait(0.1)
        while uis:IsKeyDown(key) do
            if (flyspeed - 25) < 1 then
                flyspeed = 1
            else
                flyspeed = flyspeed - 25
            end
            textgui.Text = flyspeed
            wait(0.05)
        end
        textgui.TextTransparency = 1
    elseif key == controls.reset_speed then
        textgui.TextTransparency = 0
        flyspeed = default_flyspeed
        textgui.Text = flyspeed
        wait(0.1)
        textgui.TextTransparency = 1
    end
end)

uis.InputEnded:Connect(function(input)
    local key = input.KeyCode

    if key == controls.front then
        flycontrol.F = 0
    elseif key == controls.back then
        flycontrol.B = 0
    elseif key == controls.right then
        flycontrol.R = 0
    elseif key == controls.left then
        flycontrol.L = 0
    elseif key == controls.up then
        flycontrol.U = 0
    elseif key == controls.down then
        flycontrol.D = 0
    end
end)

player.CharacterAdded:Connect(function()
    flying = false
    invisible_enabled = false
end)

local something = tab:slider({
    Name = "Fly Speed",
    Description = "",
    Default = 40,
    Min = 40,
    Max = 300,
    Rounding = 1,
    Callback = function(vv)
        flyspeed = vv
    end
})



-- Repeat until game is loaded
repeat task.wait() until game:IsLoaded()

local words = {
    ['gay'] = 'Bullying',
    ['lesbian'] = 'Bullying',
    ['retard'] = 'Bullying',
    ['noob'] = 'Bullying',
    ['clown'] = 'Bullying',
    ['get a life'] = 'Bullying',
    ['getalife'] = 'Bullying',
    ['no life'] = 'Bullying',
    ['nolife'] = 'Bullying',
    ['wizard'] = 'Bullying',
    ['report'] = 'Bullying',
    ['father'] = 'Bullying',
    ['mother'] = 'Bullying',
    ['dumb'] = 'Bullying',
    ['stupid'] = 'Bullying',
    ['cringe'] = 'Bullying',
    ['skill issue'] = 'Bullying',
    ['parent'] = 'Bullying',
    ['kid'] = 'Bullying',
    ['ugly'] = 'Bullying',
    ['child'] = 'Bullying',
    ['trash'] = 'Bullying',
    ['bozo'] = 'Bullying',
    ['kys'] = 'Bullying',
    ['die'] = 'Bullying',
    ['dying'] = 'Bullying',
    ['killyou'] = 'Bullying',
    ['loser'] = 'Bullying',
    ['black'] = 'Bullying',
    [' white '] = 'Bullying',
    ['ez l'] = 'Bullying',
    ['l ez'] = 'Bullying',
    ['negro'] = 'Bullying',
    ['nivver'] = 'Bullying',
    ['w⚓'] = 'Bullying',
    ['negar'] = 'Bullying',
    ['bad'] = 'Bullying',
    ['worst'] = 'Bullying',
    ['fat'] = 'Bullying',
    ['fatty'] = 'Bullying',
    ['monkey'] = 'Bullying',
    ['report'] = 'Bullying',
    ['banned'] = 'Bullying',
    ['Trisha'] = 'Offsite Links',
    ['hacking'] = 'Scamming',
    ['hack'] = 'Scamming',
    ['exploit'] = 'Scamming',
    ['cheat'] = 'Scamming',
    ['download'] = 'Offsite Links',
    ['youtube'] = 'Offsite Links',
    ['channel'] = 'Offsite Links',
    ['yt'] = 'Offsite Links',
    ['yt channel'] = 'Offsite Links',
    ['youtube channel'] = 'Offsite Links',
    ['tt'] = 'Offsite Links',
    ['tiktok'] = 'Offsite Links',
    ['tick tock'] = 'Offsite Links',
    ['ticktock'] = 'Offsite Links',
    ['yubtub'] = 'Offsite Links',
    ['dizzy'] = 'Offsite Links',
    ['dc'] = 'Offsite Links',
    ['disco'] = 'Offsite Links',
    ['discordant'] = 'Offsite Links',
    ['trans'] = 'Bullying',
    ['hobo'] = 'Bullying',
    ['hobo'] = 'Offsite Links',
    ['lgbt'] = 'Bullying',
    ['ass'] = 'Bullying',
    ['ass'] = 'Swearing',
    ['hell'] = 'Bullying',
    ['hell'] = 'Swearing',
    ['nagger'] = 'Bullying',
    ['tard'] = 'Bullying',
    ['retard'] = 'Bullying',
    ['pp'] = 'Bullying',
    ['pp'] = 'Swearing',
    ['fack'] = 'Bullying',
    ['fack'] = 'Swearing',
    ['wierdo'] = 'Bullying',
    ['beach'] = 'Bullying',
    ['moron'] = 'Bullying',
    ['idc'] = 'Offsite Links',
    ['shart'] = 'Swearing',
    ['ahh'] = 'Swearing',
    ['ahh'] = 'Bullying',
}

-- Check for necessary chat events
if not game:GetService('ReplicatedStorage'):FindFirstChild('DefaultChatSystemChatEvents') or not game:GetService('ReplicatedStorage'):FindFirstChild('DefaultChatSystemChatEvents'):FindFirstChild('OnMessageDoneFiltering') then return end
local DCSCE = game:GetService('ReplicatedStorage'):FindFirstChild('DefaultChatSystemChatEvents')

-- Set up auto-report configuration if not already set
if not autoreportcfg then
    getgenv().autoreportcfg = {
        Webhook = '', 
        autoMessage = {
           enabled = false,
           Message = '',
        },
    }
end

-- Load notification system
local players = game:GetService("Players")
local notifs = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Define notification function
local function notify(title, text)
    notifs:MakeNotification({
        Name = title,
        Content = text,
        Time = 5
    })
end

-- Check if the script is running on Synapse X executor
if syn then
   notify("Autoreport", 'THIS DOESNT WORK ON MOST MOBILE EXECUTORS!')
   notify('Autoreport', '3ds disabled ReportAbuse so yea')
   return
end

-- Define handler function
local function handler(msg, speaker)
    for i, v in pairs(words) do
        if string.match(string.lower(msg), i) then
            local success, err = pcall(function()
                players:ReportAbuse(players[speaker], v, 'He is breaking roblox TOS')
                task.wait(1.5)
                players:ReportAbuse(players[speaker], v, 'He is breaking roblox TOS')
            end)
            if not success then
                warn("Failed to report player: " .. err)
            else
                if autoreportcfg.Webhook ~= nil and autoreportcfg.Webhook ~= '' and autoreportcfg.Webhook ~= ' ' then
                    local data = {
                        ["embeds"] = {{
                            ["title"] = "**" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "**",
                            ["description"] = "Auto-reported a player",
                            ["type"] = "rich",
                            ["color"] = tonumber(0x00aff4),
                            ["url"] = "https://www.roblox.com/games/" .. game.PlaceId,
                            ["fields"] = {
                                {
                                    ["name"] = "Name",
                                    ["value"] = "[" .. players[speaker].Name .. "](https://www.roblox.com/users/" .. players[speaker].UserId .. ")",
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Message",
                                    ["value"] = msg,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Offensive Part",
                                    ["value"] = i,
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Reported For",
                                    ["value"] = v,
                                    ["inline"] = true
                                },
                            },
                            ["footer"] = {
                                ["text"] = "\nIf you think this is a mistake: su"
                            },
                            ["author"] = {
                                ["name"] = "Auto Report"
                            }
                        }}
                    }
                    local newdata = game:GetService("HttpService"):JSONEncode(data)
                    local request = http_request or request or HttpPost or http.request or syn.request
                    local abcdef = {
                        Url = autoreportcfg.Webhook,
                        Body = newdata,
                        Method = "POST",
                        Headers = {
                            ["content-type"] = "application/json"
                        }
                    }
                    request(abcdef)
                else
                    notify('Autoreport', 'Autoreported ' .. speaker .. ' | offensive part: ' .. i)
                end
                if DCSCE:FindFirstChild('SayMessageRequest') and autoreportcfg.autoMessage.enabled == true then
                    DCSCE.SayMessageRequest:FireServer('/w ' .. speaker .. ' ' .. autoreportcfg.autoMessage.Message, 'All')
                end
            end
        end
    end
end

-- Define variable to store the event connection
local chatConnection

-- Toggle function
tab:toggle({
    Name = "AutoReport",
    StartingState = false,
    Description = "",
    Callback = function(state)
        if state then
            -- Enable the auto-reporting script
            chatConnection = DCSCE.OnMessageDoneFiltering.OnClientEvent:Connect(function(msgdata)
                if tostring(msgdata.FromSpeaker) ~= players.LocalPlayer.Name then
                    handler(tostring(msgdata.Message), tostring(msgdata.FromSpeaker))
                end
            end)
            notify("AutoReport", "AutoReport script enabled.")
        else
            -- Disable the auto-reporting script
            if chatConnection then
                chatConnection:Disconnect()
                chatConnection = nil
            end
            notify("AutoReport", "AutoReport script disabled.")
        end
    end
})





local tab = gui:tab{
    Icon = "rbxassetid://17765223017",
    Name = "Fling"
}

tab:textbox({
Name = "Target User",
Description = "Type All to select all players",
    Callback = function(selectedTarget)
        selectedTargetName = selectedTarget
    end
})

local playersService = game:GetService("Players")

local function performFling(playerName)
    local player = game.Players.LocalPlayer
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local Targets = {playerName}

    local AllBool = false

    local GetPlayer = function(Name)
        Name = Name:lower()
        if Name == "all" or Name == "others" then
            AllBool = true
            return
        elseif Name == "random" then
            local GetPlayers = Players:GetPlayers()
            if table.find(GetPlayers, Player) then table.remove(GetPlayers, table.find(GetPlayers, Player)) end
            return GetPlayers[math.random(#GetPlayers)]
        elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
            for _, x in next, Players:GetPlayers() do
                if x ~= Player then
                    if x.Name:lower():match("^" .. Name) then
                        return x;
                    elseif x.DisplayName:lower():match("^" .. Name) then
                        return x;
                    end
                end
            end
        else
            return
        end
    end

    local Message = function(_Title, _Text, Time)
        print(_Title)
        print(_Text)
        print(Time)
    end

    local SkidFling = function(TargetPlayer)
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
        if Accessory and Accessory:FindFirstChild("Handle") then
            Handle = Accessory.Handle
        end

        if Character and Humanoid and RootPart then
            if RootPart.Velocity.Magnitude < 50 then
                getgenv().OldPos = RootPart.CFrame
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

                            FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
                        else
                            FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            
                            FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                            task.wait()

                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                            task.wait()
                        end
                    else
                        break
                    end
                until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
            end

            workspace.FallenPartsDestroyHeight = 0/0

            local BV = Instance.new("BodyVelocity")
            BV.Name = "EpixVel"
            BV.Parent = RootPart
            BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
            BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)

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
                RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
                Humanoid:ChangeState("GettingUp")
                table.foreach(Character:GetChildren(), function(_, x)
                    if x:IsA("BasePart") then
                        x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                    end
                end)
                task.wait()
            until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
            workspace.FallenPartsDestroyHeight = getgenv().FPDH
        else
            return Message("Error Occurred", "Random error", 5)
        end
    end

    -- Main logic
    getgenv().Welcome = true
    if Targets[1] then for _, x in next, Targets do GetPlayer(x) end else return end

    if AllBool then
        for _, x in next, Players:GetPlayers() do
            SkidFling(x)
        end
    end

    for _, x in next, Targets do
        if GetPlayer(x) and GetPlayer(x) ~= Player then
            if GetPlayer(x).UserId ~= 1414978355 then
                local TPlayer = GetPlayer(x)
                if TPlayer then
                    SkidFling(TPlayer)
                end
            else
            end
        elseif not GetPlayer(x) and not AllBool then
        end
    end
end

tab:button({
    Name = "Fling",
    Description = "",
    Callback = function()
        performFling(selectedTargetName)
    end,
})

tab:toggle({
    Name = "Loop Fling",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   if Value then
        while Value do
            performFling(selectedTargetName)
            wait(0) -- Adjust this delay as needed
        end
    end
end,})




local tab = gui:tab{
    Icon = "rbxassetid://18138798743",
    Name = "Lucky Blocks"
}

local isLuckyBlockToggled = false
local isSuperBlockToggled = false
local isDiamondBlockToggled = false
local isRainbowBlockToggled = false
local isGalaxyBlockToggled = false
local spawnLuckyBlockConnection
local spawnSuperBlockConnection
local spawnDiamondBlockConnection
local spawnRainbowBlockConnection
local spawnGalaxyBlockConnection
local numberOfExecutions = 1  -- Default value for the number of executions

local slider = tab:slider({
    Name = "Number of Blocks",
    Description = "",
    Default = 1,
    Min = 1,
    Max = 200,
    Rounding = 1,
    Callback = function(value)
        numberOfExecutions = value
        print("Number of Executions set to:", value)
    end
})

local function executeLuckyBlockScript()
    for i = 1, numberOfExecutions do
        if not isLuckyBlockToggled then break end
        game:GetService("ReplicatedStorage").SpawnLuckyBlock:FireServer()
        wait(0.2)  -- Add a small delay to avoid overwhelming the server
    end
end

local function executeSuperBlockScript()
    for i = 1, numberOfExecutions do
        if not isSuperBlockToggled then break end
        game:GetService("ReplicatedStorage").SpawnSuperBlock:FireServer()
        wait(0.2)  -- Add a small delay to avoid overwhelming the server
    end
end

local function executeDiamondBlockScript()
    for i = 1, numberOfExecutions do
        if not isDiamondBlockToggled then break end
        game:GetService("ReplicatedStorage").SpawnDiamondBlock:FireServer()
        wait(0.2)  -- Add a small delay to avoid overwhelming the server
    end
end

local function executeRainbowBlockScript()
    for i = 1, numberOfExecutions do
        if not isRainbowBlockToggled then break end
        game:GetService("ReplicatedStorage").SpawnRainbowBlock:FireServer()
        wait(0.2)  -- Add a small delay to avoid overwhelming the server
    end
end

local function executeGalaxyBlockScript()
    for i = 1, numberOfExecutions do
        if not isGalaxyBlockToggled then break end
        game:GetService("ReplicatedStorage").SpawnGalaxyBlock:FireServer()
        wait(0.2)  -- Add a small delay to avoid overwhelming the server
    end
end

local function onLuckyBlockCharacterAdded(character)
    if isLuckyBlockToggled then
        executeLuckyBlockScript()
    end
end

local function onSuperBlockCharacterAdded(character)
    if isSuperBlockToggled then
        executeSuperBlockScript()
    end
end

local function onDiamondBlockCharacterAdded(character)
    if isDiamondBlockToggled then
        executeDiamondBlockScript()
    end
end

local function onRainbowBlockCharacterAdded(character)
    if isRainbowBlockToggled then
        executeRainbowBlockScript()
    end
end

local function onGalaxyBlockCharacterAdded(character)
    if isGalaxyBlockToggled then
        executeGalaxyBlockScript()
    end
end

tab:toggle({
    Name = "Auto Load Lucky Block",
    StartingState = false,
    Description = "",
    Callback = function(state)
        isLuckyBlockToggled = state
        if isLuckyBlockToggled then
            -- Start executing the script and connect the character added event
            executeLuckyBlockScript()
            spawnLuckyBlockConnection = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(onLuckyBlockCharacterAdded)
        else
            -- Disconnect the character added event to stop execution
            if spawnLuckyBlockConnection then
                spawnLuckyBlockConnection:Disconnect()
                spawnLuckyBlockConnection = nil
            end
        end
    end,
})

tab:toggle({
    Name = "Auto Load Super Block",
    StartingState = false,
    Description = "",
    Callback = function(state)
        isSuperBlockToggled = state
        if isSuperBlockToggled then
            -- Start executing the script and connect the character added event
            executeSuperBlockScript()
            spawnSuperBlockConnection = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(onSuperBlockCharacterAdded)
        else
            -- Disconnect the character added event to stop execution
            if spawnSuperBlockConnection then
                spawnSuperBlockConnection:Disconnect()
                spawnSuperBlockConnection = nil
            end
        end
    end,
})

tab:toggle({
    Name = "Auto Load Diamond Block",
    StartingState = false,
    Description = "",
    Callback = function(state)
        isDiamondBlockToggled = state
        if isDiamondBlockToggled then
            -- Start executing the script and connect the character added event
            executeDiamondBlockScript()
            spawnDiamondBlockConnection = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(onDiamondBlockCharacterAdded)
        else
            -- Disconnect the character added event to stop execution
            if spawnDiamondBlockConnection then
                spawnDiamondBlockConnection:Disconnect()
                spawnDiamondBlockConnection = nil
            end
        end
    end,
})

tab:toggle({
    Name = "Auto Load Rainbow Block",
    StartingState = false,
    Description = "Recommended 50-60",
    Callback = function(state)
        isRainbowBlockToggled = state
        if isRainbowBlockToggled then
            -- Start executing the script and connect the character added event
            executeRainbowBlockScript()
            spawnRainbowBlockConnection = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(onRainbowBlockCharacterAdded)
        else
            -- Disconnect the character added event to stop execution
            if spawnRainbowBlockConnection then
                spawnRainbowBlockConnection:Disconnect()
                spawnRainbowBlockConnection = nil
            end
        end
    end,
})

tab:toggle({
    Name = "Auto Load Galaxy Block",
    StartingState = false,
    Description = "Recommended 50-60",
    Callback = function(state)
        isGalaxyBlockToggled = state
        if isGalaxyBlockToggled then
            -- Start executing the script and connect the character added event
            executeGalaxyBlockScript()
            spawnGalaxyBlockConnection = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(onGalaxyBlockCharacterAdded)
        else
            -- Disconnect the character added event to stop execution
            if spawnGalaxyBlockConnection then
                spawnGalaxyBlockConnection:Disconnect()
                spawnGalaxyBlockConnection = nil
            end
        end
    end,
})



local tab = gui:tab{
    Icon = "rbxassetid://17771719508",
    Name = "Misc"
}

tab:toggle({
    Name = "Toggle UI Button",
    StartingState = false,
    Description = "A button to hopefully help you better toggle the UI",
    Callback = function(Value)
        local gui = game.CoreGui:FindFirstChild("VindicateToggleUIButton")
        if not gui then
            gui = Instance.new("ScreenGui")
            gui.Name = "VindicateToggleUIButton"
            gui.Parent = game.CoreGui

            local toggleui = Instance.new("TextButton")
            toggleui.Size = UDim2.new(0, 50, 0, 50) -- Adjusted size to make it smaller
            toggleui.Position = UDim2.new(0.01, 0, 0.34, 0)
            toggleui.BackgroundTransparency = 1 -- Make the TextButton transparent
            toggleui.Active = true
            toggleui.Draggable = true
            toggleui.Parent = gui
            toggleui.Text = "" -- Removed the text
            toggleui.ZIndex = 1

            local imageLabel = Instance.new("ImageLabel")
            imageLabel.Size = UDim2.new(1, 0, 1, 0) -- Match the size of the TextButton
            imageLabel.Position = UDim2.new(0, 0, 0, 0)
            imageLabel.Image = "https://www.roblox.com/asset-thumbnail/image?assetId=17684864798&width=420&height=420&format=png" -- Set the image URL using rbxthumb
            imageLabel.BackgroundTransparency = 1
            imageLabel.Parent = toggleui
            imageLabel.ZIndex = 0

            -- Adding UI cornering
            local uicorner = Instance.new("UICorner")
            uicorner.CornerRadius = UDim.new(0, 8) -- Adjust the radius as needed
            uicorner.Parent = imageLabel

            toggleui.MouseButton1Click:Connect(function()
                if Library and Library.show then
                    Library:show(not Library.Toggled)
                else
                    warn("Library or its show method not found.")
                end
            end)
        else
            gui:Destroy() -- If the GUI already exists, destroy it
        end
    end
})

tab:button({
    Name = "Rejoin",
    Description = "",
    Callback = function()
        local function RejoinServer()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end

-- Call the function to rejoin the server
RejoinServer()
    end,
})

tab:button({
    Name = "Emergency Leave",
    Description = "Kicks you from the game incase you can't properly leave.",
    Callback = function()
        local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function KickPlayer()
    LocalPlayer:Kick("You have been kicked from the server as of an emergency.")
end

KickPlayer()
    end,
})

tab:toggle({
    Name = "Night",
    StartingState = false,
    Description = "",
    Callback = function(state)
        if state then
            -- Toggle on: Set the sky to night
            game.Lighting.TimeOfDay = "00:00:00" -- Midnight
            print("The sky is now set to night.")
        else
            -- Toggle off: Set the sky to day
            game.Lighting.TimeOfDay = "12:00:00" -- Noon
            print("The sky is now set to day.")
        end
    end,
})

tab:toggle({
    Name = "Sunset",
    StartingState = false,
    Description = "",
    Callback = function(state)
        if state then
            -- Toggle on: Set the sky to night
            game.Lighting.TimeOfDay = "18:00:00" -- Midnight
            print("The sky is now set to night.")
        else
            -- Toggle off: Set the sky to day
            game.Lighting.TimeOfDay = "12:00:00" -- Noon
            print("The sky is now set to day.")
        end
    end,
})

local originalSettings = {
    ExposureCompensation = game.Lighting.ExposureCompensation,
    ShadowSoftness = game.Lighting.ShadowSoftness,
    EnvironmentDiffuseScale = game.Lighting.EnvironmentDiffuseScale,
    EnvironmentSpecularScale = game.Lighting.EnvironmentSpecularScale,
    Brightness = game.Lighting.Brightness,
    ColorShift_Top = game.Lighting.ColorShift_Top,
    OutdoorAmbient = game.Lighting.OutdoorAmbient,
    GeographicLatitude = game.Lighting.GeographicLatitude,
    Ambient = game.Lighting.Ambient
}

-- Function to apply the custom lighting effects
local function applyLightingEffects()
    local find1 = game.Lighting:FindFirstChildWhichIsA("BloomEffect")
    if find1 then
        find1:Destroy()
    end
    local find2 = game.Lighting:FindFirstChildWhichIsA("SunRaysEffect")
    if find2 then
        find2:Destroy()
    end
    local find3 = game.Lighting:FindFirstChildWhichIsA("ColorCorrectionEffect")
    if find3 then
        find3:Destroy()
    end
    local find4 = game.Lighting:FindFirstChildWhichIsA("BlurEffect")
    if find4 then
        find4:Destroy()
    end
    local find5 = game.Lighting:FindFirstChildWhichIsA("Sky")
    if find5 then
        find5:Destroy()
    end
    local blem = Instance.new("BloomEffect", game.Lighting)
    local sanrey = Instance.new("SunRaysEffect", game.Lighting)
    local color = Instance.new("ColorCorrectionEffect", game.Lighting)
    local blor = Instance.new("BlurEffect", game.Lighting)
    Instance.new("Sky", game.Lighting)
    game.Lighting.ExposureCompensation = 0.34
    game.Lighting.ShadowSoftness = 1
    game.Lighting.EnvironmentDiffuseScale = 0.343
    game.Lighting.EnvironmentSpecularScale = 1
    game.Lighting.Brightness = 2
    game.Lighting.ColorShift_Top = Color3.fromRGB(118, 117, 108)
    game.Lighting.OutdoorAmbient = Color3.fromRGB(141, 141, 141)
    game.Lighting.GeographicLatitude = 100
    game.Lighting.Ambient = Color3.fromRGB(112, 112, 112)
    blem.Intensity = 0.5
    blem.Size = 22
    blem.Threshold = 1.5
    sanrey.Intensity = 0.117
    sanrey.Spread = 1
    blor.Size = 2
    color.Contrast = 0.3
    color.Saturation = 0.2
    color.TintColor = Color3.fromRGB(255, 252, 224)
end

-- Function to clear all custom lighting effects and restore original settings
local function clearLightingEffects()
    local effects = {"BloomEffect", "SunRaysEffect", "ColorCorrectionEffect", "BlurEffect", "Sky"}
    for _, effect in ipairs(effects) do
        local found = game.Lighting:FindFirstChildWhichIsA(effect)
        while found do
            found:Destroy()
            found = game.Lighting:FindFirstChildWhichIsA(effect)
        end
    end
    -- Restore original lighting settings
    game.Lighting.ExposureCompensation = originalSettings.ExposureCompensation
    game.Lighting.ShadowSoftness = originalSettings.ShadowSoftness
    game.Lighting.EnvironmentDiffuseScale = originalSettings.EnvironmentDiffuseScale
    game.Lighting.EnvironmentSpecularScale = originalSettings.EnvironmentSpecularScale
    game.Lighting.Brightness = originalSettings.Brightness
    game.Lighting.ColorShift_Top = originalSettings.ColorShift_Top
    game.Lighting.OutdoorAmbient = originalSettings.OutdoorAmbient
    game.Lighting.GeographicLatitude = originalSettings.GeographicLatitude
    game.Lighting.Ambient = originalSettings.Ambient
end

-- Define the toggle for the script
tab:toggle({
    Name = "RTX",
    StartingState = false,
    Description = "",
    Callback = function(state)
        if state then
            applyLightingEffects()
            print("Lighting effects have been applied.")
        else
            clearLightingEffects()
            print("Lighting effects have been removed.")
        end
    end,
})

local Players = game:GetService("Players")

-- Local Player
local player = Players.LocalPlayer

-- Notification Toggles
local notifyLeaveEnabled = false
local notifyJoinEnabled = false

-- Function to handle player removal
local function onPlayerRemoving(removedPlayer)
    if notifyLeaveEnabled and removedPlayer ~= player then
        local message = removedPlayer.Name .. " has left the game."
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = message;
            Color = Color3.fromRGB(240, 7, 7);
            Font = Enum.Font.SourceSansBold;
            FontSize = Enum.FontSize.Size24;
        })
    end
end

-- Function to handle player addition
local function onPlayerAdded(addedPlayer)
    if notifyJoinEnabled and addedPlayer ~= player then
        local message = addedPlayer.Name .. " has joined the game."
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = message;
            Color = Color3.fromRGB(0, 200, 0);
            Font = Enum.Font.SourceSansBold;
            FontSize = Enum.FontSize.Size24;
        })
    end
end

-- Toggle button for leaving notification setup
tab:toggle({
    Name = "Player Leave Notify",
    StartingState = false,
    Description = "",
    Callback = function(state)
        notifyLeaveEnabled = state
    end,
})

-- Toggle button for joining notification setup
tab:toggle({
    Name = "Player Join Notify",
    StartingState = false,
    Description = "",
    Callback = function(state)
        notifyJoinEnabled = state
    end,
})

-- Connect the functions to the respective events
Players.PlayerRemoving:Connect(onPlayerRemoving)
Players.PlayerAdded:Connect(onPlayerAdded)
