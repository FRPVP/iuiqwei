 local Sound = Instance.new("Sound",game:GetService("SoundService"))
 Sound.SoundId = "rbxassetid://9120129807"
 Sound:Play()

local ModerkaLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/ttwizz/Roblox/master/ModerkaLibrary.lua", true))()


-- Creating a Window

local Window = ModerkaLibrary:AddWindow("Vindicate")

local Page = Window:AddPage("Player")

local Toggle = Page:AddToggle("Inf Jump", false, function(Value)
if Value then
InfJump = game:GetService("UserInputService").JumpRequest:connect(function()
if Value then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
		end
end)
else
InfJump:Disconnect()
end
end)

local Button = Page:AddButton("Play Dead", function()
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
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Store the current walk speed value
local currentWalkSpeed = 16

local Slider = Page:AddSlider("Walk Speed", {
    Minimum = 16,  -- Assuming walk speed should not go below 16
    Maximum = 300,  -- Assuming maximum walk speed as 300
    Default = currentWalkSpeed  -- Initial walk speed value
}, function(Value)
    -- Update the walk speed whenever the slider value changes
    currentWalkSpeed = Value
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
    print("Slider value changed:", Value)
end)

-- Function to set the walk speed
local function setWalkSpeed()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = currentWalkSpeed
    end
end

-- Connect CharacterAdded event to reapply walk speed on respawn
LocalPlayer.CharacterAdded:Connect(function()
    -- Wait for the character to be fully loaded
    local character = LocalPlayer.Character
    if character then
        character:WaitForChild("Humanoid")
        setWalkSpeed()
    end
end)

-- Set initial walk speed value
setWalkSpeed()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Store the current jump power value
local currentJumpPower = 50

local Slider = Page:AddSlider("Jump Power", {
    Minimum = 50,  -- Minimum jump power
    Maximum = 300,  -- Maximum jump power
    Default = currentJumpPower  -- Initial jump power value
}, function(Value)
    -- Update the jump power whenever the slider value changes
    currentJumpPower = Value
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = Value
    end
    print("Slider value changed:", Value)
end)

-- Function to set the jump power
local function setJumpPower()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = currentJumpPower
    end
end

-- Connect CharacterAdded event to reapply jump power on respawn
LocalPlayer.CharacterAdded:Connect(function()
    -- Wait for the character to be fully loaded
    local character = LocalPlayer.Character
    if character then
        character:WaitForChild("Humanoid")
        setJumpPower()
    end
end)

-- Set initial jump power value
setJumpPower()

local Toggle = Page:AddToggle("Noclip", false, function(Value)
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
end)

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

local Toggle = Page:AddToggle("Fly", false, function(Value)
    flying = Value
    if flying then
        fly()
    end
end)

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

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Store the current fly speed value
local currentFlySpeed = 40

local Slider = Page:AddSlider("Fly Speed", {
    Minimum = 40,  -- Minimum fly speed
    Maximum = 200,  -- Maximum fly speed
    Default = currentFlySpeed  -- Initial fly speed value
}, function(Value)
    -- Update the fly speed whenever the slider value changes
    currentFlySpeed = Value
    flyspeed = currentFlySpeed  -- Update flyspeed variable
    print("Fly speed changed:", Value)
end)

-- Function to set the fly speed
local function setFlySpeed()
    -- Check if the LocalPlayer has a Humanoid
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        -- Set the fly speed
        flyspeed = currentFlySpeed  -- Update flyspeed variable
    end
end

-- Connect CharacterAdded event to reapply fly speed on respawn
LocalPlayer.CharacterAdded:Connect(function()
    -- Wait for the character to be fully loaded
    local character = LocalPlayer.Character
    if character then
        character:WaitForChild("Humanoid")
        setFlySpeed()
    end
end)

-- Set initial fly speed value
setFlySpeed()

local Toggle = Page:AddToggle("Click TP", false, function(Value)
Toggle = Value

      local player = game.Players.LocalPlayer
      local mouse = player:GetMouse()

      local function Teleport()
         if Toggle and mouse.Target then
            player.Character.HumanoidRootPart.CFrame = mouse.Hit
         end
      end

      mouse.Button1Down:Connect(Teleport)
end)

local Toggle = Page:AddToggle("Remove Kill Barriers", false, function(val)
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
end)










local Page = Window:AddPage("Visual")

getgenv().BetterESP = false -- Initialize BetterESP
local Toggle = Page:AddToggle("Player ESP", false, function(val)
    getgenv().BetterESP = val
end)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local roles

-- > Functions <--

function CreateBillboard() -- create billboards for new players
    for i, v in pairs(Players:GetChildren()) do
        if v ~= LP and v.Character then
            local role = GetPlayerRole(v.Name)
            
            if role and (role == "Innocent" or role == "Murderer" or role == "Sheriff" or role == "Hero") then
                if not v.Character:FindFirstChild("Billboard") then
                    local billboard = Instance.new("BillboardGui", v.Character)
                    billboard.Name = "Billboard"
                    billboard.AlwaysOnTop = true
                    billboard.Size = UDim2.new(0, 200, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.Adornee = v.Character:FindFirstChild("Head") -- Adornee should be set to the head for proper positioning
                    
                    local nameLabel = Instance.new("TextLabel", billboard)
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.Text = v.Name
                    nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    nameLabel.TextStrokeTransparency = 0.5
                    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
                    nameLabel.BackgroundTransparency = 1 -- Make the background (billboard) transparent
                end
            else
                local billboard = v.Character:FindFirstChild("Billboard")
                if billboard then
                    billboard:Destroy()
                end
            end
        end
    end
end

function UpdateBillboards() -- Update billboard colors based on roles
    for _, v in pairs(Players:GetChildren()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("Billboard") then
            local billboard = v.Character:FindFirstChild("Billboard")
            local nameLabel = billboard:FindFirstChild("TextLabel")
            
            local role = GetPlayerRole(v.Name)
            
            if IsAlive(v) then
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

function IsAlive(Player) -- Simple sexy function
    for i, v in pairs(roles) do
        if Player.Name == i then
            if not v.Killed and not v.Dead then
                return true
            else
                return false
            end
        end
    end
end

function GetPlayerRole(playerName)
    for i, v in pairs(roles) do
        if i == playerName then
            return v.Role
        end
    end
    return nil
end

-- Loops --

RunService.RenderStepped:Connect(function()
    roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    
    if getgenv().BetterESP then
        CreateBillboard()
        UpdateBillboards()
    else
        for _, v in pairs(Players:GetChildren()) do
            if v ~= LP and v.Character and v.Character:FindFirstChild("Billboard") then
                local billboard = v.Character:FindFirstChild("Billboard")
                billboard:Destroy()
            end
        end
    end
end)

local Toggle = Page:AddToggle("Player Highlight", false, function(val)
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
end)

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
    TextLabel.TextColor3 = Color3.fromRGB(0,214,0,255)
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

local Toggle = Page:AddToggle("Gun ESP", false, ToggleChanged)

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
