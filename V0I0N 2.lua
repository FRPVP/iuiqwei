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
