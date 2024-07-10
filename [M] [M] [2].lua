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

tab:toggle({
    Name = "Noclip",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local Plr = Players.LocalPlayer
        local Clipon = Value

        local function toggleNoclip()
            if Clipon then
                print("Noclip turned on")
                RunService:BindToRenderStep("Noclip", Enum.RenderPriority.First.Value, function()
                    -- Disable collision for player's parts
                    for _, part in ipairs(Plr.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end)
            else
                print("Noclip turned off")
                RunService:UnbindFromRenderStep("Noclip")
                -- Restore collision for player's parts
                for _, part in ipairs(Plr.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end

        toggleNoclip()
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

tab:toggle({
    Name = "Remove Kill Barriers",
		StartingState = false,
		Description = "",
		Callback = function(val)
   if val then
while val do task.wait(0.7)
pcall(function()
if game.Workspace.Mansion2.GlitchProof.KillBrick then
game.Workspace.Mansion2.GlitchProof.KillBrick:Destroy()
end
end)
if not val then
break
end
end
end
end,})





local tab = gui:tab{
    Icon = "rbxassetid://17771505635",
    Name = "Visual"
}

getgenv().BetterESP = false
tab:toggle({
    Name = "Player ESP",
    StartingState = false,
    Description = "By Role",
    Callback = function(val)
        getgenv().BetterESP = val
    end,
})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local roles

-- > Functions <--

function CreateBillboard(player)
    if player ~= LP and player.Character and not player.Character:FindFirstChild("Billboard") then
        local role = GetPlayerRole(player.Name)
        
        if role and (role == "Innocent" or role == "Murderer" or role == "Sheriff" or role == "Hero") then
            local billboard = Instance.new("BillboardGui", player.Character)
            billboard.Name = "Billboard"
            billboard.AlwaysOnTop = true
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.Adornee = player.Character:FindFirstChild("Head")
            
            local nameLabel = Instance.new("TextLabel", billboard)
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.Text = player.Name
            nameLabel.TextColor3 = Color3.new(1, 1, 1)
            nameLabel.TextStrokeTransparency = 0.5
            nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
            nameLabel.BackgroundTransparency = 1
        end
    end
end

function UpdateBillboards()
    for _, player in pairs(Players:GetChildren()) do
        if player ~= LP and player.Character then
            local billboard = player.Character:FindFirstChild("Billboard")
            if billboard then
                local nameLabel = billboard:FindFirstChild("TextLabel")
                local role = GetPlayerRole(player.Name)
                
                if IsAlive(player) then
                    if role == "Sheriff" then
                        nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 225)
                    elseif role == "Murderer" then
                        nameLabel.TextStrokeColor3 = Color3.fromRGB(225, 0, 0)
                    elseif role == "Hero" then
                        nameLabel.TextStrokeColor3 = Color3.fromRGB(255, 250, 0)
                    else
                        nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 225, 0)
                    end
                else
                    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
                end
            end
        end
    end
end

function IsAlive(player)
    local playerData = roles[player.Name]
    return playerData and not playerData.Killed and not playerData.Dead
end

function GetPlayerRole(playerName)
    local playerData = roles[playerName]
    return playerData and playerData.Role or nil
end

-- Loops --

RunService.RenderStepped:Connect(function()
    roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    
    if getgenv().BetterESP then
        for _, player in pairs(Players:GetChildren()) do
            CreateBillboard(player)
        end
        UpdateBillboards()
    else
        for _, player in pairs(Players:GetChildren()) do
            if player ~= LP and player.Character and player.Character:FindFirstChild("Billboard") then
                player.Character.Billboard:Destroy()
            end
        end
    end
end)

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local folder = Instance.new("Folder", CoreGui)
folder.Name = "ESP Holder"

local function AddBillboard(player)
    local billboard = Instance.new("BillboardGui", folder)
    billboard.Name = player.Name
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.fromOffset(200, 50)
    billboard.ExtentsOffset = Vector3.new(0, 3, 0)
    billboard.Enabled = false

    local textLabel = Instance.new("TextLabel", billboard)
    textLabel.TextSize = 15
    textLabel.Text = player.Name
    textLabel.Font = Enum.Font.SourceSans
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.fromScale(1, 1)
    textLabel.TextStrokeTransparency = 0
    textLabel.TextYAlignment = Enum.TextYAlignment.Bottom
    textLabel.ZIndex = 0

    local function updateBillboard()
        pcall(function()
            billboard.Adornee = player.Character:FindFirstChild("Head")
            if player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife") then
                textLabel.TextColor3 = Color3.fromRGB(225, 0, 0)
                if not billboard.Enabled and getgenv().MurderEsp then
                    billboard.Enabled = true
                end
            elseif player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun") then
                textLabel.TextColor3 = Color3.fromRGB(0, 0, 225)
                if not billboard.Enabled and getgenv().SheriffEsp then
                    billboard.Enabled = true
                end
            else
                textLabel.TextColor3 = Color3.fromRGB(0, 225, 0)
            end
        end)
    end

    if getgenv().AllEsp then
        billboard.Enabled = true
    end

    repeat
        wait()
        updateBillboard()
    until not player.Parent
end

for _, player in pairs(Players:GetPlayers()) do
    if player ~= Players.LocalPlayer then
        coroutine.wrap(AddBillboard)(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= Players.LocalPlayer then
        coroutine.wrap(AddBillboard)(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    local billboard = folder:FindFirstChild(player.Name)
    if billboard then
        billboard:Destroy()
    end
end)

tab:toggle({
    Name = "Player ESP",
    StartingState = false,
    Description = "By Item",
    Callback = function(val)
        getgenv().AllEsp = val
        for _, v in pairs(folder:GetChildren()) do
            if v:IsA("BillboardGui") and Players:FindFirstChild(v.Name) then
                v.Enabled = getgenv().AllEsp
            end
        end
    end,
})

local ESPBillboardGui = nil
local ESPToggleValue = false
local Workspace = game:GetService("Workspace")

local function findGunDrop()
    for _, child in pairs(Workspace:GetDescendants()) do
        if child:IsA("BasePart") and child.Name == "GunDrop" then
            return child
        end
    end
    return nil
end

local function CreateGunESP(gun)
    ESPBillboardGui = Instance.new("BillboardGui")
    ESPBillboardGui.Adornee = gun
    ESPBillboardGui.Size = UDim2.new(0, 80, 0, 50)
    ESPBillboardGui.StudsOffset = Vector3.new(0, 3, 0)
    ESPBillboardGui.AlwaysOnTop = true

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Text = "GunDrop"
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.TextColor3 = Color3.fromRGB(0, 214, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextScaled = true
    TextLabel.Parent = ESPBillboardGui

    ESPBillboardGui.Parent = gun
end

local function DestroyGunESP()
    if ESPBillboardGui then
        ESPBillboardGui:Destroy()
        ESPBillboardGui = nil
    end
end

local function ESPToggleChanged(newValue)
    ESPToggleValue = newValue
    if newValue then
        local gun = findGunDrop()
        if gun then
            CreateGunESP(gun)
        end
    else
        DestroyGunESP()
    end
    print("ESP toggle value changed to:", newValue)
end

local function onChildAdded(child)
    if child:IsA("BasePart") and child.Name == "GunDrop" then
        if ESPToggleValue then
            CreateGunESP(child)
        end
    end
end

local function onChildRemoved(child)
    if ESPBillboardGui and child == ESPBillboardGui.Adornee then
        DestroyGunESP()
    end
end

Workspace.DescendantAdded:Connect(onChildAdded)
Workspace.DescendantRemoving:Connect(onChildRemoved)

tab:toggle({
    Name = "Gun ESP",
    StartingState = false,
    Description = "",
    Callback = ESPToggleChanged
})

tab:toggle({
    Name = "Player Highlights",
		StartingState = false,
		Description = "",
		Callback = function(val)
   getgenv().he = val

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local roles

-- > Functions <--

function CreateHighlight() -- make any new highlights for new players
    for i, v in pairs(Players:GetChildren()) do
        if v ~= LP and v.Character and not v.Character:FindFirstChild("Highlight") then
            Instance.new("Highlight", v.Character)           
        end
    end
end

function UpdateHighlights() -- Get Current Role Colors (messy)
    for _, v in pairs(Players:GetChildren()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("Highlight") then
            local Highlight = v.Character:FindFirstChild("Highlight")
            local role = GetPlayerRole(v.Name)
            if role then
                if role == "Sheriff" and IsAlive(v) then
                    Highlight.FillColor = Color3.fromRGB(0, 0, 225)
                elseif role == "Murderer" and IsAlive(v) then
                    Highlight.FillColor = Color3.fromRGB(225, 0, 0)
                elseif role == "Hero" and IsAlive(v) and not IsAlive(game.Players[Sheriff]) then
                    Highlight.FillColor = Color3.fromRGB(255, 250, 0)
                else
                    Highlight.FillColor = Color3.fromRGB(0, 225, 0)
                end
            end
        end
    end
end    

-- > Loops < --

RunService.RenderStepped:Connect(function()
    roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    for i, v in pairs(roles) do
        if v.Role == "Murderer" then
            Murder = i
        elseif v.Role == 'Sheriff' then
            Sheriff = i
        elseif v.Role == 'Hero' then
            Hero = i
        end
    end
    
    if getgenv().he then
        CreateHighlight()
        UpdateHighlights()
    else
        for _, v in pairs(Players:GetChildren()) do
            if v ~= LP and v.Character and v.Character:FindFirstChild("Highlight") then
                v.Character:FindFirstChild("Highlight"):Destroy()
            end
        end
    end
end)
end,})

local GunHighlight = nil
local GunHandleAdornment = nil
local HighlightToggleValue = false
local Workspace = game:GetService("Workspace")

local function findGunDrop()
    for _, child in pairs(Workspace:GetDescendants()) do
        if child:IsA("BasePart") and child.Name == "GunDrop" then
            return child
        end
    end
    return nil
end

local function CreateGunHighlightAdornment(gun)
    GunHighlight = Instance.new("Highlight")
    GunHandleAdornment = Instance.new("SphereHandleAdornment")

    GunHandleAdornment.Radius = (gun.Size.X + gun.Size.Y + gun.Size.Z) / 3
    GunHandleAdornment.Adornee = gun
    GunHandleAdornment.Color3 = Color3.fromRGB(0, 214, 0)
    GunHandleAdornment.Transparency = 0.2
    GunHandleAdornment.AlwaysOnTop = true
    GunHandleAdornment.ZIndex = 10
    GunHandleAdornment.Parent = gun

    GunHighlight.Adornee = gun
    GunHandleAdornment.Adornee = gun
    GunHandleAdornment.Size = gun.Size + Vector3.new(0.05, 0.05, 0.05)
    GunHighlight.Enabled = true
    GunHandleAdornment.Visible = true
end

local function DestroyGunHighlightAdornment()
    if GunHighlight then
        GunHighlight:Destroy()
        GunHighlight = nil
    end
    if GunHandleAdornment then
        GunHandleAdornment:Destroy()
        GunHandleAdornment = nil
    end
end

local function HighlightToggleChanged(newValue)
    HighlightToggleValue = newValue
    if newValue then
        local gun = findGunDrop()
        if gun then
            CreateGunHighlightAdornment(gun)
        end
    else
        DestroyGunHighlightAdornment()
    end
    print("Highlight toggle value changed to:", newValue)
end

local function onChildAdded(child)
    if child:IsA("BasePart") and child.Name == "GunDrop" then
        if HighlightToggleValue then
            CreateGunHighlightAdornment(child)
        end
    end
end

local function onChildRemoved(child)
    if GunHandleAdornment and child == GunHandleAdornment.Adornee then
        DestroyGunHighlightAdornment()
    end
end

Workspace.DescendantAdded:Connect(onChildAdded)
Workspace.DescendantRemoving:Connect(onChildRemoved)

tab:toggle({
    Name = "Gun Highlight",
    StartingState = false,
    Description = "",
    Callback = HighlightToggleChanged
})

tab:textbox({
    Name = "Spectate Player",
    Callback = function(vv)
        local User = nil
        for _, player in ipairs(game.Players:GetPlayers()) do
            if string.sub(player.Name:lower(), 1, #vv):lower() == vv:lower() then
                User = player
                break
            end
        end

        if User then
            if User.Character and User.Character:FindFirstChildOfClass("Humanoid") then
                game.Workspace.CurrentCamera.CameraSubject = User.Character.Humanoid
            else
                warn("Player's character or humanoid not found!")
            end
        else
            warn("Player not found!")
        end
    end
})

tab:button({
    Name = "Stop Spectating",
    Description = "",
    Callback = function()
        game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid')
    end,
})

local function toggleCameraFocus()
    local character = game.Players.LocalPlayer.Character
    local camera = game.Workspace.CurrentCamera
    local originalPosition = camera.CFrame

    local gunDrop = game.Workspace:FindFirstChild("GunDrop")

    if gunDrop then
        if camera.CameraSubject == gunDrop then
            camera.CameraSubject = character:FindFirstChildOfClass("Humanoid") or character.PrimaryPart
        else
            camera.CameraSubject = gunDrop
        end
    end
end

tab:toggle({
    Name = "Spectate Gun",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   if Value then
        toggleCameraFocus()
    else
        -- Restore original camera focus (assuming it was on the player)
        local character = game.Players.LocalPlayer.Character
        local camera = game.Workspace.CurrentCamera
        camera.CameraSubject = character:FindFirstChildOfClass("Humanoid") or character.PrimaryPart
    end
end,})

local function toggleSpectateMurderer(isSpectating)
    if isSpectating then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and (player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife")) then
                game.Workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
                break
            end
        end
    else
        -- Restore original camera focus (assuming it was on the player)
        local localPlayer = game.Players.LocalPlayer
        if localPlayer and localPlayer.Character then
            local character = localPlayer.Character
            local camera = game.Workspace.CurrentCamera
            camera.CameraSubject = character:FindFirstChildOfClass("Humanoid") or character.PrimaryPart
        end
    end
end

tab:toggle({
    Name = "Spectate Murderer",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   toggleSpectateMurderer(Value)
end,})

local function toggleSpectateSheriff(spectatingEnabled)
    if spectatingEnabled then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and (player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun")) then
                game.Workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
                break
            end
        end
    else
        -- Restore original camera focus (assuming it was on the player)
        local localPlayer = game.Players.LocalPlayer
        if localPlayer and localPlayer.Character then
            local character = localPlayer.Character
            local camera = game.Workspace.CurrentCamera
            camera.CameraSubject = character:FindFirstChildOfClass("Humanoid") or character.PrimaryPart
        end
    end
end

tab:toggle({
    Name = "Spectate Sheriff",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   toggleSpectateSheriff(Value)
end,})








local tab = gui:tab{
    Icon = "rbxassetid://17765194180",
    Name = "Combat"
}



tab:button({
    Name = "Extra Life",
    Description = "",
    Callback = function()
        local accessories = {}

        if game.Players.LocalPlayer.Character then
            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                for _, accessory in pairs(game.Players.LocalPlayer.Character.Humanoid:GetAccessories()) do
                    table.insert(accessories, accessory:Clone())
                end
                game.Players.LocalPlayer.Character.Humanoid.Name = "boop"
            end
            local v = game.Players.LocalPlayer.Character["boop"]:Clone()
            v.Parent = game.Players.LocalPlayer.Character
            v.Name = "Humanoid"
            wait(0.1)
            game.Players.LocalPlayer.Character["boop"]:Destroy()
            workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
            for _, accessory in pairs(accessories) do
                game.Players.LocalPlayer.Character.Humanoid:AddAccessory(accessory)
            end
            game.Players.LocalPlayer.Character.Animate.Disabled = true
            wait(0.1)
            game.Players.LocalPlayer.Character.Animate.Disabled = false

            -- Jump Functionality
            local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                local user_input = game:GetService("UserInputService")
                local is_jumping = false
                local jump_height = 7 -- Adjust this value to set the jump height

                user_input.InputBegan:Connect(function(input, isProcessed)
                    if not isProcessed and input.KeyCode == Enum.KeyCode.Space and not is_jumping then
                        is_jumping = true
                        while user_input:IsKeyDown(Enum.KeyCode.Space) do
                            humanoid.Jump = true
                            wait()
                        end
                        is_jumping = false
                    end
                end)
            end
        end
    end,
})





tab:keybind({
Name = "Shoot Murderer",
    Callback = function()
        local function findMurderer()
    for _, i in ipairs(game.Players:GetPlayers()) do
        if i.Backpack:FindFirstChild("Knife") then
            return i
        end
    end

    for _, i in ipairs(game.Players:GetPlayers()) do
        if i.Character:FindFirstChild("Knife") then
            return i
        end
    end

    return nil
end

local function findSheriff()
    for _, i in ipairs(game.Players:GetPlayers()) do
        if i.Backpack:FindFirstChild("Gun") then
            return i
        end
    end

    for _, i in ipairs(game.Players:GetPlayers()) do
        if i.Character:FindFirstChild("Gun") then
            return i
        end
    end

    return nil
end

local function shootMurderer()
    local localPlayer = game.Players.LocalPlayer
    local murderer = findMurderer()
    local sheriff = findSheriff()

    if sheriff ~= localPlayer then
        return
    end

    if not murderer then
        return
    end

    if not localPlayer.Character:FindFirstChild("Gun") then
        local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
        if localPlayer.Backpack:FindFirstChild("Gun") then
            humanoid:EquipTool(localPlayer.Backpack:FindFirstChild("Gun"))
        else
            return
        end
    end

    local shootOffset = 1  -- Define shootOffset as per your requirements
    local args = {
        [1] = 1,
        [2] = murderer.Character:FindFirstChild("HumanoidRootPart").Position + murderer.Character:FindFirstChild("Humanoid").MoveDirection * shootOffset,
        [3] = "AH2"
    }

    LocalPlayer.Character.Gun.KnifeLocal.CreateBeam.RemoteFunction:InvokeServer(unpack(args))
end

shootMurderer()
    end,
})

tab:button({
    Name = "Break Gun",
    Description = "",
    Callback = function()
            local Players = game:GetService("Players")
local LP = Players.LocalPlayer

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LP then
        local backpackGun = player.Backpack:FindFirstChild("Gun")
        local characterGun = player.Character and player.Character:FindFirstChild("Gun")

        if backpackGun then
            local knifeServer = backpackGun:FindFirstChild("KnifeServer")
            if knifeServer then
                pcall(function()
                    knifeServer.ShootGun:InvokeServer(1, 0, "AH2")
                end)
            end
        elseif characterGun then
            local knifeServer = characterGun:FindFirstChild("KnifeServer")
            if knifeServer then
                pcall(function()
                    knifeServer.ShootGun:InvokeServer(1, 0, "AH2")
                end)
            end
        end
    end
    end
    end,
})

local loopBreakG = nil
local RS = game:GetService("RunService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

tab:toggle({
    Name = "Loop Break Gun",
		StartingState = false,
		Description = "",
		Callback = function(val)
   if val then
        loopBreakG = RS.RenderStepped:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LP then
                    local backpackGun = player.Backpack:FindFirstChild("Gun")
                    local characterGun = player.Character and player.Character:FindFirstChild("Gun")
                    
                    if backpackGun then
                        local knifeServer = backpackGun:FindFirstChild("KnifeServer")
                        if knifeServer then
                            pcall(function()
                                knifeServer.ShootGun:InvokeServer(1, 0, "AH2")
                            end)
                        end
                    elseif characterGun then
                        local knifeServer = characterGun:FindFirstChild("KnifeServer")
                        if knifeServer then
                            pcall(function()
                                knifeServer.ShootGun:InvokeServer(1, 0, "AH2")
                            end)
                        end
                    end
                end
            end
        end)
    else
        if loopBreakG then
            loopBreakG:Disconnect()
            loopBreakG = nil
        end
    end
end,})






tab:button({
    Name = "Grab Gun",
    Description = "",
    Callback = function()
            local player = game.Players.LocalPlayer
local workspace = game:GetService("Workspace")

-- Variable to store the original position
local originalPosition = player.Character.HumanoidRootPart.CFrame

-- Function to find and teleport to the GunDrop part
local function teleportToGunDrop()
    local normal = workspace:WaitForChild("Normal") -- Wait for Normal to exist in Workspace
    local gunDrop = normal:WaitForChild("GunDrop") -- Wait for GunDrop to exist in Normal

    -- Check if GunDrop exists
    if gunDrop then
        -- Teleport the player to the GunDrop's position
        player.Character:SetPrimaryPartCFrame(gunDrop.CFrame)
        
        -- Wait for a moment (adjust the time as needed)
        wait(0.2)
        
        -- Teleport the player back to the original position
        player.Character:SetPrimaryPartCFrame(originalPosition)
    else
        warn("GunDrop not found in Normal")
    end
end

-- Call the function directly without a key press
teleportToGunDrop()
    end,
})






local tab = gui:tab{
    Icon = "rbxassetid://17771714371",
    Name = "Teleport"
}

tab:toggle({
    Name = "Click TP",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   Toggle = Value

      local player = game.Players.LocalPlayer
      local mouse = player:GetMouse()

      local function Teleport()
         if Toggle and mouse.Target then
            player.Character.HumanoidRootPart.CFrame = mouse.Hit
         end
      end

      mouse.Button1Down:Connect(Teleport)
end,})

tab:button({
    Name = "Lobby",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108, 138, 37)
    end,
})

tab:button({
    Name = "Map",
    Description = "",
    Callback = function()
        local function teleportPlayerToPosition(position)
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

-- Function to find a BasePart with the name "Coin_Server" and teleport the player to it
local function teleportToCoinServer()
    for _, part in ipairs(game.Workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Name == "Coin_Server" then
            teleportPlayerToPosition(part.Position)
            break
        end
    end
end

-- Teleport to the first Coin_Server when the script is executed
teleportToCoinServer()
    end,
})

tab:button({
    Name = "Voting Room",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108, 141, 86)
    end,
})

tab:button({
    Name = "Murderer",
    Description = "",
    Callback = function()
        for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
end
end
    end,
})

tab:button({
    Name = "Sheriff",
    Description = "",
    Callback = function()
        for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
end
end
    end,
})

tab:button({
    Name = "Void",
    Description = "",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-74, -6, 693)
if not game.Workspace:FindFirstChild("TpVoid") then
local TpVoid = Instance.new("Part", game.Workspace)
TpVoid.Anchored = true
TpVoid.Name = "TpVoid"
TpVoid.Transparency = 0.8
TpVoid.Position = Vector3.new(-74, -9, 694)
TpVoid.Size = Vector3.new(20,0,20)
        end
    end,
})







local tab = gui:tab{
    Icon = "rbxassetid://17765231984",
    Name = "Emotes"
}

tab:button({
    Name = "Zen",
    Description = "",
    Callback = function()
        ReplicatedStorage.Remotes.Misc.PlayEmote:Fire("zen")
    end,
})

tab:button({
    Name = "Headless",
    Description = "",
    Callback = function()
        ReplicatedStorage.Remotes.Misc.PlayEmote:Fire("headless")
    end,
})

tab:button({
    Name = "Zombie",
    Description = "",
    Callback = function()
        ReplicatedStorage.Remotes.Misc.PlayEmote:Fire("zombie")
    end,
})

tab:button({
    Name = "Ninja",
    Description = "",
    Callback = function()
        ReplicatedStorage.Remotes.Misc.PlayEmote:Fire("ninja")
    end,
})

tab:button({
    Name = "Floss",
    Description = "",
    Callback = function()
        ReplicatedStorage.Remotes.Misc.PlayEmote:Fire("floss")
    end,
})

tab:button({
    Name = "Dab",
    Description = "",
    Callback = function()
        ReplicatedStorage.Remotes.Misc.PlayEmote:Fire("dab")
    end,
})

tab:button({
    Name = "Sit",
    Description = "",
    Callback = function()
        ReplicatedStorage.Remotes.Misc.PlayEmote:Fire("sit")
    end,
})

local animationIds = {
    ["Float Slash"] = "rbxassetid://717879555",
    ["Down Slash"] = "rbxassetid://746398327",
    ["Arms Out"] = "rbxassetid://582384156",
    ["Spinner"] = "rbxassetid://754658275",
    ["Crazy Slash"] = "rbxassetid://674871189",
    ["Weird Zombie"] = "rbxassetid://708553116",
    ["Pull"] = "rbxassetid://675025795",
    ["Open"] = "rbxassetid://582855105",
    ["Circle Arm"] = "rbxassetid://698251653",
    ["Bend"] = "rbxassetid://696096087",
    ["Rotate Slash"] = "rbxassetid://675025570",
    ["Flail Arms"] = "rbxassetid://754656200",
    ["Punch"] = "rbxassetid://846744780",
    ["Murderer Slash"] = "rbxassetid://2467567750",
    ["Murderer Stab"] = "rbxassetid://1957890538",
    ["Dual Stab"] = "rbxassetid://2470501967",
    ["Dual Slash"] = "rbxassetid://2467577524",
    ["Lick"] = "rbxassetid://2474137630",
    ["Spray"] = "rbxassetid://2474355515",
    ["Fireflies"] = "rbxassetid://2474321961",
    ["Coconut"] = "rbxassetid://18326977397",
    ["Sandcastle"] = "rbxassetid://18326045248",
    ["Sand Bucket"] = "rbxassetid://18324663531",
    ["Water Balloon"] = "rbxassetid://18324269091",
    ["Crouch"] = "rbxassetid://5792999092",
    ["Throw"] = "rbxassetid://1957656552",
    ["Throw Hold"] = "rbxassetid://15478370930",
    ["Throw Charge"] = "rbxassetid://1957618848",
}

local currentAnimation = nil
local currentTrack = nil
local isPlaying = false
local currentSpeed = 60

local function PlayAnimation()
    if currentTrack then
        currentTrack:Play()
        currentTrack:AdjustSpeed(currentSpeed / 100) -- Set the speed whenever the animation is played
        isPlaying = true
    end
end

local function StopAnimation()
    if currentTrack then
        currentTrack:Stop()
        isPlaying = false
    end
end

tab:dropdown({
    Name = "Energizer Emotes",
    Description = "MM2 Edition",
    StartingText = "",
    Items = {"Float Slash", "Down Slash", "Arms Out", "Spinner", "Crazy Slash", "Weird Zombie", "Pull", "Open", "Circle Arm", "Bend", "Rotate Slash", "Flail Arms", "Punch", "Murderer Slash", "Murderer Stab", "Dual Stab", "Dual Slash", "Lick", "Spray", "Fireflies", "Coconut", "Sandcastle", "Sand Bucket", "Water Balloon", "Crouch", "Throw", "Throw Hold", "Throw Charge"},
    Callback = function(Value)
        if currentTrack then
            StopAnimation()
        end
        local animationId = animationIds[Value]
        local anim = Instance.new("Animation")
        anim.AnimationId = animationId
        currentTrack = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
        currentAnimation = Value
    end
})

tab:toggle({
    Name = "Toggle Emote",
    StartingState = false,
    Description = "",
    Callback = function(Value)
        if currentAnimation then
            if Value then
                PlayAnimation()
                -- Check if animation stopped playing, then restart it and set speed
                while isPlaying do
                    if not currentTrack.IsPlaying then
                        PlayAnimation()
                    end
                    currentTrack:AdjustSpeed(currentSpeed / 100) -- Ensure speed is set consistently
                    wait(0) -- Adjust the delay between checks as needed
                end
            else
                StopAnimation()
            end
        end
    end,
})

local something = tab:slider({
    Name = "Energizer Emote Speed",
    Description = "",
    Default = 60,
    Min = 0,
    Max = 1000,
    Rounding = 1,
    Callback = function(v)
        currentSpeed = v -- Update the global speed variable
        if currentTrack then
            currentTrack:AdjustSpeed(currentSpeed / 100) -- Adjust the speed of the current track
        end
    end
})

local originalAnimations = {}
local originalHipHeight

tab:toggle({
    Name = "Sit Walk",
    StartingState = false,
    Description = "",
    Callback = function(state)
        local plr = game.Players.LocalPlayer
        local character = plr.Character
        local anims = character:WaitForChild("Animate")
        local humanoid = character:FindFirstChildOfClass("Humanoid")

        if state then
            -- Save original animations and hip height
            originalAnimations.idle = anims.idle:FindFirstChildOfClass("Animation").AnimationId
            originalAnimations.walk = anims.walk:FindFirstChildOfClass("Animation").AnimationId
            originalAnimations.run = anims.run:FindFirstChildOfClass("Animation").AnimationId
            originalAnimations.jump = anims.jump:FindFirstChildOfClass("Animation").AnimationId
            originalHipHeight = humanoid.HipHeight

            -- Get sit animation
            local sitAnimation = anims.sit:FindFirstChildOfClass("Animation")
            if sitAnimation then
                local sitAnimId = sitAnimation.AnimationId
                anims.idle:FindFirstChildOfClass("Animation").AnimationId = sitAnimId
                anims.walk:FindFirstChildOfClass("Animation").AnimationId = sitAnimId
                anims.run:FindFirstChildOfClass("Animation").AnimationId = sitAnimId
                anims.jump:FindFirstChildOfClass("Animation").AnimationId = sitAnimId

                -- Set HipHeight
                if humanoid.RigType == Enum.HumanoidRigType.R15 then
                    humanoid.HipHeight = 0.5
                else
                    humanoid.HipHeight = -1.5
                end
            else
                warn("Sit animation not found")
            end
        else
            -- Restore original animations and hip height
            if originalAnimations.idle and originalAnimations.walk and originalAnimations.run and originalAnimations.jump then
                anims.idle:FindFirstChildOfClass("Animation").AnimationId = originalAnimations.idle
                anims.walk:FindFirstChildOfClass("Animation").AnimationId = originalAnimations.walk
                anims.run:FindFirstChildOfClass("Animation").AnimationId = originalAnimations.run
                anims.jump:FindFirstChildOfClass("Animation").AnimationId = originalAnimations.jump
            else
                warn("Original animations not properly saved")
            end

            if originalHipHeight then
                humanoid.HipHeight = originalHipHeight
            else
                warn("Original hip height not properly saved")
            end
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
            wait(1) -- Adjust this delay as needed
        end
    end
end,})

tab:button({
    Name = "Fling Murderer",
    Description = "",
    Callback = function()
        local function MurFling(playerName)
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
	if Accessoy and Accessory:FindFirstChild("Handle") then
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

    local checkForMudy = function()
 local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LP = Players.LocalPlayer
    local Murder

    -- Functions --
    function CreateHighlight(player)
        local highlight = Instance.new("Highlight", player.Character)
        highlight.FillColor = Color3.fromRGB(225, 0, 0)
    end

    function RemoveHighlight(player)
        local highlight = player.Character:FindFirstChild("Highlight")
        if highlight then
            highlight:Destroy()
        end
    end

    function SkidFlingTarget(player)
        local character = player.Character
        if character then
            SkidFling(player)  -- Perform the fling

            -- Wait for a certain duration (adjust as needed)
            wait(3)  -- Wait for 3 seconds

            RemoveHighlight(player)  -- Remove the highlight after fling
        end
    end

    -- Get the player's role (assuming this is done once at the beginning)
    local roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    for i, v in pairs(roles) do
        if v.Role == "Murderer" then
            Murderer = i
            local murderer = Players:FindFirstChild(Murderer)
            if murderer then
                CreateHighlight(murderer)
                SkidFlingTarget(murderer)  -- Fling the highlighted sheriff
            end
            break  -- No need to continue checking once a sheriff is found
        end
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

    -- Check for the "murderer" and execute the corresponding logic
    if Targets[1] and Targets[1]:lower() == "mud" then
        checkForMudy()
    end
end

-- Call the function to perform the fling when the script is executed with a player name
-- (e.g., "performFling 'playerName'" or "performFling 'murderer'")
MurFling("mud")
    end,
})

tab:button({
    Name = "Fling Sheriff",
    Description = "",
    Callback = function()
        local function SerFling(playerName)
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
	if Accessoy and Accessory:FindFirstChild("Handle") then
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

    local checkForSery = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LP = Players.LocalPlayer
    local Sheriff

    -- Functions --
    function CreateHighlight(player)
        local highlight = Instance.new("Highlight", player.Character)
        highlight.FillColor = Color3.fromRGB(0, 0, 225) -- Blue color for the sheriff
    end

    function RemoveHighlight(player)
        local highlight = player.Character:FindFirstChild("Highlight")
        if highlight then
            highlight:Destroy()
        end
    end

    function SkidFlingTarget(player)
        local character = player.Character
        if character then
            SkidFling(player)  -- Perform the fling

            -- Wait for a certain duration (adjust as needed)
            wait(3)  -- Wait for 3 seconds

            RemoveHighlight(player)  -- Remove the highlight after fling
        end
    end

    -- Get the player's role (assuming this is done once at the beginning)
    local roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    for i, v in pairs(roles) do
        if v.Role == "Sheriff" then
            Sheriff = i
            local sheriff = Players:FindFirstChild(Sheriff)
            if sheriff then
                CreateHighlight(sheriff)
                SkidFlingTarget(sheriff)  -- Fling the highlighted sheriff
            end
            break  -- No need to continue checking once a sheriff is found
        end
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

    -- Check for the "murderer" and execute the corresponding logic
    if Targets[1] and Targets[1]:lower() == "she" then
        checkForSery()
    end
end

-- Call the function to perform the fling when the script is executed with a player name
-- (e.g., "performFling 'playerName'" or "performFling 'murderer'")
SerFling("she")
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
    Name = "Improve FPS",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   ChangeImproveFPS = Value
    while ChangeImproveFPS do
        for i,v in pairs (Workspace:GetDescendants()) do
            if v.Name == "Pet" then
                v:Destroy()
            elseif v.Name == "KnifeDisplay" then
                v:Destroy()
            elseif v.Name == "GunDisplay" then
                v:Destroy()
            end
        end
        wait(10)
    end
end,})

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

local Services = setmetatable({}, {__index = function(Self, Index)
    local NewService = game.GetService(game, Index)
    if NewService then
        Self[Index] = NewService
    end
    return NewService
end})

local AntiFlingEnabled = false

local LocalPlayer = Services.Players.LocalPlayer

local function PlayerAdded(Player)
    local Detected = false
    local Character
    local PrimaryPart

    local function CharacterAdded(NewCharacter)
        Character = NewCharacter
        repeat
            wait()
            PrimaryPart = NewCharacter:FindFirstChild("HumanoidRootPart")
        until PrimaryPart
        Detected = false
    end

    CharacterAdded(Player.Character or Player.CharacterAdded:Wait())
    Player.CharacterAdded:Connect(CharacterAdded)
    Services.RunService.Heartbeat:Connect(function()
        if AntiFlingEnabled then
            if (Character and Character:IsDescendantOf(workspace)) and (PrimaryPart and PrimaryPart:IsDescendantOf(Character)) then
                if PrimaryPart.AssemblyAngularVelocity.Magnitude > 100 or PrimaryPart.AssemblyLinearVelocity.Magnitude > 200 then
                    if Detected == false then
                        game.StarterGui:SetCore("ChatMakeSystemMessage", {
                            Text = "Possible Flinging detected, Player: " .. tostring(Player);
                            Color = Color3.fromRGB(255, 200, 0);
                        })
                    end
                    Detected = true
                end
            end
        end
    end)
end

for i, v in ipairs(Services.Players:GetPlayers()) do
    if v ~= LocalPlayer then
        PlayerAdded(v)
    end
end
Services.Players.PlayerAdded:Connect(PlayerAdded)

tab:toggle({
    Name = "Fling Detection",
    StartingState = false,
    Description = "Will Notify you when a player has started flinging",
    Callback = function(state)
        AntiFlingEnabled = state
        if state then
            print("")
        else
            print("")
        end
    end,
})
