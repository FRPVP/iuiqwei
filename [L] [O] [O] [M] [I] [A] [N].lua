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
    Max = 60,
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





local tab = gui:tab{
    Icon = "rbxassetid://18146267134",
    Name = "Loomian Legacy"
}

local Transparency = true -- Will make you slightly transparent when you are invisible. No reason to disable.
local NoClip = false -- Will make your fake character no clip.
local Player = game:GetService("Players").LocalPlayer
local RealCharacter = Player.Character or Player.CharacterAdded:Wait()

local IsInvisible = false

RealCharacter.Archivable = true
local FakeCharacter = RealCharacter:Clone()
local Part = Instance.new("Part", workspace)
Part.Anchored = true
Part.Size = Vector3.new(200, 1, 200)
Part.CFrame = CFrame.new(9999, 9999, 9999) -- Set this to whatever you want, just far away from the map.
Part.CanCollide = true
FakeCharacter.Parent = workspace
FakeCharacter.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 5, 0)

for _, v in pairs(RealCharacter:GetChildren()) do
    if v:IsA("LocalScript") then
        local clone = v:Clone()
        clone.Disabled = true
        clone.Parent = FakeCharacter
    end
end

if Transparency then
    for _, v in pairs(FakeCharacter:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 1
        end
    end
end

local CanInvis = true

local function SetupFakeCharacter()
    CanInvis = false
    RealCharacter:Destroy()
    RealCharacter = Player.Character
    CanInvis = true
    IsInvisible = false
    FakeCharacter:Destroy()
    workspace.CurrentCamera.CameraSubject = RealCharacter.Humanoid

    RealCharacter.Archivable = true
    FakeCharacter = RealCharacter:Clone()
    Part:Destroy()
    Part = Instance.new("Part", workspace)
    Part.Anchored = true
    Part.Size = Vector3.new(200, 1, 200)
    Part.CFrame = CFrame.new(9999, 9999, 9999)
    Part.CanCollide = true
    FakeCharacter.Parent = workspace
    FakeCharacter.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 5, 0)

    for _, v in pairs(RealCharacter:GetChildren()) do
        if v:IsA("LocalScript") then
            local clone = v:Clone()
            clone.Disabled = true
            clone.Parent = FakeCharacter
        end
    end

    if Transparency then
        for _, v in pairs(FakeCharacter:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 1
            end
        end
    end

    RealCharacter.Humanoid.Died:Connect(function()
        RealCharacter:Destroy()
        FakeCharacter:Destroy()
    end)

    Player.CharacterAppearanceLoaded:Connect(SetupFakeCharacter)
end

RealCharacter.Humanoid.Died:Connect(function()
    RealCharacter:Destroy()
    FakeCharacter:Destroy()
end)

Player.CharacterAppearanceLoaded:Connect(SetupFakeCharacter)

local PseudoAnchor
game:GetService("RunService").RenderStepped:Connect(function()
    if PseudoAnchor then
        PseudoAnchor.CFrame = Part.CFrame * CFrame.new(0, 5, 0)
    end

    if NoClip then
        FakeCharacter.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    end
end)

PseudoAnchor = FakeCharacter.HumanoidRootPart

local function ToggleInvisibility()
    if IsInvisible == false then
        local StoredCF = RealCharacter.HumanoidRootPart.CFrame
        RealCharacter.HumanoidRootPart.CFrame = FakeCharacter.HumanoidRootPart.CFrame
        FakeCharacter.HumanoidRootPart.CFrame = StoredCF
        RealCharacter.Humanoid:UnequipTools()
        Player.Character = FakeCharacter
        workspace.CurrentCamera.CameraSubject = FakeCharacter.Humanoid
        PseudoAnchor = RealCharacter.HumanoidRootPart

        for _, v in pairs(FakeCharacter:GetChildren()) do
            if v:IsA("LocalScript") then
                v.Disabled = false
            end
        end

        IsInvisible = true
    else
        local StoredCF = FakeCharacter.HumanoidRootPart.CFrame
        FakeCharacter.HumanoidRootPart.CFrame = RealCharacter.HumanoidRootPart.CFrame
        RealCharacter.HumanoidRootPart.CFrame = StoredCF
        FakeCharacter.Humanoid:UnequipTools()
        Player.Character = RealCharacter
        workspace.CurrentCamera.CameraSubject = RealCharacter.Humanoid
        PseudoAnchor = FakeCharacter.HumanoidRootPart

        for _, v in pairs(FakeCharacter:GetChildren()) do
            if v:IsA("LocalScript") then
                v.Disabled = true
            end
        end

        IsInvisible = false
    end
end

-- Integration with the tab:toggle method
tab:toggle({
    Name = "Become Loomian",
    StartingState = false,
    Description = "You will become the loomian for everyone to see",
    Callback = function(Value)
        if CanInvis and RealCharacter and FakeCharacter then
            if RealCharacter:FindFirstChild("HumanoidRootPart") and FakeCharacter:FindFirstChild("HumanoidRootPart") then
                ToggleInvisibility()
            end
        end
    end,
})

tab:button({
    Name = "Break Loomian",
    Description = "Automatically breaks your loomian",
    Callback = function()
        -- Get the player's character
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Store the player's original position
local originalPosition = character.PrimaryPart.Position

-- Define the target position
local targetPosition = Vector3.new(751.7203369140625, -50000.160400390625, 3492.107421875)

-- Define the number of executions
local numExecutions = 10

-- Define the delay between each execution (in seconds)
local executionDelay = 0

-- Function to teleport the player to the target position
local function teleportToTarget()
    character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
end

-- Function to teleport the player back to their original position
local function teleportToOriginal()
    character:SetPrimaryPartCFrame(CFrame.new(originalPosition))
end

-- Function to freeze the character
local function freezeCharacter()
    character.PrimaryPart.Anchored = true
end

-- Function to unfreeze the character
local function unfreezeCharacter()
    character.PrimaryPart.Anchored = false
end

-- Execute the teleportation ten times with a delay between each execution
for i = 1, numExecutions do
    teleportToTarget()
    wait(executionDelay)
    teleportToOriginal()
    wait(executionDelay)
end

-- Create a countdown UI
local countdownGui = Instance.new("ScreenGui")
countdownGui.Name = "CountdownGui"
countdownGui.Parent = player:FindFirstChildOfClass("PlayerGui")

local executingText = Instance.new("TextLabel")
executingText.Name = "ExecutingText"
executingText.Size = UDim2.new(0, 200, 0, 50)
executingText.Position = UDim2.new(0.5, -100, 0.4, -290)
executingText.Parent = countdownGui
executingText.BackgroundColor3 = Color3.new(0, 0, 0)
executingText.BackgroundTransparency = 1 -- Adjust transparency here (0 is fully opaque, 1 is fully transparent)
executingText.TextColor3 = Color3.new(1, 1, 1)
executingText.TextSize = 50
executingText.Font = Enum.Font.SourceSansBold
executingText.TextStrokeColor3 = Color3.new(0, 0, 0)
executingText.TextStrokeTransparency = 0
executingText.Text = "Pls Wait..."

local countdownText = Instance.new("TextLabel")
countdownText.Name = "CountdownText"
countdownText.Size = UDim2.new(0, 200, 0, 100)
countdownText.Position = UDim2.new(0.5, -100, 0.5, -320)
countdownText.Parent = countdownGui
countdownText.BackgroundColor3 = Color3.new(0, 0, 0)
countdownText.BackgroundTransparency = 1 -- Adjust transparency here (0 is fully opaque, 1 is fully transparent)
countdownText.TextColor3 = Color3.new(1, 1, 1)
countdownText.TextSize = 50
countdownText.Font = Enum.Font.SourceSansBold
countdownText.TextStrokeColor3 = Color3.new(0, 0, 0)
countdownText.TextStrokeTransparency = 0

-- Countdown duration
local countdownDuration = 5 -- 5-second countdown

-- Freeze the character before starting the countdown
freezeCharacter()

for countdownValue = countdownDuration, 1, -1 do
    countdownText.Text = tostring(countdownValue)
    wait(1) -- Wait for 1 second
end

-- Unfreeze the character after the countdown
unfreezeCharacter()

-- Clean up the countdown GUI
countdownGui:Destroy()
    end,
})

local autoFarmRunning = false

tab:toggle({
    Name = "Route 1",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   autoFarmRunning = Value
        
        -- Check if the auto-farm is turned on or off
        if autoFarmRunning then
            -- Set the coordinates where you want the player to teleport
            local coordinates1 = Vector3.new(3.3425238132476807, 54.88100051879883, -177.1690673828125)
            local coordinates2 = Vector3.new(-5.3425238132476807, 54.88100051879883, -177.1690673828125)
            
            -- Set the delay between each teleport in seconds
            local teleportDelay = 0
            
            -- Get the player's character
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            
            -- Function to teleport the player to the specified coordinates
            local function teleportPlayer(position)
                character:SetPrimaryPartCFrame(CFrame.new(position))
            end
            
            -- Function to repeatedly teleport the player between the two coordinates
            local function teleportLoop()
                while autoFarmRunning do  -- Check if autoFarmRunning is true
                    teleportPlayer(coordinates1)
                    wait(teleportDelay)
                    teleportPlayer(coordinates2)
                    wait(teleportDelay)
                end
            end
            
            -- Start the teleport loop
            teleportLoop()
        end
end,})

tab:toggle({
    Name = "Gale Forest",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   autoFarmRunning = Value
        
        -- Check if the auto-farm is turned on or off
        if autoFarmRunning then
            -- Set the coordinates where you want the player to teleport
            local coordinates1 = Vector3.new(-440.79705810546875, 105.60586547851562, -1145.4281005859375)
	    local coordinates2 = Vector3.new(-445.79705810546875, 105.60586547851562, -1145.4281005859375)
            
            -- Set the delay between each teleport in seconds
            local teleportDelay = 0
            
            -- Get the player's character
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            
            -- Function to teleport the player to the specified coordinates
            local function teleportPlayer(position)
                character:SetPrimaryPartCFrame(CFrame.new(position))
            end
            
            -- Function to repeatedly teleport the player between the two coordinates
            local function teleportLoop()
                while autoFarmRunning do  -- Check if autoFarmRunning is true
                    teleportPlayer(coordinates1)
                    wait(teleportDelay)
                    teleportPlayer(coordinates2)
                    wait(teleportDelay)
                end
            end
            
            -- Start the teleport loop
            teleportLoop()
        end
end,})

tab:toggle({
    Name = "Route 3",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   autoFarmRunning = Value
        
        -- Check if the auto-farm is turned on or off
        if autoFarmRunning then
            -- Set the coordinates where you want the player to teleport
            local coordinates1 = Vector3.new(-1279.0032958984375, 103.20599365234375, -422.75982666015625)
	    local coordinates2 = Vector3.new(-1274.0032958984375, 103.20599365234375, -422.75982666015625)
            
            -- Set the delay between each teleport in seconds
            local teleportDelay = 0
            
            -- Get the player's character
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            
            -- Function to teleport the player to the specified coordinates
            local function teleportPlayer(position)
                character:SetPrimaryPartCFrame(CFrame.new(position))
            end
            
            -- Function to repeatedly teleport the player between the two coordinates
            local function teleportLoop()
                while autoFarmRunning do  -- Check if autoFarmRunning is true
                    teleportPlayer(coordinates1)
                    wait(teleportDelay)
                    teleportPlayer(coordinates2)
                    wait(teleportDelay)
                end
            end
            
            -- Start the teleport loop
            teleportLoop()
        end
end,})

tab:toggle({
    Name = "Route 4",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   autoFarmRunning = Value
        
        -- Check if the auto-farm is turned on or off
        if autoFarmRunning then
            -- Set the coordinates where you want the player to teleport
            local coordinates1 = Vector3.new(-1081.342041015625, 74.51649475097656, -1324.4395751953125)
	    local coordinates2 = Vector3.new(-1086.342041015625, 74.51649475097656, -1324.4395751953125)
            
            -- Set the delay between each teleport in seconds
            local teleportDelay = 0
            
            -- Get the player's character
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            
            -- Function to teleport the player to the specified coordinates
            local function teleportPlayer(position)
                character:SetPrimaryPartCFrame(CFrame.new(position))
            end
            
            -- Function to repeatedly teleport the player between the two coordinates
            local function teleportLoop()
                while autoFarmRunning do  -- Check if autoFarmRunning is true
                    teleportPlayer(coordinates1)
                    wait(teleportDelay)
                    teleportPlayer(coordinates2)
                    wait(teleportDelay)
                end
            end
            
            -- Start the teleport loop
            teleportLoop()
        end
end,})

tab:toggle({
    Name = "Route 5",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   autoFarmRunning = Value
        
        -- Check if the auto-farm is turned on or off
        if autoFarmRunning then
            -- Set the coordinates where you want the player to teleport
            local coordinates1 = Vector3.new(338.41693115234375, 168.70596313476562, -2173.38671875)
	    local coordinates2 = Vector3.new(333.41693115234375, 168.70596313476562, -2173.38671875)
            
            -- Set the delay between each teleport in seconds
            local teleportDelay = 0
            
            -- Get the player's character
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            
            -- Function to teleport the player to the specified coordinates
            local function teleportPlayer(position)
                character:SetPrimaryPartCFrame(CFrame.new(position))
            end
            
            -- Function to repeatedly teleport the player between the two coordinates
            local function teleportLoop()
                while autoFarmRunning do  -- Check if autoFarmRunning is true
                    teleportPlayer(coordinates1)
                    wait(teleportDelay)
                    teleportPlayer(coordinates2)
                    wait(teleportDelay)
                end
            end
            
            -- Start the teleport loop
            teleportLoop()
        end
end,})

tab:toggle({
    Name = "Igneus Hollow",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   autoFarmRunning = Value
        
        -- Check if the auto-farm is turned on or off
        if autoFarmRunning then
            -- Set the coordinates where you want the player to teleport
            local coordinates1 = Vector3.new(-1204.162353515625, 102.70599365234375, -941.314208984375)
	    local coordinates2 = Vector3.new(-1209.162353515625, 102.70599365234375, -941.314208984375)
            
            -- Set the delay between each teleport in seconds
            local teleportDelay = 0
            
            -- Get the player's character
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            
            -- Function to teleport the player to the specified coordinates
            local function teleportPlayer(position)
                character:SetPrimaryPartCFrame(CFrame.new(position))
            end
            
            -- Function to repeatedly teleport the player between the two coordinates
            local function teleportLoop()
                while autoFarmRunning do  -- Check if autoFarmRunning is true
                    teleportPlayer(coordinates1)
                    wait(teleportDelay)
                    teleportPlayer(coordinates2)
                    wait(teleportDelay)
                end
            end
            
            -- Start the teleport loop
            teleportLoop()
        end
end,})

tab:toggle({
    Name = "Heiwa Cemetary",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   autoFarmRunning = Value
        
        -- Check if the auto-farm is turned on or off
        if autoFarmRunning then
            -- Set the coordinates where you want the player to teleport
            local coordinates1 = Vector3.new(620.1329345703125, 207.90577697753906, -2473.2744140625)
		local coordinates2 = Vector3.new(615.1329345703125, 207.90577697753906, -2473.2744140625)
            
            -- Set the delay between each teleport in seconds
            local teleportDelay = 0
            
            -- Get the player's character
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            
            -- Function to teleport the player to the specified coordinates
            local function teleportPlayer(position)
                character:SetPrimaryPartCFrame(CFrame.new(position))
            end
            
            -- Function to repeatedly teleport the player between the two coordinates
            local function teleportLoop()
                while autoFarmRunning do  -- Check if autoFarmRunning is true
                    teleportPlayer(coordinates1)
                    wait(teleportDelay)
                    teleportPlayer(coordinates2)
                    wait(teleportDelay)
                end
            end
            
            -- Start the teleport loop
            teleportLoop()
        end
end,})

tab:toggle({
    Name = "Rally Ranch",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   autoFarmRunning = Value
        
        -- Check if the auto-farm is turned on or off
        if autoFarmRunning then
            -- Set the coordinates where you want the player to teleport
            local coordinates1 = Vector3.new(620.8035278320312, 53.20600891113281, 24.47963523864746)
		local coordinates2 = Vector3.new(615.8035278320312, 53.20600891113281, 24.47963523864746)
            
            -- Set the delay between each teleport in seconds
            local teleportDelay = 0
            
            -- Get the player's character
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            
            -- Function to teleport the player to the specified coordinates
            local function teleportPlayer(position)
                character:SetPrimaryPartCFrame(CFrame.new(position))
            end
            
            -- Function to repeatedly teleport the player between the two coordinates
            local function teleportLoop()
                while autoFarmRunning do  -- Check if autoFarmRunning is true
                    teleportPlayer(coordinates1)
                    wait(teleportDelay)
                    teleportPlayer(coordinates2)
                    wait(teleportDelay)
                end
            end
            
            -- Start the teleport loop
            teleportLoop()
        end
end,})

tab:toggle({
    Name = "Route 7",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   autoFarmRunning = Value
        
        -- Check if the auto-farm is turned on or off
        if autoFarmRunning then
            -- Set the coordinates where you want the player to teleport
            local coordinates1 = Vector3.new(1595.239013671875, 239.20596313476562, 4514.86572265625)
		local coordinates2 = Vector3.new(1590.239013671875, 239.20596313476562, 4514.86572265625)
            
            -- Set the delay between each teleport in seconds
            local teleportDelay = 0
            
            -- Get the player's character
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            
            -- Function to teleport the player to the specified coordinates
            local function teleportPlayer(position)
                character:SetPrimaryPartCFrame(CFrame.new(position))
            end
            
            -- Function to repeatedly teleport the player between the two coordinates
            local function teleportLoop()
                while autoFarmRunning do  -- Check if autoFarmRunning is true
                    teleportPlayer(coordinates1)
                    wait(teleportDelay)
                    teleportPlayer(coordinates2)
                    wait(teleportDelay)
                end
            end
            
            -- Start the teleport loop
            teleportLoop()
        end
end,})

tab:toggle({
    Name = "Saphrite Junkyard",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   autoFarmRunning = Value
        
        -- Check if the auto-farm is turned on or off
        if autoFarmRunning then
            -- Set the coordinates where you want the player to teleport
            local coordinates1 = Vector3.new(1600.180908203125, 224.20599365234375, 4581.55224609375)
		local coordinates2 = Vector3.new(1605.180908203125, 224.20599365234375, 4581.55224609375)
            
            -- Set the delay between each teleport in seconds
            local teleportDelay = 0
            
            -- Get the player's character
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            
            -- Function to teleport the player to the specified coordinates
            local function teleportPlayer(position)
                character:SetPrimaryPartCFrame(CFrame.new(position))
            end
            
            -- Function to repeatedly teleport the player between the two coordinates
            local function teleportLoop()
                while autoFarmRunning do  -- Check if autoFarmRunning is true
                    teleportPlayer(coordinates1)
                    wait(teleportDelay)
                    teleportPlayer(coordinates2)
                    wait(teleportDelay)
                end
            end
            
            -- Start the teleport loop
            teleportLoop()
        end
end,})

tab:toggle({
    Name = "POLUT Campus",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   autoFarmRunning = Value
        
        -- Check if the auto-farm is turned on or off
        if autoFarmRunning then
            -- Set the coordinates where you want the player to teleport
            local coordinates1 = Vector3.new(1375.622314453125, 149.30589294433594, -143.76918029785156)
		local coordinates2 = Vector3.new(1370.622314453125, 149.30589294433594, -143.76918029785156)
            
            -- Set the delay between each teleport in seconds
            local teleportDelay = 0
            
            -- Get the player's character
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            
            -- Function to teleport the player to the specified coordinates
            local function teleportPlayer(position)
                character:SetPrimaryPartCFrame(CFrame.new(position))
            end
            
            -- Function to repeatedly teleport the player between the two coordinates
            local function teleportLoop()
                while autoFarmRunning do  -- Check if autoFarmRunning is true
                    teleportPlayer(coordinates1)
                    wait(teleportDelay)
                    teleportPlayer(coordinates2)
                    wait(teleportDelay)
                end
            end
            
            -- Start the teleport loop
            teleportLoop()
        end
end,})

tab:toggle({
    Name = "Route 8",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   autoFarmRunning = Value
        
        -- Check if the auto-farm is turned on or off
        if autoFarmRunning then
            -- Set the coordinates where you want the player to teleport
            local coordinates1 = Vector3.new(384.11932373046875, 356.2059631347656, 3435.404052734375)
		local coordinates2 = Vector3.new(389.11932373046875, 356.2059631347656, 3435.404052734375)
            
            -- Set the delay between each teleport in seconds
            local teleportDelay = 0
            
            -- Get the player's character
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            
            -- Function to teleport the player to the specified coordinates
            local function teleportPlayer(position)
                character:SetPrimaryPartCFrame(CFrame.new(position))
            end
            
            -- Function to repeatedly teleport the player between the two coordinates
            local function teleportLoop()
                while autoFarmRunning do  -- Check if autoFarmRunning is true
                    teleportPlayer(coordinates1)
                    wait(teleportDelay)
                    teleportPlayer(coordinates2)
                    wait(teleportDelay)
                end
            end
            
            -- Start the teleport loop
            teleportLoop()
        end
end,})

tab:toggle({
    Name = "Lotusun Beach",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   autoFarmRunning = Value
        
        -- Check if the auto-farm is turned on or off
        if autoFarmRunning then
            -- Set the coordinates where you want the player to teleport
            local coordinates1 = Vector3.new(-766.48095703125, 308.2059326171875, 2864.21435546875)
		local coordinates2 = Vector3.new(-761.48095703125, 308.2059326171875, 2864.21435546875)
            
            -- Set the delay between each teleport in seconds
            local teleportDelay = 0
            
            -- Get the player's character
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            
            -- Function to teleport the player to the specified coordinates
            local function teleportPlayer(position)
                character:SetPrimaryPartCFrame(CFrame.new(position))
            end
            
            -- Function to repeatedly teleport the player between the two coordinates
            local function teleportLoop()
                while autoFarmRunning do  -- Check if autoFarmRunning is true
                    teleportPlayer(coordinates1)
                    wait(teleportDelay)
                    teleportPlayer(coordinates2)
                    wait(teleportDelay)
                end
            end
            
            -- Start the teleport loop
            teleportLoop()
        end
end,})

tab:toggle({
    Name = "Atlanthian Living District",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   autoFarmRunning = Value
        
        -- Check if the auto-farm is turned on or off
        if autoFarmRunning then
            -- Set the coordinates where you want the player to teleport
            local coordinates1 = Vector3.new(-2968.037109375, 490.6206970214844, -734.7662963867188)
		local coordinates2 = Vector3.new(-2963.037109375, 490.6206970214844, -734.7662963867188)
            
            -- Set the delay between each teleport in seconds
            local teleportDelay = 0
            
            -- Get the player's character
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            
            -- Function to teleport the player to the specified coordinates
            local function teleportPlayer(position)
                character:SetPrimaryPartCFrame(CFrame.new(position))
            end
            
            -- Function to repeatedly teleport the player between the two coordinates
            local function teleportLoop()
                while autoFarmRunning do  -- Check if autoFarmRunning is true
                    teleportPlayer(coordinates1)
                    wait(teleportDelay)
                    teleportPlayer(coordinates2)
                    wait(teleportDelay)
                end
            end
            
            -- Start the teleport loop
            teleportLoop()
        end
end,})

tab:toggle({
    Name = "Lumminity Park",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   autoFarmRunning = Value
        
        -- Check if the auto-farm is turned on or off
        if autoFarmRunning then
            -- Set the coordinates where you want the player to teleport
            local coordinates1 = Vector3.new(-4.088019847869873, 96.96873474121094, -211.2429962158203)
		local coordinates2 = Vector3.new(7.548005104064941, 96.9999771118164, -186.29055786132812)
            
            -- Set the delay between each teleport in seconds
            local teleportDelay = 0
            
            -- Get the player's character
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            
            -- Function to teleport the player to the specified coordinates
            local function teleportPlayer(position)
                character:SetPrimaryPartCFrame(CFrame.new(position))
            end
            
            -- Function to repeatedly teleport the player between the two coordinates
            local function teleportLoop()
                while autoFarmRunning do  -- Check if autoFarmRunning is true
                    teleportPlayer(coordinates1)
                    wait(teleportDelay)
                    teleportPlayer(coordinates2)
                    wait(teleportDelay)
                end
            end
            
            -- Start the teleport loop
            teleportLoop()
        end
end,})








tab:button({
    Name = "Cords",
    Description = "",
    Callback = function()
        local player = game.Players.LocalPlayer

-- Create a ScreenGui object to hold the TextBox and CloseButton
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CoordinatesGui"
screenGui.Parent = player.PlayerGui

-- Create a Frame to serve as the draggable window
local frame = Instance.new("Frame")
frame.Name = "CoordinatesWindow"
frame.Size = UDim2.new(0, 300, 0, 120) -- Adjust the size as desired
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundTransparency = 0.5
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- Create a TextBox to display and allow copying of the coordinates
local textBox = Instance.new("TextBox")
textBox.Name = "CoordinatesTextBox"
textBox.Size = UDim2.new(1, 0, 0.6, 0)
textBox.Position = UDim2.new(0, 0, 0, 0)
textBox.BackgroundTransparency = 1
textBox.TextColor3 = Color3.new(1, 1, 1)
textBox.TextSize = 24 -- Increase the text size
textBox.ClearTextOnFocus = false -- Keep the text when the TextBox is focused
textBox.MultiLine = true -- Allow multiple lines for better visibility
textBox.TextEditable = false -- Disable editing
textBox.Parent = frame

-- Create a CloseButton to close the GUI
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Position = UDim2.new(1, -20, 0, 0)
closeButton.BackgroundColor3 = Color3.new(1, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.TextSize = 14
closeButton.Text = "X"
closeButton.Parent = frame

-- Function to close the GUI
local function closeGui()
    screenGui:Destroy()
end

-- Connect the closeButton click event
closeButton.MouseButton1Click:Connect(closeGui)

-- Create a function to update the coordinates
local function updateCoordinates()
    local character = player.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local position = humanoidRootPart.Position
            textBox.Text = "Coordinates: " .. tostring(position)
        end
    end
end

-- Call the updateCoordinates function every second
while wait(0) do
    updateCoordinates()
end
    end,
})


tab:button({
    Name = "Test",
    Description = "",
    Callback = function()
        local gui = Instance.new("ScreenGui")
gui.Name = "CoordinatesGUI"
gui.Parent = game.Players.LocalPlayer.PlayerGui

-- Create a Frame as the draggable container for the GUI
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 500, 0, 190)
frame.Position = UDim2.new(0.5, -100, 0.5, -95)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BackgroundTransparency = 0.8
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Create two TextBoxes for the coordinates
local textBox1 = Instance.new("TextBox")
textBox1.Size = UDim2.new(0.8, 0, 0, 20)
textBox1.Position = UDim2.new(0.1, 0, 0.2, 0)
textBox1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textBox1.PlaceholderText = "Enter coordinates (X, Y, Z)"
textBox1.Parent = frame

local textBox2 = Instance.new("TextBox")
textBox2.Size = UDim2.new(0.8, 0, 0, 20)
textBox2.Position = UDim2.new(0.1, 0, 0.4, 0)
textBox2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textBox2.PlaceholderText = "Enter coordinates (X, Y, Z)"
textBox2.Parent = frame

-- Create a TeleportButton to trigger the teleportation
local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0.4, 0, 0, 30)
teleportButton.Position = UDim2.new(0.3, 0, 0.6, 0)
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
teleportButton.Text = "Start Teleportation"
teleportButton.Parent = frame

-- Create a ToggleButton to turn the teleportation on and off
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.4, 0, 0, 30)
toggleButton.Position = UDim2.new(0.3, 0, 0.8, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.AutoButtonColor = false
toggleButton.Text = "Teleportation: OFF"
toggleButton.Parent = frame

-- Create a CloseButton to close the GUI window
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Position = UDim2.new(1, -20, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Parent = frame

local isTeleporting = false
local position1, position2
local currentPosIndex = 1
local positions = {}

-- Function to handle the toggle button click
local function toggleTeleportation()
    isTeleporting = not isTeleporting
    toggleButton.Text = isTeleporting and "Teleportation: ON" or "Teleportation: OFF"

    if isTeleporting then
        local coordinates1 = string.split(textBox1.Text, ",")
        local coordinates2 = string.split(textBox2.Text, ",")

        if #coordinates1 == 3 and #coordinates2 == 3 then
            position1 = Vector3.new(
                tonumber(coordinates1[1]),
                tonumber(coordinates1[2]),
                tonumber(coordinates1[3])
            )
            position2 = Vector3.new(
                tonumber(coordinates2[1]),
                tonumber(coordinates2[2]),
                tonumber(coordinates2[3])
            )

            positions = {position1, position2}
        else
            print("Invalid coordinates input!")
            isTeleporting = false
            toggleButton.Text = "Teleportation: OFF"
        end
    end
end

-- Function to teleport the player to the specified coordinates
local function teleportToCoordinates(coordinates)
    local player = game.Players.LocalPlayer
    player.Character:MoveTo(coordinates)
end

-- Bind the TeleportButton's MouseButton1Click event
teleportButton.MouseButton1Click:Connect(function()
    toggleTeleportation()
end)

-- Bind the ToggleButton's MouseButton1Click event
toggleButton.MouseButton1Click:Connect(function()
    toggleTeleportation()
end)

-- Bind the CloseButton's MouseButton1Click event
closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Function to repeatedly teleport the player
game:GetService("RunService").Heartbeat:Connect(function()
    if isTeleporting then
        teleportToCoordinates(positions[currentPosIndex])
        currentPosIndex = currentPosIndex % 2 + 1
        wait(0)
    end
end)
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
