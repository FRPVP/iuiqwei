 local Sound = Instance.new("Sound",game:GetService("SoundService"))
 Sound.SoundId = "rbxassetid://9120129807"
 Sound:Play()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/FRPVP/iuiqwei/main/library.lua"))()

local gui = Library:create{
    Theme = Library.Themes.Vindicate
}

local tab = gui:tab{
    Icon = "rbxassetid://17628898821",
    Name = "Player"
}

tab:toggle({
    Name = "Inf Jump",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   if Value then
InfJump = game:GetService("UserInputService").JumpRequest:connect(function()
if Value then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
		end
end)
else
InfJump:Disconnect()
end
end,})

tab:button({
    Name = "Play Dead",
    Description = "",
    Callback = function()
    local player = game.Players.LocalPlayer

-- Function to make the character sit
local function sit()
    -- Check if the character exists
    if player.Character then
        -- Loop through each part of the character
        for _, part in pairs(player.Character:GetDescendants()) do
            -- Check if the part is a Humanoid
            if part:IsA("Humanoid") then
                -- Set the sitting property to true
                part.Sit = true
            end
        end
    end
end

-- Call the sit function
sit()
    end,
})

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

tab:textbox({
    Name = "Walkspeed",
    Callback = function(Value)
        local newWalkSpeed = tonumber(Value)
        if newWalkSpeed then
            -- Clamp the new walk speed value between 16 and 300
            currentWalkSpeed = math.clamp(newWalkSpeed, 16, 300)
            
            -- Update the walk speed
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = currentWalkSpeed
            end
            
            print("Walk speed changed to:", currentWalkSpeed)
        else
            warn("Invalid input. Please enter a valid number.")
        end
    end
})

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

tab:textbox({
    Name = "Jump Height",
    Callback = function(Value)
        local newJumpPower = tonumber(Value)
        if newJumpPower then
            -- Clamp the new jump power value between 50 and 300
            currentJumpPower = math.clamp(newJumpPower, 50, 300)
            
            -- Update the jump power
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character.Humanoid.JumpPower = currentJumpPower
            end
            
            print("Jump power changed to:", currentJumpPower)
        else
            warn("Invalid input. Please enter a valid number.")
        end
    end
})

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

