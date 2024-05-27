 local Sound = Instance.new("Sound",game:GetService("SoundService"))
 Sound.SoundId = "rbxassetid://9120129807"
 Sound:Play()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/FRPVP/iuiqwei/main/library.lua"))()

local gui = Library:create{
    Theme = Library.Themes.Dark
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








local tab = gui:tab{
    Icon = "rbxassetid://17628895810",
    Name = "Combat"
}












local tab = gui:tab{
    Icon = "rbxassetid://17628887332",
    Name = "Teleport"
}














local tab = gui:tab{
    Icon = "rbxassetid://17628882295",
    Name = "Trolling"
}















local tab = gui:tab{
    Icon = "rbxassetid://17628879224",
    Name = "Autofarm"
}














local tab = gui:tab{
    Icon = "rbxassetid://17628876487",
    Name = "Emotes"
}















local tab = gui:tab{
    Icon = "rbxassetid://17628892018",
    Name = "Spraypaint"
}


















local tab = gui:tab{
    Icon = "rbxassetid://17629022447",
    Name = "Misc"
}
