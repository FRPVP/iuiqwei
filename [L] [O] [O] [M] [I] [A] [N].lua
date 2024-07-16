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

-- LocalScript in StarterPlayerScripts or within a tool
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local runService = game:GetService("RunService")

local SPEED_MULTIPLIER = 0 -- Default multiplier to 1 (normal speed)
local speedEnabled = false -- Variable to track if speed is enabled

local function onUpdate()
    if speedEnabled and character and humanoid and humanoid.MoveDirection.Magnitude > 0 then
        local moveDirection = humanoid.MoveDirection
        local newPosition = character.PrimaryPart.Position + (moveDirection * SPEED_MULTIPLIER)
        character:SetPrimaryPartCFrame(CFrame.new(newPosition))
    end
end

-- Connect the update function to the render step
runService.RenderStepped:Connect(onUpdate)

-- Assuming you have a UI library that provides tab:toggle
tab:toggle({
    Name = "Speed",
    StartingState = false,
    Description = "",
    Callback = function(state)
        speedEnabled = state -- Update the speedEnabled variable based on toggle state
    end
})

-- Assuming you have a UI library that provides tab:slider
local something = tab:slider({
    Name = "Adjust Speed",
    Description = "",
    Default = 0,
    Min = 0,
    Max = 10, -- Adjust this maximum value as needed
    Rounding = 1,
    Callback = function(v)
        SPEED_MULTIPLIER = v
    end
})


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