tab:textbox({
Name = "Fly Speed",
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

tab:button({
    Name = "Free Xbox",
    Description = "",
    Callback = function()
    local Event = game:GetService("ReplicatedStorage").Remotes.Extras.IsXbox
Event:FireServer(A_1)
    end,
})

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









local tab = gui:tab{
    Icon = "rbxassetid://17628884815",
    Name = "Visual"
}

getgenv().BetterESP = false
tab:toggle({
    Name = "Player ESP",
    StartingState = false,
    Description = "",
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

local BillboardGui = nil
local RenderSteppedConnection = nil
local Gun = Workspace:FindFirstChild("GunDrop")
local ToggleValue = false

local function CreateBillboardAboveGun(gun)
    BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Adornee = gun
    BillboardGui.Size = UDim2.new(0, 80, 0, 50) -- Decreased size for smaller text
    BillboardGui.StudsOffset = Vector3.new(0, 3, 0) -- Adjust the height of the billboard
    BillboardGui.AlwaysOnTop = true -- Ensure the billboard is always visible

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Text = "Gundrop"
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.TextColor3 = Color3.fromRGB(0, 214, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextScaled = true -- Allow the text to scale based on the size of the billboard
    TextLabel.Parent = BillboardGui

    BillboardGui.Parent = gun
end

local function DestroyBillboard()
    if BillboardGui then
        BillboardGui:Destroy()
        BillboardGui = nil
    end
    if RenderSteppedConnection then
        RenderSteppedConnection:Disconnect()
        RenderSteppedConnection = nil
    end
end

local function OnGunAdded(gun)
    if ToggleValue then
        CreateBillboardAboveGun(gun)
    end
end

local function OnGunRemoved(gun)
    DestroyBillboard()
end

local function ToggleChanged(newValue)
    ToggleValue = newValue
    if newValue then
        if Gun then
            OnGunAdded(Gun)
        end
    else
        DestroyBillboard()
    end
    print("Toggle value changed to:", newValue)
end

tab:toggle({
    Name = "Gun ESP",
    StartingState = false,
    Description = "",
    Callback = ToggleChanged
})

Workspace.ChildAdded:Connect(function(child)
    if child.Name == "GunDrop" then
        Gun = child
        OnGunAdded(child)
    end
end)

Workspace.ChildRemoved:Connect(function(child)
    if child.Name == "GunDrop" then
        OnGunRemoved(child)
    end
end)

local GunHighlight = nil
local GunHandleAdornment = nil
local RenderSteppedConnection = nil
local ToggleValue = false

local function CreateGunAdornment(gun)
    GunHighlight = Instance.new("Highlight")
    GunHandleAdornment = Instance.new("SphereHandleAdornment")

    GunHandleAdornment.Radius = (gun.Size.X + gun.Size.Y + gun.Size.Z) / 3
    GunHandleAdornment.Adornee = gun
    GunHandleAdornment.Color3 = Color3.fromRGB(0,214,0,255)
    GunHandleAdornment.Transparency = 0.2
    GunHandleAdornment.AlwaysOnTop = true
    GunHandleAdornment.ZIndex = 10
    GunHandleAdornment.Parent = gun

    local function UpdateGunHighlight()
        if gun.Parent then
            GunHighlight.Adornee = gun
            GunHandleAdornment.Adornee = gun
            GunHandleAdornment.Size = gun.Size + Vector3.new(0.05, 0.05, 0.05)
            GunHighlight.Enabled = true
            GunHandleAdornment.Visible = true
        else
            GunHighlight.Enabled = false
            GunHandleAdornment.Visible = false
        end
    end

    UpdateGunHighlight()

    RenderSteppedConnection = game:GetService("RunService").RenderStepped:Connect(function()
        UpdateGunHighlight()
    end)
end

local function DestroyGunAdornment()
    if GunHighlight then
        GunHighlight:Destroy()
    end
    if GunHandleAdornment then
        GunHandleAdornment:Destroy()
    end
    if RenderSteppedConnection then
        RenderSteppedConnection:Disconnect()
    end
end

local function ToggleChanged(newValue)
    ToggleValue = newValue
    if newValue then
        for _, gun in ipairs(Workspace:GetChildren()) do
            if gun.Name == "GunDrop" then
                CreateGunAdornment(gun)
            end
        end
        Workspace.ChildAdded:Connect(function(child)
            if child.Name == "GunDrop" then
                CreateGunAdornment(child)
            end
        end)
    else
        DestroyGunAdornment()
    end
    print("Toggle value changed to:", newValue)
end

tab:toggle({
    Name = "Gun Highlight",
		StartingState = false,
		Description = "",
		Callback = ToggleChanged
})

tab:button({
    Name = "Notify Roles",
    Description = "",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do 
    if player.Character and (player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife")) then 
        game.StarterGui:SetCore("SendNotification", {
            Title = "Murder Detected",
            Text = "Murder is " .. player.Name .. "!",
            Duration = 5
        })
    end 
end

for _, player in pairs(game.Players:GetPlayers()) do 
    if player.Character and (player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun")) then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Sheriff Detected",
            Text = "Sheriff is " .. player.Name .. "!",
            Duration = 5
        })
    end 
end
    end,
})

tab:button({
    Name = "Message Roles",
    Description = "",
    Callback = function()
        local function checkForKnife(player)
    return player.Character and (player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife"))
end

-- Function to check if a player has a gun
local function checkForGun(player)
    return player.Character and (player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun"))
end

-- Iterate through players to determine roles and send chat messages
for _, player in ipairs(game.Players:GetPlayers()) do
    if checkForKnife(player) then
        game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer("Murderer: " .. player.Name, "normalchat")
    elseif checkForGun(player) then
        game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer("Sheriff: " .. player.Name, "normalchat")
    end
end
    end,
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
    Icon = "rbxassetid://17628895810",
    Name = "Combat"
}

tab:button({
    Name = "Shoot Murderer",
    Description = "",
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
        [3] = "AH"
    }

    localPlayer.Character.Gun.KnifeServer.ShootGun:InvokeServer(unpack(args))
end

shootMurderer()
    end,
})

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
    local gunDrop = workspace:WaitForChild("GunDrop") -- Wait for GunDrop to exist in Workspace

    -- Check if GunDrop exists
    if gunDrop then
        -- Teleport the player to the GunDrop's position
        player.Character:SetPrimaryPartCFrame(gunDrop.CFrame)
        
        -- Wait for a moment (adjust the time as needed)
        wait(0.2)
        
        -- Teleport the player back to the original position
        player.Character:SetPrimaryPartCFrame(originalPosition)
    else
        warn("GunDrop not found in Workspace")
    end
end

-- Call the function directly without a key press
teleportToGunDrop()
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
                    knifeServer.ShootGun:InvokeServer(1, 0, "AH")
                end)
            end
        elseif characterGun then
            local knifeServer = characterGun:FindFirstChild("KnifeServer")
            if knifeServer then
                pcall(function()
                    knifeServer.ShootGun:InvokeServer(1, 0, "AH")
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
                                knifeServer.ShootGun:InvokeServer(1, 0, "AH")
                            end)
                        end
                    elseif characterGun then
                        local knifeServer = characterGun:FindFirstChild("KnifeServer")
                        if knifeServer then
                            pcall(function()
                                knifeServer.ShootGun:InvokeServer(1, 0, "AH")
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





local tab = gui:tab{
    Icon = "rbxassetid://17628887332",
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
    Icon = "rbxassetid://17628882295",
    Name = "Trolling"
}

tab:toggle({
    Name = "Toggle Fake Gun",
		StartingState = false,
		Description = "Fake Gun Perk Required",
		Callback = function(val)
   if val then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("FakeGun"):FireServer(unpack({
    [1] = true
}))
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("FakeGun"):FireServer(unpack({
    [1] = false
}))
end
end,})

tab:button({
    Name = "Get Fake Gun",
    Description = "Fake Gun Perk Required",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("FakeGun"):FireServer(unpack({
    [1] = true -- set to true to activate
}))
    end,
})

tab:button({
    Name = "Drop Fake Gun",
    Description = "Requires Fake Gun Perk And A Godly Gun Thats An Official Roblox Asset",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("FakeGun"):FireServer(unpack({
    [1] = true -- set to true to activate
}))

wait(0.2)

game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace
    end,
})

local dropGunEnabled = false
local dropGunConnection = nil

tab:toggle({
    Name = "Fake Gun Rain",
		StartingState = false,
		Description = "Requires Fake Gun Perk And A Godly Gun Thats An Official Roblox Asset",
		Callback = function(Value)
   local toggleValue = Value
    if toggleValue then
        -- Start dropping fake gun
        dropGunEnabled = true
        dropGunConnection = game:GetService("RunService").Stepped:Connect(function()
            if dropGunEnabled then
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("FakeGun"):FireServer(true)
                wait(0.2)
                local character = game.Players.LocalPlayer.Character
                if character then
                    local tool = character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool.Parent = game.Workspace
                    end
                end
            end
        end)
    else
        -- Stop dropping fake gun
        dropGunEnabled = false
        if dropGunConnection then
            dropGunConnection:Disconnect()
        end
    end
end,})

tab:button({
    Name = "Clear Dropped Guns",
    Description = "Server Side",
    Callback = function()
        local function gimmeTools()
    local p = game:GetService("Players").LocalPlayer
    local c = p.Character
    if c and c:FindFirstChild("Humanoid") then
        for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("Tool") then
                c:FindFirstChild("Humanoid"):EquipTool(v)
            end
        end
    end
end

gimmeTools()

wait(3)

-- Get the player
local player = game.Players.LocalPlayer

-- Get the player's backpack
local backpack = player.Backpack

-- Name of the tool to exclude
local toolToExclude = "Emotes"

-- Remove all tools from the backpack except the one specified
for _, tool in pairs(backpack:GetChildren()) do
    if tool:IsA("Tool") and tool.Name ~= toolToExclude then
        tool:Destroy()
    end
end
    end,
})

tab:button({
    Name = "Clear Dropped Guns",
    Description = "Client Side",
    Callback = function()
        local children = game.Workspace:GetChildren()

-- Iterate through each child
for _, child in pairs(children) do
    -- Check if the child is a Tool
    if child:IsA("Tool") then
        -- Delete the tool
        child:Destroy()
    end
end
    end,
})

tab:button({
    Name = "Clear Fake Guns From Inventory",
    Description = "",
    Callback = function()
        local player = game.Players.LocalPlayer

-- Get the player's backpack
local backpack = player.Backpack

-- Name of the tool to exclude
local toolToExclude = "Emotes"

-- Remove all tools from the backpack except the one specified
for _, tool in pairs(backpack:GetChildren()) do
    if tool:IsA("Tool") and tool.Name ~= toolToExclude then
        tool:Destroy()
    end
end
    end,
})

local RS = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local Gameplay = Remotes:WaitForChild("Gameplay")
local StealthRemote = Gameplay:WaitForChild("Stealth")

local Stealth

tab:toggle({
    Name = "Ghost",
		StartingState = false,
		Description = "Ghost Perk Required",
		Callback = function(val)
   if val then
        -- If toggle is turned on, activate Stealth
        Stealth = RS.RenderStepped:Connect(function()
            StealthRemote:FireServer(true)
        end)
    else
        -- If toggle is turned off, disconnect the Stealth activation
        if Stealth then
            Stealth:Disconnect()
            Stealth = nil
        end
        -- Deactivate Stealth
        StealthRemote:FireServer(false)
    end
end,})

tab:toggle({
    Name = "Sprint Trail",
		StartingState = false,
		Description = "Sprint Perk Required",
		Callback = function(val)
   if val then
        -- If toggle is turned on, activate the trail
        sprint = RS.RenderStepped:Connect(function()
            game:GetService("Players").LocalPlayer.Character.SpeedTrail.Toggle:FireServer(true)
        end)
    else
        -- If toggle is turned off, disconnect the trail activation
        if sprint then
            sprint:Disconnect()
        end
        -- Deactivate the trail
        game:GetService("Players").LocalPlayer.Character.SpeedTrail.Toggle:FireServer(false)
    end
end,})

tab:button({
    Name = "Spawn Trap",
    Description = "Trap Perk Required",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local lp = game:GetService("Players").LocalPlayer

        -- Invoke the server to spawn a trap
        ReplicatedStorage:WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(lp.Character.HumanoidRootPart.CFrame)
    end,
})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local trapToggle = false
local trapLoop
local trapSpawnDelay = 0 -- Default delay value

local function spawnTrapLoop()
    while trapToggle do
        -- Invoke the server to spawn a trap
        ReplicatedStorage:WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(lp.Character.HumanoidRootPart.CFrame)
        wait(trapSpawnDelay) -- Add a delay after spawning each trap
    end
end

tab:toggle({
    Name = "Loop Traps",
		StartingState = false,
		Description = "Trap Perk Required",
		Callback = function(Value)
   trapToggle = Value
    if trapToggle then
        -- Start the trap spawn loop
        spawnTrapLoop()
    else
        -- If toggle turned off, disconnect the loop
        if trapLoop then
            trapLoop:Disconnect()
        end
    end
end,})

local trapsd = tab:slider({
    Name = "Loop Trap Delay",
    Description = "",
    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Callback = function(Value)
        trapSpawnDelay = Value 
    end
})

tab:textbox({
Name = "Loop Trap Delay",
    Callback = function(Value)
        local delay = tonumber(Value)
    if delay then
        if delay >= 0 and delay <= 10 then
            trapSpawnDelay = delay
        else
            -- Ensure the delay value stays within the range of 0 to 10
            trapSpawnDelay = math.clamp(delay, 0, 10)
        end
    end
    end
})

tab:button({
    Name = "Trap All",
    Description = "Trap Perk Required",
    Callback = function()
        for i,x in pairs(Players:GetPlayers()) do
if x ~= lp then
game:GetService("ReplicatedStorage"):WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(unpack({
    [1] = x.Character.HumanoidRootPart.CFrame
}))
end
end
    end,
})

tab:button({
    Name = "Trap Murderer",
    Description = "Trap Perk Required",
    Callback = function()
        for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
game:GetService("ReplicatedStorage"):WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame
}))
end
end
    end,
})

tab:button({
    Name = "Trap Sheriff",
    Description = "Trap Perk Required",
    Callback = function()
        for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
game:GetService("ReplicatedStorage"):WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame
}))
end
end
    end,
})

tab:button({
    Name = "Take The Murderer's Knife",
    Description = "Able to swing it around but not kill",
    Callback = function()
        for i,s in pairs(Players:GetPlayers()) do
if s ~= Players.LocalPlayer and s.Backpack:FindFirstChild("Knife") or s.Character:FindFirstChild("Knife") then
s.Backpack.Knife.Parent = Players.LocalPlayer.Backpack
end
end
    end,
})

tab:button({
    Name = "Take The Sheriff's Gun",
    Description = "Shoot a player in order to break the gun",
    Callback = function()
        for i,s in pairs(Players:GetPlayers()) do
if s ~= Players.LocalPlayer and s.Backpack:FindFirstChild("Gun") or s.Character:FindFirstChild("Gun") then
s.Backpack.Gun.Parent = Players.LocalPlayer.Backpack
end
end
    end,
})








local tab = gui:tab{
    Icon = "rbxassetid://17628879224",
    Name = "Autofarm"
}














local tab = gui:tab{
    Icon = "rbxassetid://17628876487",
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
    ["Murderer Slash"] = "rbxassetid://2467567750",
    ["Murderer Stab"] = "rbxassetid://1957890538",
}

local currentAnimation = nil
local currentTrack = nil
local isPlaying = false
local currentSpeed = 1

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
    Description = "",
    StartingText = "Bodypart",
    Items = {"Float Slash", "Down Slash", "Arms Out", "Spinner", "Crazy Slash", "Weird Zombie", "Pull", "Open", "Circle Arm", "Bend", "Rotate Slash", "Flail Arms", "Murderer Slash", "Murderer Stab"},
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
    Name = "Emote Speed",
    Description = "",
    Default = 1,
    Min = 1,
    Max = 1000,
    Rounding = 1,
    Callback = function(v)
        currentSpeed = v -- Update the global speed variable
        if currentTrack then
            currentTrack:AdjustSpeed(currentSpeed / 100) -- Adjust the speed of the current track
        end
    end
})

tab:textbox({
    Name = "Emote Speed",
    Description = "",
    Placeholder = "1-1000",
    Callback = function(v)
        local numericValue = tonumber(v)
        if numericValue then
            currentSpeed = numericValue -- Update the global speed variable
            if currentTrack then
                currentTrack:AdjustSpeed(currentSpeed / 100) -- Adjust the speed of the current track
            end
        end
    end
})




local tab = gui:tab{
    Icon = "rbxassetid://17628892018",
    Name = "Spraypaint"
}

local function findPlayerByName(name)
    -- Function to find a player by name or a shortened version of the name
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if string.find(player.Name:lower(), name:lower(), 1, true) then
            return player
        end
    end
    return nil
end

local fetargetname = ""

tab:textbox({
Name = "Target User",
Description = "Type All to select all players",
    Callback = function(Value)
        fetargetname = Value
    end
})

function EquipSpray()
    game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
    wait()
    for _, obj in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if obj.Name == "SprayPaint" then
            obj.Parent = game.Players.LocalPlayer.Character
        end
    end
end

function heatplayerfunc(heatplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(80373024, Enum.NormalId.Back, 15, (heatplayertarget.Character.Head), heatplayertarget.Character.Head.CFrame * CFrame.new(0, math.huge, 0))
end

tab:button({
    Name = "Reset",
    Description = "Spraypaint Toy Required",
    Callback = function()
        if fetargetname == "All" then
        EquipSpray() -- Equip the spray first
        -- Iterate over all players and execute heatplayerfunc on each player except yourself
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                heatplayerfunc(player)
            end
        end
    elseif fetargetname ~= "" then
        EquipSpray() -- Equip the spray first
        -- Find the player with the selected name
        local heatplayertarget = findPlayerByName(fetargetname)
        if heatplayertarget then
            heatplayerfunc(heatplayertarget) -- Execute heatplayerfunc on the player
        else
            print("Player not found.")
        end
    else
        print("Please select a name from the dropdown.")
    end
    end,
})

function resetplayerfunc(resetplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(80373024, Enum.NormalId.Back, 15, resetplayertarget.Character.Head, resetplayertarget.Character.Head.CFrame * CFrame.new(0, math.huge, 0))
end

local resetplayerloop = false

tab:toggle({
    Name = "Loop Reset",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(resetplayer)
    if resetplayer == true then
        resetplayerloop = true
        while resetplayerloop do
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local resetplayertarget = v
                        resetplayerfunc(resetplayertarget)
                        task.wait()
                    end
                end
            else
                local resetplayertarget = findPlayerByName(fetargetname)
                if resetplayertarget then
                    resetplayerfunc(resetplayertarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(0)
        end
    end
    if resetplayer == false then
        resetplayerloop = false
    end
end,})

function collideplayerfunc(collideplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Back, 6.331, collideplayertarget.Character.HumanoidRootPart, collideplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 99999, 0))
end

local collideplayerloop = false

tab:toggle({
    Name = "Remove Collisions",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        collideplayerloop = true
        while collideplayerloop do
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local collideplayertarget = v
                        collideplayerfunc(collideplayertarget)
                        task.wait()
                    end
                end
            else
                local collideplayertarget = findPlayerByName(fetargetname)
                if collideplayertarget then
                    collideplayerfunc(collideplayertarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(15)
        end
    end
    if Value == false then
        collideplayerloop = false
    end
end,})

function poolplayerfunc(poolplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Top, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Bottom, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Bottom, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Top, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Front, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Back, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Front, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Back, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Right, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Left, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Right, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Left, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
end

local poolplayerloop = false

tab:toggle({
    Name = "Blind",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        poolplayerloop = true
        while poolplayerloop do
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local poolplayertarget = v
                        poolplayerfunc(poolplayertarget)
                        task.wait()
                    end
                end
            else
                local poolplayertarget = findPlayerByName(fetargetname)
                if poolplayertarget then
                    poolplayerfunc(poolplayertarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(15)
        end
    end
    if Value == false then
        poolplayerloop = false
    end
end,})

function feslipfunc(fesliptarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, fesliptarget.Character.LeftUpperLeg, fesliptarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -2, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, fesliptarget.Character.LeftUpperLeg, fesliptarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -2, 0))
end

local fesliploop = false

tab:toggle({
    Name = "Slip Up",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        fesliploop = true
        while fesliploop do
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local fesliptarget = v
                        feslipfunc(fesliptarget)
                        task.wait()
                    end
                end
            else
                local fesliptarget = findPlayerByName(fetargetname)
                if fesliptarget then
                    feslipfunc(fesliptarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(15)
        end
    end
    if Value == false then
        fesliploop = false
    end
end,})

function opiwhdaplayerfunc(opiwhdaplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Back, 6.331, opiwhdaplayertarget.Character.HumanoidRootPart, opiwhdaplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 99999, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, opiwhdaplayertarget.Character.LeftUpperLeg, opiwhdaplayertarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -100, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, opiwhdaplayertarget.Character.LeftUpperLeg, opiwhdaplayertarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -100, 0))
end

local opiwhdaplayerloop = false

tab:toggle({
    Name = "Void",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        opiwhdaplayerloop = true
        while opiwhdaplayerloop do
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local opiwhdaplayertarget = v
                        opiwhdaplayerfunc(opiwhdaplayertarget)
                        task.wait()
                    end
                end
            else
                local opiwhdaplayertarget = findPlayerByName(fetargetname)
                if opiwhdaplayertarget then
                    opiwhdaplayerfunc(opiwhdaplayertarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(0)
        end
    end
    if Value == false then
        opiwhdaplayerloop = false
    end
end,})

function jadoiwanplayerfunc(jadoiwanplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 2048, jadoiwanplayertarget.Character.LeftHand, jadoiwanplayertarget.Character.LeftHand.CFrame * CFrame.new(0, 0, 0))
end

local jadoiwanplayerloop = false

tab:toggle({
    Name = "Freeze",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        jadoiwanplayerloop = true
        while jadoiwanplayerloop do
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local jadoiwanplayertarget = v
                        jadoiwanplayerfunc(jadoiwanplayertarget)
                        task.wait()
                    end
                end
            else
                local jadoiwanplayertarget = findPlayerByName(fetargetname)
                if jadoiwanplayertarget then
                    jadoiwanplayerfunc(jadoiwanplayertarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(0)
        end
    end
    if Value == false then
        jadoiwanplayerloop = false
    end
end,})

function andlxcaosplayerfunc(andlxcaosplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Right, 2048, andlxcaosplayertarget.Character.HumanoidRootPart, andlxcaosplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 250, 0))
end

local andlxcaosplayerloop = false

tab:toggle({
    Name = "Lag",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        andlxcaosplayerloop = true
        while andlxcaosplayerloop do
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local andlxcaosplayertarget = v
                        andlxcaosplayerfunc(andlxcaosplayertarget)
                        task.wait()
                    end
                end
            else
                local andlxcaosplayertarget = findPlayerByName(fetargetname)
                if andlxcaosplayertarget then
                    andlxcaosplayerfunc(andlxcaosplayertarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(0)
        end
    end
    if Value == false then
        andlxcaosplayerloop = false
    end
end,})

function iopiipiopolllplayerfunc(iopiipiopolllplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Front, 2500, iopiipiopolllplayertarget.Character.RightHand, iopiipiopolllplayertarget.Character.RightHand.CFrame * CFrame.new(0, -50, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Front, 2500, iopiipiopolllplayertarget.Character.RightHand, iopiipiopolllplayertarget.Character.RightHand.CFrame * CFrame.new(0, 50, 0))
end

local iopiipiopolllplayerloop = false

tab:toggle({
    Name = "Launch Up",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        iopiipiopolllplayerloop = true
        while iopiipiopolllplayerloop do
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local iopiipiopolllplayertarget = v
                        iopiipiopolllplayerfunc(iopiipiopolllplayertarget)
                        task.wait()
                    end
                end
            else
                local iopiipiopolllplayertarget = findPlayerByName(fetargetname)
                if iopiipiopolllplayertarget then
                    iopiipiopolllplayerfunc(iopiipiopolllplayertarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(15)
        end
    end
    if Value == false then
        iopiipiopolllplayerloop = false
    end
end,})

function qweqqwwplayerfunc(qweqqwwplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Front, 8, qweqqwwplayertarget.Character.Head, qweqqwwplayertarget.Character.Head.CFrame * CFrame.new(0, 50.5, 0))
end

local qweqqwwplayerloop = false

tab:toggle({
    Name = "Shake",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        qweqqwwplayerloop = true
        while qweqqwwplayerloop do
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local qweqqwwplayertarget = v
                        qweqqwwplayerfunc(qweqqwwplayertarget)
                        task.wait()
                    end
                end
            else
                local qweqqwwplayertarget = findPlayerByName(fetargetname)
                if qweqqwwplayertarget then
                    qweqqwwplayerfunc(qweqqwwplayertarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(15)
        end
    end
    if Value == false then
        qweqqwwplayerloop = false
    end
end,})

function bnmbnbbplayerfunc(bnmbnbbplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Front, 10000, bnmbnbbplayertarget.Character.LeftLowerArm, bnmbnbbplayertarget.Character.LeftLowerArm.CFrame * CFrame.new(0, 0, -1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Front, 10000, bnmbnbbplayertarget.Character.RightLowerArm, bnmbnbbplayertarget.Character.RightLowerArm.CFrame * CFrame.new(0, 0, -1))
end

local bnmbnbbplayerloop = false

tab:toggle({
    Name = "Slick Movement",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        bnmbnbbplayerloop = true
        while bnmbnbbplayerloop do
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local bnmbnbbplayertarget = v
                        bnmbnbbplayerfunc(bnmbnbbplayertarget)
                        task.wait()
                    end
                end
            else
                local bnmbnbbplayertarget = findPlayerByName(fetargetname)
                if bnmbnbbplayertarget then
                    bnmbnbbplayerfunc(bnmbnbbplayertarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(15)
        end
    end
    if Value == false then
        bnmbnbbplayerloop = false
    end
end,})










local tab = gui:tab{
    Icon = "rbxassetid://17640081865",
    Name = "Spraypaint Creative"
}

local infinityGauntlet = ""

tab:textbox({
Name = "Target User",
Description = "Type All to select all players",
    Callback = function(Value)
        infinityGauntlet = Value
    end
})

function asndzxnchajsplayerfunc(asndzxnchajsplayertarget)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(8, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(8, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(8, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(8, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(8, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-8, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-8, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-8, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-8, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-8, 14, 0))
end

local asndzxnchajsplayerloop = false

tab:toggle({
    Name = "Nazi",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        asndzxnchajsplayerloop = true
        while asndzxnchajsplayerloop do
            EquipSpray()
            task.wait(0.4)
            if infinityGauntlet == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local asndzxnchajsplayertarget = v
                        asndzxnchajsplayerfunc(asndzxnchajsplayertarget)
                        task.wait()
                    end
                end
            else
                local asndzxnchajsplayertarget = findPlayerByName(infinityGauntlet)
                if asndzxnchajsplayertarget then
                    asndzxnchajsplayerfunc(asndzxnchajsplayertarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(15)
        end
    end
    if Value == false then
        asndzxnchajsplayerloop = false
    end
end,})

function djiwbdjksbbxkzplayerfunc(djiwbdjksbbxkzplayertarget)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14976845153, Enum.NormalId.Front, 1.5, (djiwbdjksbbxkzplayertarget.Character.HumanoidRootPart), djiwbdjksbbxkzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.15,-2.90))
end

local djiwbdjksbbxkzplayerloop = false

tab:toggle({
    Name = "Cum On Penis",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        djiwbdjksbbxkzplayerloop = true
        while djiwbdjksbbxkzplayerloop do
            EquipSpray()
            task.wait(0.4)
            if infinityGauntlet == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local djiwbdjksbbxkzplayertarget = v
                        djiwbdjksbbxkzplayerfunc(djiwbdjksbbxkzplayertarget)
                        task.wait()
                    end
                end
            else
                local djiwbdjksbbxkzplayertarget = findPlayerByName(infinityGauntlet)
                if djiwbdjksbbxkzplayertarget then
                    djiwbdjksbbxkzplayerfunc(djiwbdjksbbxkzplayertarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(15)
        end
    end
    if Value == false then
        djiwbdjksbbxkzplayerloop = false
    end
end,})

local Players = game:GetService("Players")
local sprayId = 60484593

local function sprayOnPlayer(target)
    local localPlayer = Players.LocalPlayer
    if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local humanoidRootPart = target.Character.HumanoidRootPart

    -- Top Spray
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -2.5))

    -- Bottom Spray
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -2.5))

    -- Left Spray
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -2.5))

    -- Right Spray
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -2.5))

    -- Front Spray
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.15, -2.65))

    -- Left Sack
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1.15, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1.3, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.65, -1.15, -0.7))

    -- Right Sack
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1.15, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1.3, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.65, -1.15, -0.7))
end