tab:toggle({
    Name = "Esp",
		StartingState = false,
		Description = "",
		Callback = function(Value)
   if Value then
           local FillColor = Color3.fromRGB(255,255,255)
           local DepthMode = "AlwaysOnTop"
           local FillTransparency = 0.5
           local OutlineColor = Color3.fromRGB(255,255,255)
           local OutlineTransparency = 0

           local CoreGui = game:FindService("CoreGui")
           local Players = game:FindService("Players")
           local lp = Players.LocalPlayer
           local connections = {}

           local Storage = Instance.new("Folder")
           Storage.Parent = CoreGui
           Storage.Name = "Highlight_Storage"

           local function Highlight(plr)
               local Highlight = Instance.new("Highlight")
               Highlight.Name = plr.Name
               Highlight.FillColor = FillColor
               Highlight.DepthMode = DepthMode
               Highlight.FillTransparency = FillTransparency
               Highlight.OutlineColor = OutlineColor
               Highlight.OutlineTransparency = 0
               Highlight.Parent = Storage

               local plrchar = plr.Character
               if plrchar then
                   Highlight.Adornee = plrchar
               end

               connections[plr] = plr.CharacterAdded:Connect(function(char)
                   Highlight.Adornee = char
               end)
           end

           Players.PlayerAdded:Connect(Highlight)
           for i,v in next, Players:GetPlayers() do
               Highlight(v)
           end

           Players.PlayerRemoving:Connect(function(plr)
               local plrname = plr.Name
               if Storage[plrname] then
                   Storage[plrname]:Destroy()
               end
               if connections[plr] then
                   connections[plr]:Disconnect()
               end
           end)
       else
           -- Turn off the ESP functionality
           -- Remove any existing highlights from the screen
           local CoreGui = game:GetService("CoreGui")
           local Storage = CoreGui:FindFirstChild("Highlight_Storage")
           if Storage then
               Storage:ClearAllChildren()
               Storage:Destroy()
           end
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
    ["NPC Walk"] = "rbxassetid://8648075382",
    ["NPC Run"] = "rbxassetid://8648077870",
    ["NPC Wave"] = "rbxassetid://1885144316",

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
    Description = "Loomian Legacy Edition",
    StartingText = "",
    Items = {"Float Slash", "Down Slash", "Arms Out", "Spinner", "Crazy Slash", "Weird Zombie", "Pull", "Open", "Circle Arm", "Bend", "Rotate Slash", "Flail Arms", "Punch", "NPC Walk", "NPC Run", "NPC Wave"},
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

tab:button({
    Name = "Walk On Walls",
    Description = "Toggle with Z",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
    end,
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
    Name = "Invisibility",
    StartingState = false,
    Description = "Break your loomian to become FULLY invisible",
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

-- Define a table to store references to removed "Grass" parts
local removedGrassParts = {}

-- Function to remove "Grass" parts and store references
local function removeGrassParts()
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Name == "Grass" then
            table.insert(removedGrassParts, part:Clone())
            part:Destroy()
        end
    end
end

-- Function to restore removed "Grass" parts
local function restoreGrassParts()
    for _, part in ipairs(removedGrassParts) do
        part.Parent = workspace
    end
    removedGrassParts = {}  -- Clear the list after restoring
end

-- Toggle button logic
tab:toggle({
    Name = "Remove Grass",
    StartingState = false,
    Description = "Removes Grass to avoid encounters",
    Callback = function(state)
        if state then
            -- Remove "Grass" parts
            removeGrassParts()
        else
            -- Restore "Grass" parts
            restoreGrassParts()
        end
    end
})

local teleportDelay = 0

-- Get the player's character
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Variables to track the state of the teleport loop and store original position
local isTeleporting = false
local originalPosition = nil
local teleportMode = "None"  -- Options: "None", "Closest", "Farthest"

-- Function to teleport the player to the specified coordinates
local function teleportPlayer(position)
    character:SetPrimaryPartCFrame(CFrame.new(position))
end

-- Function to get the player's current coordinates and add 5 to the X component
local function getCurrentCoordinates()
    local currentPosition = character.PrimaryPart.Position
    return currentPosition + Vector3.new(5, 0, 0)
end

-- Function to find the closest "Grass" part in the workspace
local function findClosestGrassPart()
    local closestPart = nil
    local shortestDistance = math.huge
    
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Name == "Grass" then
            local distance = (part.Position - character.PrimaryPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestPart = part
            end
        end
    end
    
    return closestPart
end

-- Function to find the farthest "Grass" part in the workspace
local function findFarthestGrassPart()
    local farthestPart = nil
    local longestDistance = 0
    
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Name == "Grass" then
            local distance = (part.Position - character.PrimaryPart.Position).Magnitude
            if distance > longestDistance then
                longestDistance = distance
                farthestPart = part
            end
        end
    end
    
    return farthestPart
end

-- Function to repeatedly teleport the player between the current coordinates and an offset position
local function teleportLoop()
    local currentCoordinates = getCurrentCoordinates()
    
    while isTeleporting do
        local targetPosition = currentCoordinates
        teleportPlayer(targetPosition)
        wait(teleportDelay)
        teleportPlayer(targetPosition + Vector3.new(5, 0, 0)) -- Teleport to an offset position
        wait(teleportDelay)
    end
end

-- Toggle to start the teleport loop at the current position
tab:toggle({
    Name = "Tp Autofarm",
    StartingState = false,
    Description = "Only works on patches of grass",
    Callback = function(state)
        isTeleporting = state
        
        if isTeleporting then
            -- Save the original position when toggled on
            originalPosition = character.PrimaryPart.Position
            
            if teleportMode == "Closest" then
                local closestGrassPart = findClosestGrassPart()
                if closestGrassPart then
                    local grassCenter = closestGrassPart.Position
                    teleportPlayer(grassCenter)
                    wait(teleportDelay)
                end
            elseif teleportMode == "Farthest" then
                local farthestGrassPart = findFarthestGrassPart()
                if farthestGrassPart then
                    local grassCenter = farthestGrassPart.Position
                    teleportPlayer(grassCenter)
                    wait(teleportDelay)
                end
            end

            teleportLoop()
        else
            if originalPosition then
                teleportPlayer(originalPosition)
            end
        end
    end,
})

-- Dropdown to select teleport mode
tab:dropdown({
    Name = "Tp Method",
    StartingText = "None",
    Items = {
        {"None", "None"},
        {"Closest", "Closest"},
        {"Farthest", "Farthest"}
    },
    Description = "Select the method of your choosing",
    Callback = function(v)
        teleportMode = v
    end,
})












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
    Name = "Reset",
    Description = "",
    Callback = function()
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Function to attach a mesh to the character
local function attachMesh(mesh)
    local clone = mesh:Clone()
    clone.Parent = character
end

-- Function to iterate through all the meshes and models in the game
local function iterateModels(obj)
    for _, child in ipairs(obj:GetChildren()) do
        if child:IsA("BasePart") then
            attachMesh(child)
        elseif child:IsA("MeshPart") then
            attachMesh(child)
        elseif child:IsA("Model") then
            iterateModels(child)
        end
    end
end

-- Attach all meshes and models to the character
iterateModels(game.Workspace)

-- Listen for new models being added
game.Workspace.DescendantAdded:Connect(function(child)
    if child:IsA("Model") then
        iterateModels(child)
    end
end)
    end,
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