local sprayLoop = false

tab:toggle({
    Name = "Penis",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(Value)
        if Value then
            sprayLoop = true
            while sprayLoop do
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player ~= Players.LocalPlayer then -- Skip executing the function on yourself
                            sprayOnPlayer(player)
                            task.wait()
                        end
                    end
                else
                    local targetPlayer = findPlayerByName(infinityGauntlet)
                    if targetPlayer then
                        sprayOnPlayer(targetPlayer)
                    else
                        print("Player not found.")
                    end
                end
                task.wait(15)
            end
        else
            sprayLoop = false
        end
    end
})

tab:textbox({
    Name = "Custom Penis ID",
    Callback = function(Value)
        sprayId = tonumber(Value) or sprayId
    end
})

local Players = game:GetService("Players")
local bigpenisId = 60484593

local function bigsprayOnPlayer(target)
    local localPlayer = Players.LocalPlayer
    if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local humanoidRootPart = target.Character.HumanoidRootPart

    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Bottom, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -2.9, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Bottom, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(2.5, -2.9, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Bottom, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-2.5, -2.9, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Top, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(2.5, -0.6, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Top, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -0.6, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Top, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-2.5, -0.6, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Left, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-3.65, -1.75, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Right, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(3.65, -1.75, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Front, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(2.5, -1.75, -3.15))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Front, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-2.5, -1.75, -3.15))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Back, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(2.5, -1.75, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Back, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.75, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Back, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-2.5, -1.75, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Left, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-1.15, -1.75, -4.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Right, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(1.15, -1.75, -4.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Left, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-1.15, -1.75, -6.75))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Right, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(1.15, -1.75, -6.75))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Top, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -0.6, -4.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Top, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -0.6, -6.75))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Bottom, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -2.9, -4.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Bottom, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -2.9, -6.75))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Left, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-1.15, -1.75, -9))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Right, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(1.15, -1.75, -9))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Top, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -0.6, -9))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Bottom, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -2.9, -9))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Front, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.75, -10.15))
end

local bigsprayLoop = false

tab:toggle({
    Name = "Big Penis",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(Value)
        if Value then
            bigsprayLoop = true
            while bigsprayLoop do
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player ~= Players.LocalPlayer then -- Skip executing the function on yourself
                            bigsprayOnPlayer(player)
                            task.wait()
                        end
                    end
                else
                    local targetPlayer = findPlayerByName(infinityGauntlet)
                    if targetPlayer then
                        bigsprayOnPlayer(targetPlayer)
                    else
                        print("Player not found.")
                    end
                end
                task.wait(15)
            end
        else
            bigsprayLoop = false
        end
    end
})

tab:textbox({
    Name = "Custom Big Penis ID",
    Callback = function(Value)
        bigpenisId = tonumber(Value) or bigpenisId
    end
})

local Players = game:GetService("Players")
local tagId = 60484593

local function tagsprayOnPlayer(target)
    local localPlayer = Players.LocalPlayer
    if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local humanoidRootPart = target.Character.HumanoidRootPart

    localPlayer.Character.SprayPaint.Remote:FireServer(tagId, Enum.NormalId.Front, 5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 5, 0))
end

local tagsprayLoop = false

tab:toggle({
    Name = "Tag",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(Value)
        if Value then
            tagsprayLoop = true
            while tagsprayLoop do
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player ~= Players.LocalPlayer then -- Skip executing the function on yourself
                            tagsprayOnPlayer(player)
                            task.wait()
                        end
                    end
                else
                    local targetPlayer = findPlayerByName(infinityGauntlet)
                    if targetPlayer then
                        tagsprayOnPlayer(targetPlayer)
                    else
                        print("Player not found.")
                    end
                end
                task.wait(15)
            end
        else
            tagsprayLoop = false
        end
    end
})

tab:textbox({
    Name = "Custom Tag ID",
    Callback = function(Value)
        tagId = tonumber(Value) or tagId
    end
})

tab:button({
    Name = "Minecraft Blocks",
    Description = "",
    Callback = function()
        if game.Players.LocalPlayer.Character ~= nil then
local mouse = game.Players.LocalPlayer:GetMouse()
tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Grass Block"
tool.Activated:connect(function()
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267183944, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267089525, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267183944, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267089525, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267183944, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267089525, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
    end
end)
tool.Parent = game.Players.LocalPlayer.Backpack
 
tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Oak Planks"
tool.Activated:connect(function()
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
    end
end)
tool.Parent = game.Players.LocalPlayer.Backpack
 
tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Cobblestone"
tool.Activated:connect(function()
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
    end
end)
tool.Parent = game.Players.LocalPlayer.Backpack
 
tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Stone"
tool.Activated:connect(function()
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
    end
end)
tool.Parent = game.Players.LocalPlayer.Backpack
 
tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Diamond Ore"
tool.Activated:connect(function()
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
    end
end)
tool.Parent = game.Players.LocalPlayer.Backpack
 
tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Diamond Block"
tool.Activated:connect(function()
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
    end
end)
tool.Parent = game.Players.LocalPlayer.Backpack
 
tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Lava"
tool.Activated:connect(function()
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
        local savepos = game.Players.LocalPlayer:GetMouse().Hit
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
local killpart = Instance.new("Part")
killpart.Name = "(Lava Visual Script) kill part"
killpart.Anchored = true
killpart.Size = Vector3.new(1, 1, 1)
killpart.Color = Color3.new(255, 0, 0)
killpart.Transparency = 0.5
killpart.CanCollide = false
killpart.Parent = workspace:FindFirstChild("KillpartsVisual")
killpart.CFrame = savepos + Vector3.new(0, 1.75, 0)
wait(15)
killpart:Destroy()
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
        local savepos = game.Players.LocalPlayer:GetMouse().Hit
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
local killpart = Instance.new("Part")
killpart.Name = "(Lava Visual Script) kill part"
killpart.Anchored = true
killpart.Size = Vector3.new(1, 1, 1)
killpart.Color = Color3.new(255, 0, 0)
killpart.Transparency = 0.5
killpart.CanCollide = false
killpart.Parent = workspace:FindFirstChild("KillpartsVisual")
killpart.CFrame = savepos + Vector3.new(0, 1.75, 0)
wait(15)
killpart:Destroy()
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
    local savepos = game.Players.LocalPlayer:GetMouse().Hit
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Top, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Bottom, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Back, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Front, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Right, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Left, 3.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(savepos.Position) * CFrame.new(-1.65, 1.65, 0))
local killpart = Instance.new("Part")
killpart.Name = "(Lava Visual Script) kill part"
killpart.Anchored = true
killpart.Size = Vector3.new(1, 1, 1)
killpart.Color = Color3.new(255, 0, 0)
killpart.Transparency = 0.5
killpart.CanCollide = false
killpart.Parent = workspace:FindFirstChild("KillpartsVisual")
killpart.CFrame = savepos + Vector3.new(0, 1.75, 0)
wait(15)
killpart:Destroy()
end
end)
tool.Parent = game.Players.LocalPlayer.Backpack
end
    end,
})

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local defaultSprayId = 12781220539  -- Default spray ID for the block

local function giveTool()
    local player = Players.LocalPlayer
    local backpack = player.Backpack
    local character = player.Character
    local mouse = player:GetMouse()

    if character then
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "Custom Block"
        
        tool.Activated:Connect(function()
            local sprayPaint

            if backpack.Toys:FindFirstChild("SprayPaint") then
                ReplicatedStorage.Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
                ReplicatedStorage.Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
                sprayPaint = backpack:FindFirstChild("SprayPaint")
                if sprayPaint then
                    sprayPaint.Parent = character
                end
            elseif backpack:FindFirstChild("SprayPaint") then
                sprayPaint = backpack.SprayPaint
                sprayPaint.Parent = character
            elseif character:FindFirstChild("SprayPaint") then
                sprayPaint = character.SprayPaint
            end

            if sprayPaint then
                local hitPos = mouse.Hit.Position
                local target = workspace.Lobby.VoteIcons.VotePad2
                sprayPaint.Remote:FireServer(defaultSprayId, Enum.NormalId.Top, 3.5, target, CFrame.new(hitPos) * CFrame.new(0, 3.3, 0))
                sprayPaint.Remote:FireServer(defaultSprayId, Enum.NormalId.Bottom, 3.5, target, CFrame.new(hitPos) * CFrame.new(0, 0, 0))
                sprayPaint.Remote:FireServer(defaultSprayId, Enum.NormalId.Back, 3.5, target, CFrame.new(hitPos) * CFrame.new(0, 1.65, 1.65))
                sprayPaint.Remote:FireServer(defaultSprayId, Enum.NormalId.Front, 3.5, target, CFrame.new(hitPos) * CFrame.new(0, 1.65, -1.65))
                sprayPaint.Remote:FireServer(defaultSprayId, Enum.NormalId.Right, 3.5, target, CFrame.new(hitPos) * CFrame.new(1.65, 1.65, 0))
                sprayPaint.Remote:FireServer(defaultSprayId, Enum.NormalId.Left, 3.5, target, CFrame.new(hitPos) * CFrame.new(-1.65, 1.65, 0))
                sprayPaint.Parent = backpack
            end
        end)

        tool.Parent = backpack
    end
end

local function removeTool()
    local player = Players.LocalPlayer
    local backpack = player.Backpack
    local character = player.Character

    local tool = backpack:FindFirstChild("Custom Block") or character:FindFirstChild("Custom Block")
    if tool then
        tool:Destroy()
    end
end

local toggleEnabled = false

tab:toggle({
    Name = "Block",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(Value)
        toggleEnabled = Value
        if Value then
            giveTool()
        else
            removeTool()
        end
    end,
})

local debounce = false
Players.LocalPlayer.CharacterAdded:Connect(function(character)
    if toggleEnabled and not debounce then
        debounce = true
        -- Wait for character to load properly
        character:WaitForChild("HumanoidRootPart")
        giveTool()
        debounce = false
    end
end)

tab:textbox({
    Name = "Custom Block ID",
    Callback = function(Value)
        defaultSprayId = tonumber(Value) or defaultSprayId
    end
})

local Players = game:GetService("Players")
local boxId = 60484593

local function boxsprayOnPlayer(target)
    local localPlayer = Players.LocalPlayer
    if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local humanoidRootPart = target.Character.HumanoidRootPart

    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Top, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 3, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Bottom, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Bottom, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Top, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -3, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Front, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Back, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Front, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Back, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Right, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Left, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Right, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Left, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
end

local boxsprayLoop = false

tab:toggle({
    Name = "Box",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(Value)
        if Value then
            boxsprayLoop = true
            while boxsprayLoop do
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player ~= Players.LocalPlayer then -- Skip executing the function on yourself
                            boxsprayOnPlayer(player)
                            task.wait()
                        end
                    end
                else
                    local targetPlayer = findPlayerByName(infinityGauntlet)
                    if targetPlayer then
                        boxsprayOnPlayer(targetPlayer)
                    else
                        print("Player not found.")
                    end
                end
                task.wait(15)
            end
        else
            boxsprayLoop = false
        end
    end
})

tab:textbox({
    Name = "Custom Box ID",
    Callback = function(Value)
        boxId = tonumber(Value) or boxId
    end
})




local tab = gui:tab{
    Icon = "rbxassetid://17652717888",
    Name = "Trade"
}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local isLooping = false
local tradetargetUser = ""

local function SendTradeRequestToPlayer(tradetargetUser)
    local targetPlayer = Players:FindFirstChild(tradetargetUser)

    if targetPlayer then
        local tradeSendRequest = ReplicatedStorage:WaitForChild("Trade"):WaitForChild("SendRequest")
        local tradeAcceptRequest = ReplicatedStorage:WaitForChild("Trade"):WaitForChild("AcceptRequest")

        tradeSendRequest:InvokeServer(targetPlayer)
        tradeAcceptRequest:FireServer()
    else
        warn("Player not found:", tradetargetUser)
    end
end

tab:textbox({
    Name = "Target User",
    Description = "",
    Callback = function(Value)
        tradetargetUser = Value
    end
})

tab:button({
    Name = "Force Trade",
    Description = "only spams the request only for now",
    Callback = function()
        if tradetargetUser ~= "" then
            SendTradeRequestToPlayer(tradetargetUser)
        else
            print("Please enter a valid player name.")
        end
    end,
})

local function ToggleLoop()
    while isLooping do
        if tradetargetUser ~= "" then
            SendTradeRequestToPlayer(tradetargetUser)
        else
            print("Please enter a valid player name.")
            break
        end
        wait(0) -- Adjust the delay as needed
    end
end

tab:toggle({
    Name = "Loop Trade",
    StartingState = false,
    Description = "only spams the request only for now",
    Callback = function(Value)
        isLooping = Value
        if isLooping then
            ToggleLoop()
        end
    end,
})

local player = game.Players.LocalPlayer

-- Variable to store TradeGUI reference
local savedTradeGUI = nil

-- Function to remove TradeGUI
local function removeTradeGUI()
    -- Find the TradeGUI in the player's PlayerGui
    local tradeGUI = player.PlayerGui:FindFirstChild("TradeGUI")

    -- Check if the TradeGUI exists
    if tradeGUI then
        -- Save a reference to TradeGUI
        savedTradeGUI = tradeGUI

        -- Hide the TradeGUI
        tradeGUI.Parent = nil
        print("TradeGUI removed successfully!")
    else
        print("TradeGUI not found.")
    end
end

-- Function to restore TradeGUI
local function restoreTradeGUI()
    -- Check if there's a saved reference to TradeGUI
    if savedTradeGUI then
        -- Restore TradeGUI
        savedTradeGUI.Parent = player.PlayerGui
        print("TradeGUI restored successfully!")
    else
        print("No TradeGUI to restore.")
    end
end

tab:toggle({
    Name = "Remove Trade GUI",
		StartingState = false,
		Description = "",
		Callback = function(val)
   if val then
        -- Call the function to remove TradeGUI
        removeTradeGUI()
    else
        -- Call the function to restore TradeGUI
        restoreTradeGUI()
    end
end,})







local tab = gui:tab{
    Icon = "rbxassetid://17652719752",
    Name = "Decals"
}

tab:button({
    Name = "Vindicate Decal Library",
    Description = "",
    Callback = function()
-- Create a ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "MyGUI"
gui.ResetOnSpawn = false
gui.Parent = game.Players.LocalPlayer.PlayerGui

-- Check if the device is a mobile device
local isMobileDevice = game:GetService("UserInputService").TouchEnabled

-- Define the initial size of the GUI for desktop devices
local initialSize = isMobileDevice and UDim2.new(0.9, 0, 0.9, 0) or UDim2.new(0.457, 0, 0.6, 0)

-- Create the main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = initialSize -- Adjust size for mobile devices
mainFrame.Position = UDim2.new(0.5, -mainFrame.Size.X.Offset / 2, 0.5, -mainFrame.Size.Y.Offset / 2) -- Center the frame
mainFrame.BackgroundColor3 = Color3.fromRGB(10,23,39,255) -- Dark blue background
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Enable dragging
mainFrame.Parent = gui

-- Add UICorner to the main frame
local mainFrameCorner = Instance.new("UICorner")
mainFrameCorner.CornerRadius = UDim.new(0, 10)
mainFrameCorner.Parent = mainFrame

-- Create a close button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30) -- Adjust size as needed
closeButton.Position = UDim2.new(1, -40, 0, 10) -- Adjust position as needed
closeButton.BackgroundColor3 = Color3.fromRGB(28,156,148) -- Red color
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamSemibold -- Change font
closeButton.TextSize = 18 -- Adjust text size
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White color
closeButton.Parent = mainFrame

-- Add UICorner to the close button
local closeButtonCorner = Instance.new("UICorner")
closeButtonCorner.CornerRadius = UDim.new(0.2, 0) -- Make it a square button
closeButtonCorner.Parent = closeButton

-- Function to close the GUI when the close button is clicked
closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Adjust GUI size and position for mobile devices
if isMobileDevice then
    mainFrame.Size = UDim2.new(0.9, 0, 0.9, 0)
    mainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
end

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 0, 30) -- Adjust size as needed
minimizeButton.Position = UDim2.new(1, -80, 0, 10) -- Adjust position as needed
minimizeButton.BackgroundColor3 = Color3.fromRGB(28,156,148) -- Green color
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "-"
minimizeButton.Font = Enum.Font.GothamSemibold -- Change font
minimizeButton.TextSize = 18 -- Adjust text size
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White color
minimizeButton.Parent = mainFrame

-- Add UICorner to the minimize button
local minimizeButtonCorner = Instance.new("UICorner")
minimizeButtonCorner.CornerRadius = UDim.new(0.2, 0) -- Make it a square button
minimizeButtonCorner.Parent = minimizeButton

-- Create a draggable button representing the minimized state
local minimizedButton = Instance.new("TextButton")
minimizedButton.Name = "MinimizedButton"
minimizedButton.Size = UDim2.new(0, 30, 0, 30) -- Adjust size as needed
minimizedButton.Position = UDim2.new(1, -1431, 0, -31) -- Adjust position as needed
minimizedButton.BackgroundColor3 = Color3.fromRGB(28,156,148) -- Green color
minimizedButton.BorderSizePixel = 0
minimizedButton.Text = "-"
minimizedButton.Font = Enum.Font.GothamSemibold -- Change font
minimizedButton.TextSize = 18 -- Adjust text size
minimizedButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White color
minimizedButton.Visible = false -- Initially invisible
minimizedButton.Parent = gui

-- Add UICorner to the minimized button
local minimizedButtonCorner = Instance.new("UICorner")
minimizedButtonCorner.CornerRadius = UDim.new(0.2, 0) -- Round corners
minimizedButtonCorner.Parent = minimizedButton

-- Function to minimize the GUI when the minimize button is clicked
minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    minimizedButton.Visible = not minimizedButton.Visible
end)

-- Function to maximize the GUI when the minimized button is clicked
minimizedButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    minimizedButton.Visible = not minimizedButton.Visible
end)

-- Create a search bar
local searchBar = Instance.new("TextBox")
searchBar.Name = "SearchBar"
searchBar.Size = UDim2.new(0.257, 0, 0, 30) -- Adjust size as needed
searchBar.Position = UDim2.new(0.02, 0, 0, 10) -- Adjust position as needed
searchBar.PlaceholderText = "Search by title..."
searchBar.Font = Enum.Font.Gotham
searchBar.TextSize = 14
searchBar.BackgroundTransparency = 0.5
searchBar.BackgroundColor3 = Color3.fromRGB(21,40,57,255) -- Dark background color
searchBar.BorderSizePixel = 0
searchBar.TextColor3 = Color3.fromRGB(255, 255, 255) -- Text color
searchBar.PlaceholderColor3 = Color3.fromRGB(150, 150, 150) -- Placeholder text color
searchBar.ClearTextOnFocus = false
searchBar.Text = ""  -- Remove default "textbox" text
searchBar.Parent = mainFrame

-- Add UICorner to the search bar
local searchBarCorner = Instance.new("UICorner")
searchBarCorner.CornerRadius = UDim.new(0, 5)
searchBarCorner.Parent = searchBar

-- Create a text box next to the search bar
local initialInfoText = "https://create.roblox.com/store/images" -- Initial text content
local infoBox = Instance.new("TextBox")
infoBox.Name = "InfoBox"
infoBox.Size = UDim2.new(0.357, 0, 0, 30) -- Adjust size as needed
infoBox.Position = UDim2.new(0.29, 0, 0, 10) -- Adjust position as needed
infoBox.Text = initialInfoText -- Set the initial text content
infoBox.Font = Enum.Font.Gotham
infoBox.TextSize = 14
infoBox.BackgroundTransparency = 0.5
infoBox.BackgroundColor3 = Color3.fromRGB(21,40,57,255) -- Dark background color
infoBox.BorderSizePixel = 0
infoBox.TextColor3 = Color3.fromRGB(255, 255, 255) -- Text color
infoBox.ClearTextOnFocus = false -- Allow editing without clearing text
infoBox.Parent = mainFrame

-- Add UICorner to the info box
local infoBoxCorner = Instance.new("UICorner")
infoBoxCorner.CornerRadius = UDim.new(0, 5)
infoBoxCorner.Parent = infoBox

-- Store the initial text
local currentInfoText = initialInfoText

-- Reset the text if no new text was entered
infoBox.FocusLost:Connect(function(enterPressed)
    if not enterPressed then
        if infoBox.Text == "" or infoBox.Text:len() < currentInfoText:len() then
            infoBox.Text = initialInfoText -- Restore initial text
        else
            currentInfoText = infoBox.Text -- Update current text
        end
    end
end)

-- Create a scrolling frame to contain the decal previews
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, 0, 1, -90) -- Adjust size as needed
scrollFrame.Position = UDim2.new(0, 0, 0, 50) -- Adjust position as needed
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 10
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Initialize CanvasSize
scrollFrame.Parent = mainFrame

-- Add UICorner to the scrolling frame
local scrollFrameCorner = Instance.new("UICorner")
scrollFrameCorner.CornerRadius = UDim.new(0, 10)
scrollFrameCorner.Parent = scrollFrame

-- Function to create decal previews in five columns
local function createDecalPreview(title, decalID, position, textboxPosition)
    local decalPreview = Instance.new("ImageLabel")
    decalPreview.Name = "DecalPreview"
    decalPreview.Size = UDim2.new(0, 120, 0, 120) -- Adjust size as needed
    decalPreview.Position = position
    decalPreview.BackgroundTransparency = 1
    decalPreview.Image = "rbxthumb://type=Asset&id=" .. decalID .. "&w=150&h=150"
    decalPreview.Parent = scrollFrame
    
    -- Create title for decal preview
    local titleTextBox = Instance.new("TextBox")
    titleTextBox.Name = "TitleTextBox"
    titleTextBox.Size = UDim2.new(0, 120, 0, 20) -- Adjust size as needed
    titleTextBox.Position = position + UDim2.new(0, 0, 0, 130) -- Position below decal preview
    titleTextBox.BackgroundColor3 = Color3.fromRGB(21,40,57,255) -- Darker blue background
    titleTextBox.BorderSizePixel = 0
    titleTextBox.Text = title
    titleTextBox.Font = Enum.Font.Gotham
    titleTextBox.TextSize = 12
    titleTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleTextBox.ClearTextOnFocus = false
    titleTextBox.TextEditable = false
    titleTextBox.Parent = scrollFrame
    
    -- Create textbox for decal ID
    local decalIDTextBox = Instance.new("TextBox")
    decalIDTextBox.Name = "DecalIDTextBox"
    decalIDTextBox.Size = UDim2.new(0, 120, 0, 20) -- Adjust size as needed
    decalIDTextBox.Position = textboxPosition
    decalIDTextBox.BackgroundColor3 = Color3.fromRGB(21,40,57,255) -- Darker blue background
    decalIDTextBox.BorderSizePixel = 0
    decalIDTextBox.Text = decalID
    decalIDTextBox.Font = Enum.Font.Gotham
    decalIDTextBox.TextSize = 12
    decalIDTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    decalIDTextBox.ClearTextOnFocus = false
    decalIDTextBox.TextEditable = true
    decalIDTextBox.Parent = scrollFrame
    
    -- Reset the text when the user clicks off
    decalIDTextBox.FocusLost:Connect(function(enterPressed)
        if not enterPressed then
            decalIDTextBox.Text = decalID
        end
    end)
    
    return decalPreview, titleTextBox, decalIDTextBox
end

-- Define custom titles and decal IDs (replace these with your own)
local decalPreviews = {
    {title = "Vindicate Logo", id = 17646580928},
    {title = "White Glue", id = 14976845153},
    {title = "Communism", id = 6978648716},
    {title = "Face 1", id = 12579922286},
    {title = "Troll Face", id = 10193511157},
    {title = "Spongebob 1", id = 16989882575},
    {title = "Spongebob 2", id = 17282019822},
    {title = "Spongebob 3", id = 17373315144},
    {title = "Spongebob 4", id = 17373265789},
    {title = "Rickroll", id = 10180722469},
    {title = "LOL Emoji", id = 12877195347},
    {title = "Spongebob 5", id = 17438371258},
    {title = "Crimson Chin", id = 17438415353},
    {title = "Let It Rip", id = 17438452253},
    {title = "Read The Sign!", id = 17438524420},
    {title = "Painful BJ", id = 17438554754},
    {title = "Behind", id = 17438582165},
    {title = "The Limit", id = 17438725283},
    {title = "Face Cream", id = 17438743086},
    {title = "Lets See", id = 17438762668},
    {title = "Tom's Third Leg", id = 17438844825},
    {title = "The D", id = 17438798519},
    {title = "Banana", id = 17438867266},
    {title = "Pussy Cat", id = 17438909157},
    {title = "Oh Boobies", id = 17438927790},
    {title = "Jerk It Off", id = 17438949273},
    {title = "One Piece", id = 10299570904},
    {title = "Just Right", id = 10205747078},
    {title = "Handsome Squid", id = 10193687436},
    {title = "Relief", id = 10193531276},
    {title = "Face 2", id = 12579900291},
    {title = "Face 3", id = 15219559821},
    {title = "c:", id = 7465254044},
    {title = "Tubers Logo", id = 9907765074},
    {title = "Join Team c00lkidd", id = 10459746711},
    {title = "c00lkidd", id = 178993746},
    {title = "Tubers93", id = 8874768843},
    {title = "John Doe", id = 699424744},
    {title = "1x1x1x1x1x1x", id = 692393285},
    {title = "Mario.EXE", id = 12851404506},
    {title = "Face 4", id = 12736544405},
    {title = "Face 5", id = 7454933287},
    {title = "Ayo Mario?", id = 16619718377},
    {title = "Evil Luigi", id = 15332431542},
    {title = "No Bitches?", id = 13876396989},
    {title = "Megamind Poster", id = 11798557844},
    {title = "Ro-Germany", id = 16226442933},
    {title = "Red", id = 14033250886},
    {title = "Blue", id = 8154063596},
    {title = "Yellow", id = 10528731267},
    {title = "Green", id = 11774113785},
    {title = "Purple", id = 11301128092},
    {title = "Orange", id = 15207891724},
    {title = "Black", id = 12781220539},
    {title = "White", id = 1343642734},
    {title = "Pink", id = 16496874190},
    {title = "MC Grass", id = 8676495068},
    {title = "MC Books", id = 10300825416},
    {title = "MC Furnace", id = 13711805173},
    {title = "MC Trap Door", id = 15420292685},
    {title = "MC Slab", id = 15351020063},
    {title = "MC Acacia Trap Door", id = 15420298036},
    {title = "MC Sand", id = 12624140912},
    {title = "MC Leaves", id = 14645147330},
    {title = "MC Coal", id = 8677286071},
    {title = "MC Water", id = 11462074138},
    {title = "MC Rail", id = 11462107403},
    {title = "MC Iron Bars", id = 11969908493},
    {title = "MC Wood Plank", id = 12470614353},
    {title = "MC Dirt", id = 8275209676},
    {title = "MC Wood", id = 12470609302},
    {title = "MC Red Sand", id = 9228568618},
    {title = "MC Luck Block", id = 8277401598},
    {title = "MC Blue Coral", id = 9246085914},
    {title = "MC Berch Plank", id = 8678670358},
    {title = "MC Emerald", id = 11425725303},
    {title = "MC Iron Ore", id = 11425626932},
    {title = "MC Stone Brick", id = 8139086786},
    {title = "MC Glass", id = 11384458786},
    {title = "MC No Texture", id = 6718522761},
    {title = "MC Magma", id = 9065431121},
    {title = "MC Smooth Stone", id = 16772274014},
    {title = "MC Red Stone", id = 8677288287},
    {title = "MC Gold", id = 14934313210},
    {title = "MC Netherite", id = 7696392991},
    {title = "MC Cactus", id = 12624066636},
    {title = "MC Brick", id = 13017216630},
    {title = "MC Diamond", id = 8677289930},
    {title = "MC Dark Oak Planks", id = 9359133333},
    {title = "MC Stone", id = 8676746456},
    {title = "MC Ancient Debris", id = 8677283985},
    {title = "MC Soul Fire", id = 14792109788},
    {title = "MC Gold Ore", id = 7700990575},
    {title = "MC Crimson Planks", id = 8678673036},
    {title = "MC Oak Leaves", id = 12193465277},
    {title = "MC Powered Rails", id = 14934357535},
    {title = "MC Jungle Planks", id = 8678671179},
    {title = "MC Portal Frame", id = 11547423217},
    {title = "MC Obsidian", id = 11547302037},
    {title = "MC Cobblestone", id = 16772476247},
    {title = "MC Sculk", id = 15060374471},
    {title = "MC Note", id = 4743573805},
    {title = "MC Wheat", id = 13991128555},
    {title = "MC Ladder", id = 5386752779},
    {title = "MC Command", id = 129804021},
    {title = "MC Sugar Cane", id = 16236855983},
    {title = "MC Lapis", id = 7701274352},
    {title = "MC Iron", id = 8677286764},
    {title = "MC Spruce Plank", id = 8187648618},
    {title = "Ducktator", id = 17451271391},
    {title = "Ducktator 2", id = 17451375987},
    {title = "911", id = 17451619370},
    {title = "Children", id = 17463173102},
    {title = "Cummed and Hard", id = 17463212151},
    {title = "Sex Xray", id = 17497414733},
    {title = "Sex Xray 2", id = 17502366819},
    {title = "Stare 1", id = 17502530604},
    {title = "Stare 2", id = 17502535333},
    {title = "Stare 3", id = 17502563934},
    {title = "Child Monster", id = 17502568283},
    {title = "Stare 4", id = 17502572368},
    {title = "Stare 5", id = 17502555059},
    {title = "Stare 6", id = 17502580513},
    {title = "Chad 1", id = 17502583906},
    {title = "Chad 2", id = 17502589015},
    {title = "Pull IP 1", id = 17513611697},
    {title = "Pull IP 2", id = 17513632877},
    {title = "Pull IP 3", id = 17513630647},
    {title = "Pull IP 4", id = 17513627851},
    {title = "Pull IP 5", id = 17513625936},
    {title = "Pull IP 6", id = 17513623126},
    {title = "Pull IP 7", id = 17513620257},
    {title = "Sexy Plane", id = 17513719124},
    {title = "Child Kidnap", id = 17513731834},
    {title = "Boobies", id = 17513764092},
    {title = "Boobies 2", id = 17513801336},
    {title = "Boobies 3", id = 17513815332},
    {title = "Boobies 4", id = 17513821294},
    {title = "Funny", id = 16091268969},
    {title = "Down Bad?", id = 15767539260},
    {title = "Rickroll 2", id = 6403436082},
    {title = "Lie Detector", id = 15729969509},
    {title = "Buy a Divorce", id = 11523857626},
    {title = "Man Face", id = 13567539328},
    {title = "Laughing Cat", id = 16541142630},
    {title = "Caution", id = 12249128463},
    {title = "Troll Face 2", id = 14916455451},
    {title = "Bugs Under Skin", id = 10143789369},
    {title = "Glitched", id = 3128134660},
    {title = "Microsoft", id = 4551501098},
    {title = "Glizzy Time", id = 14453899460},
    {title = "One Piece 2", id = 10511856020},
    {title = "Sheesh!", id = 6685768782},
    {title = "Reverse", id = 13878717225},
    {title = "Skip", id = 14729518032},
    {title = "Plus 4", id = 11138597404},
    {title = "Plus 99", id = 12898314499},
    {title = "Plus Infinity", id = 3295477138},
    {title = "Mario Brick", id = 14220229900},
    {title = "Mario Block", id = 459786689},
    {title = "Mario ? Block", id = 1296074947},
    {title = "Mario ? Block 2", id = 16048693087},
    {title = "Mario ? Block 3", id = 237446655},
    {title = "Mario Ground Block", id = 14220047500},
    {title = "Mario Twitch Block", id = 7626103667},
    {title = "Mario Youtube Block", id = 7626107872},
    {title = "Roblox Logo", id = 2175089032},
    {title = "Roblox Logo 2", id = 14446847395},
    {title = "Roblox Logo 3", id = 845359308},
    {title = "Dab", id = 1104294760},
    {title = "Oh My GYATT", id = 15724216964},
    {title = "Certified Rizz", id = 17156009318},
    {title = "Mid", id = 15147793496},
    {title = "Sexy Xray", id = 17559259734},

}

-- Create decal previews with custom titles
local posX = 10
local posY = 10
local columnCount = 0
local decalPreviewElements = {} -- Store decal preview elements for manipulation
for _, preview in ipairs(decalPreviews) do
    local decalPreview, titleTextBox, decalIDTextBox = createDecalPreview(preview.title, preview.id, UDim2.new(0, posX, 0, posY), UDim2.new(0, posX, 0, posY + 150))
    table.insert(decalPreviewElements, {DecalPreview = decalPreview, TitleTextBox = titleTextBox, DecalIDTextBox = decalIDTextBox})
    columnCount = columnCount + 1
    if columnCount == 5 then
        columnCount = 0
        posX = 10
        posY = posY + 170
    else
        posX = posX + 130
    end
end

-- Update the CanvasSize of the scrollFrame
local totalRows = math.ceil(#decalPreviews / 5)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalRows * 190)

-- Function to filter and reorder decal previews based on search query
local function filterDecalPreviews(query)
    local foundPreviews = {} -- Store the found previews
    for _, element in ipairs(decalPreviewElements) do
        local title = string.lower(element.TitleTextBox.Text)
        if string.find(title, query) then
            element.DecalPreview.Visible = true
            element.TitleTextBox.Visible = true
            element.DecalIDTextBox.Visible = true
            table.insert(foundPreviews, element)
        else
            element.DecalPreview.Visible = false
            element.TitleTextBox.Visible = false
            element.DecalIDTextBox.Visible = false
        end
    end
    
    -- Reorder previews to bring the found ones to the front
    for i, foundPreview in ipairs(foundPreviews) do
        local index = table.find(decalPreviewElements, foundPreview)
        if index then
            table.remove(decalPreviewElements, index)
            table.insert(decalPreviewElements, i, foundPreview)
        end
    end
    
    -- Reposition previews to maintain column arrangement
    local posX = 10
    local posY = 10
    for i, element in ipairs(decalPreviewElements) do
        element.DecalPreview.Position = UDim2.new(0, posX, 0, posY)
        element.TitleTextBox.Position = UDim2.new(0, posX, 0, posY + 130)
        element.DecalIDTextBox.Position = UDim2.new(0, posX, 0, posY + 160) -- Adjust vertical spacing
        if i % 5 == 0 then
            posX = 10
            posY = posY + 190
        else
            posX = posX + 138
        end
    end
end

-- Connect search functionality to the search bar
searchBar.Changed:Connect(function()
    local query = string.lower(searchBar.Text)
    filterDecalPreviews(query)
end)

local dragging
local dragStartOffset

-- Function to handle manual dragging
local function startDrag(input)
    local initialPosition = input.Position
    local initialGuiPosition = gui.Position
    dragStartOffset = initialPosition - initialGuiPosition
    dragging = true
end

local function updateDrag(input)
    if dragging then
        local newPosition = input.Position - dragStartOffset
        gui.Position = UDim2.new(0, newPosition.X, 0, newPosition.Y)
    end
end

local function endDrag()
    dragging = false
end

-- Connect manual drag functions to mouse input events
gui.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        startDrag(input)
    end
end)

gui.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        updateDrag(input)
    end
end)

gui.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        endDrag()
    end
end)

    end,
})









local tab = gui:tab{
    Icon = "rbxassetid://17629022447",
    Name = "Misc"
}

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
