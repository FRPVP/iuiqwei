local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Vindicate " .. Fluent.Version,
    SubTitle = "MM2",
    TabWidth = 120,
    Size = UDim2.fromOffset(480, 360),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Player = Window:AddTab({ Title = "Player", Icon = "" }),
    Visual = Window:AddTab({ Title = "Visual", Icon = "" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "" }),
    Trolling = Window:AddTab({ Title = "Trolling", Icon = "" }),
    Autofarm = Window:AddTab({ Title = "Autofarm", Icon = "" }),
    Emotes = Window:AddTab({ Title = "Emotes", Icon = "" }),
    Animations = Window:AddTab({ Title = "Animations", Icon = "" }),
    Premium = Window:AddTab({ Title = "Premium", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "" })
}

local Options = Fluent.Options

do



    
    local Slider = Tabs.Player:AddSlider("Slider", {
        Title = "Walkspeed",
        Description = "Increase/Decrease the speed of your walk",
        Default = 2,
        Min = 16,
        Max = 300,
        Rounding = 1,
        Callback = function(vv)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = vv
        end
    })

    Slider:OnChanged(function(vv)
        print("Slider changed:", vv)
    end)

    Slider:SetValue(16)
    
    
    
    
        local Input = Tabs.Player:AddInput("Input", {
        Title = "Walkspeed",
        Default = "16",
        Placeholder = "Placeholder",
        Numeric = true, -- Only allows numbers
        Finished = true, -- Only calls callback when you press enter
        Callback = function(vv)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = vv
        end
    })

    Input:OnChanged(function()
        print("Input updated:", Input.vv)
    end)
    
    
    
    
    
        local Slider = Tabs.Player:AddSlider("Slider", {
        Title = "Jump Height",
        Description = "Increase/Decrease the height of your jump",
        Default = 2,
        Min = 50,
        Max = 300,
        Rounding = 1,
        Callback = function(vv)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = vv
        end
    })

    Slider:OnChanged(function(vv)
        print("Slider changed:", vv)
    end)

    Slider:SetValue(50)
    
    
    
    
        local Input = Tabs.Player:AddInput("Input", {
        Title = "Jump Height",
        Default = "50",
        Placeholder = "Placeholder",
        Numeric = true, -- Only allows numbers
        Finished = true, -- Only calls callback when you press enter
        Callback = function(vv)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = vv
        end
    })

    Input:OnChanged(function()
        print("Input updated:", Input.vv)
    end)
    
    
    
    local Toggle = Tabs.Player:AddToggle("MyToggle", {Title = "Noclip", Default = false })

    Toggle:OnChanged(function(Value)
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

    Options.MyToggle:SetValue(false)
    
    
    
local mflyspeed = 80 -- Adjust the speed as needed
local RS = game:GetService("RunService")

local Toggle = Tabs.Player:AddToggle("MyToggle", {Title = "Fly", Default = false })

local Signal1, Signal2

Toggle:OnChanged(function(t)
    if t then
        local controlModule = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild('PlayerModule'):WaitForChild("ControlModule"))

        local bv = Instance.new("BodyVelocity")
        bv.Name = "VelocityHandler"
        bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
        bv.MaxForce = Vector3.new(0, 0, 0)
        bv.Velocity = Vector3.new(0, 0, 0)

        local bg = Instance.new("BodyGyro")
        bg.Name = "GyroHandler"
        bg.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.P = 1000
        bg.D = 50

        Signal1 = game.Players.LocalPlayer.CharacterAdded:Connect(function(NewChar)
            local bv = Instance.new("BodyVelocity")
            bv.Name = "VelocityHandler"
            bv.Parent = NewChar:WaitForChild("Humanoid").RootPart
            bv.MaxForce = Vector3.new(0, 0, 0)
            bv.Velocity = Vector3.new(0, 0, 0)

            local bg = Instance.new("BodyGyro")
            bg.Name = "GyroHandler"
            bg.Parent = NewChar:WaitForChild("Humanoid").HumanoidRootPart
            bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.P = 1000
            bg.D = 50
        end)

        local camera = game.Workspace.CurrentCamera

        Signal2 = RS.RenderStepped:Connect(function()
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then

                game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true

                game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler.CFrame = camera.CoordinateFrame
                local direction = controlModule:GetMoveVector()
                game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = Vector3.new()

                if direction.X ~= 0 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * mflyspeed)
                end
                if direction.Z ~= 0 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * mflyspeed)
                end
            end
        end)
    else
        if Signal1 and Signal2 then
            game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler:Destroy()
            game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler:Destroy()
            game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
            Signal1:Disconnect()
            Signal2:Disconnect()
            Signal1 = nil
            Signal2 = nil
        end
    end
end)

-- Set the initial state of the toggle
Toggle:SetValue(false)



local Slider = Tabs.Player:AddSlider("Slider", {
        Title = "Fly Speed",
        Description = "Increase/Decrease the speed of your flight",
        Default = 2,
        Min = 40,
        Max = 200,
        Rounding = 1,
        Callback = function(Value)
            print("Slider was changed:", Value)
        end
    })

    Slider:OnChanged(function(vv)
    mflyspeed = vv
    end)

    Slider:SetValue(40)

    
    
    local Input = Tabs.Player:AddInput("Input", {
        Title = "Fly Speed",
        Default = "40",
        Placeholder = "Placeholder",
        Numeric = true, -- Only allows numbers
        Finished = true, -- Only calls callback when you press enter
        Callback = function(vv)
        mflyspeed = vv
        end
    })

    Input:OnChanged(function()
        print("Input updated:", Input.vv)
    end)

    
    
    

    local canInfJump = false

local Toggle = Tabs.Player:AddToggle("MyToggle", { Title = "Inf Jump", Default = false })

Toggle:OnChanged(function(isToggled)
    canInfJump = isToggled
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if canInfJump then
        local localPlayer = game:GetService("Players").LocalPlayer
        local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass('Humanoid')
        
        if humanoid then
            humanoid:ChangeState("Jumping")
        end
    end
end)

-- Add this function to turn off Inf Jump
function turnOffInfJump()
    canInfJump = false
    Toggle:SetValue(false)  -- You may want to update the toggle UI to reflect the state change
end

-- Assuming Options is defined elsewhere in your script
Options.MyToggle:SetValue(false)
    
    


    local Toggle = Tabs.Player:AddToggle("MyToggle", {Title = "Click TP", Default = false })

    Toggle:OnChanged(function(Value)
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

    Options.MyToggle:SetValue(false)
    
    
    
    
    
    
    local Toggle = Tabs.Player:AddToggle("MyToggle", {Title = "Remove Kill Barriers", Default = false })

    Toggle:OnChanged(function(val)
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

    Options.MyToggle:SetValue(false)
    
    
    
    




Tabs.Player:AddButton({
    Title = "Message Roles",
    Description = "",
    Callback = function()
        -- Function to check if a player has a knife
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
    end
})








local Stealth -- Declare Stealth variable outside of the scope

local Toggle = Tabs.Player:AddToggle("MyToggle", {Title = "Ghost", Default = false })

Toggle:OnChanged(function()
    local val = Toggle.Value
    print("Toggle changed:", val)
    if val then
        -- If toggle is turned on, activate Stealth
        Stealth = RS.RenderStepped:Connect(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("Stealth"):FireServer(true)
        end)
    else
        -- If toggle is turned off, disconnect the Stealth activation
        if Stealth then
            Stealth:Disconnect()
        end
        -- Deactivate Stealth
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("Stealth"):FireServer(false)
    end
end)

Options.MyToggle:SetValue(false) -- Ensure the toggle starts in the off position










local sprint -- Declare sprint variable outside of the scope

local Toggle = Tabs.Player:AddToggle("MyToggle", {Title = "Sprint Trail", Default = false })

Toggle:OnChanged(function()
    local val = Toggle.Value
    print("Toggle changed:", val)
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
end)

Options.MyToggle:SetValue(false) -- Ensure the toggle starts in the off position










Tabs.Player:AddButton({
    Title = "Spawn Trap",
    Description = "Spawn a trap (Trap Perk Required)",
    Callback = function()
        -- Ensure that the required services and objects are available
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local lp = game:GetService("Players").LocalPlayer

        -- Invoke the server to spawn a trap
        ReplicatedStorage:WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(lp.Character.HumanoidRootPart.CFrame)
    end
})









local trapSpawnConnection -- Declare the connection variable outside the scope
local trapDelay = 2 -- Default delay

local Toggle = Tabs.Player:AddToggle("", {Title = "Loop Traps", Default = false })

Toggle:OnChanged(function()
    local val = Toggle.Value
    print("Toggle changed:", val)
    if val then
        -- If toggle is turned on, continuously spawn traps with delay
        trapSpawnConnection = RS.RenderStepped:Connect(function()
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local lp = game:GetService("Players").LocalPlayer
            ReplicatedStorage:WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(lp.Character.HumanoidRootPart.CFrame)
        end)
    else
        -- If toggle is turned off, disconnect the trap spawning
        if trapSpawnConnection then
            trapSpawnConnection:Disconnect()
        end
    end
end)

-- Slider to control the delay between trap spawns
local Slider = Tabs.Player:AddSlider("Trap Spawn Delay", {
    Title = "Loop Trap Delay",
    Description = "Adjust the delay between trap spawns",
    Default = trapDelay,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Callback = function(Value)
        trapDelay = Value -- Update the trap delay based on the slider value
        print("Slider was changed:", Value)
    end
})

-- Function to spawn traps with delay
local function spawnTrapWithDelay()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local lp = game:GetService("Players").LocalPlayer
    ReplicatedStorage:WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(lp.Character.HumanoidRootPart.CFrame)
end

-- Adjust trap spawn delay based on slider value when changed
Slider:OnChanged(function(Value)
    trapDelay = Value
    print("Slider changed:", Value)
end)

Options.MyToggle:SetValue(false) -- Ensure the toggle starts in the off position

-- Function to continuously spawn traps with delay
local function spawnTraps()
    while Toggle.Value do
        spawnTrapWithDelay()
        wait(trapDelay)
    end
end

-- Start spawning traps with delay when toggle is turned on
Toggle:OnChanged(function()
    if Toggle.Value then
        spawnTraps()
    end
end)










Tabs.Player:AddButton({
    Title = "Notify Roles",
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
    end
})
    
    
    
        
        Tabs.Player:AddButton({
        Title = "Free Xbox Knife",
        Description = "",
        Callback = function()
	local Event = game:GetService("ReplicatedStorage").Remotes.Extras.IsXbox
	Event:FireServer(A_1)
        end
    })
    
    
    
    
    
        local Toggle = Tabs.Visual:AddToggle("MyToggle", {Title = "ESP Players", Default = false })

    Toggle:OnChanged(function(val)
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


    Options.MyToggle:SetValue(false)
   

    
    
    
    
    
local Toggle = Tabs.Visual:AddToggle("MyToggle", {Title = "Highlight Players", Default = false })

Toggle:OnChanged(function(val)
    getgenv().he = val
end)

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

Options.MyToggle:SetValue(false)

    
 


   
    
    
getgenv().GlowCham = false    
    local Toggle = Tabs.Visual:AddToggle("MyToggle", {Title = "Glow Chams", Default = false })

Toggle:OnChanged(function(val)
    getgenv().GlowCham = val
end)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local roles

local outlineDebounces = {}

-- > Functions <--

function ApplyOutline(character, color)
    if not outlineDebounces[character] then
        local outline = Instance.new("SelectionBox")
        outline.LineThickness = 0.05
        outline.SurfaceColor3 = color
        outline.Color3 = color
        outline.Adornee = character:WaitForChild("Head") -- Wait for Head to ensure it exists
        outline.Parent = character

        local surfaceLight = Instance.new("SurfaceLight")
        surfaceLight.Brightness = 9999 -- Adjust brightness as needed
        surfaceLight.Color = color
        surfaceLight.Face = Enum.NormalId.Front -- Adjusted to include multiple faces
        surfaceLight.Parent = character.Head

        local surfaceLightBack = surfaceLight:Clone()
        surfaceLightBack.Face = Enum.NormalId.Back
        surfaceLightBack.Parent = character.Head

        local surfaceLightLeft = surfaceLight:Clone()
        surfaceLightLeft.Face = Enum.NormalId.Left
        surfaceLightLeft.Parent = character.Head

        outlineDebounces[character] = true
    end
end

function RemoveOutline(character)
    if outlineDebounces[character] then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("SelectionBox") or part:IsA("SurfaceLight") then
                part:Destroy()
            end
        end

        outlineDebounces[character] = false
    end
end

function UpdateOutlines()
    for _, v in pairs(Players:GetChildren()) do
        if v ~= LP and v.Character then
            if IsAlive(v) then
                local role = GetPlayerRole(v.Name)
                if role == "Sheriff" then
                    ApplyOutline(v.Character, Color3.fromRGB(0, 0, 225))
                elseif role == "Murderer" then
                    ApplyOutline(v.Character, Color3.fromRGB(225, 0, 0))
                elseif role == "Hero" then
                    ApplyOutline(v.Character, Color3.fromRGB(255, 250, 0))
                else
                    ApplyOutline(v.Character, Color3.fromRGB(0, 225, 0))
                end
            else
                RemoveOutline(v.Character)
            end
        end
    end
end

-- > Loops < --

RunService.RenderStepped:Connect(function()
    roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()

    if getgenv().GlowCham then
        UpdateOutlines()
    else
        for _, v in pairs(Players:GetChildren()) do
            if v ~= LP and v.Character then
                RemoveOutline(v.Character)
            end
        end
    end
end)

Options.MyToggle:SetValue(false)
    
    
    
    
    
    
    
      local Toggle = Tabs.Visual:AddToggle("MyToggle", {Title = "View Dropped Gun", Default = false })

    Toggle:OnChanged(function(Value)
     getgenv().ViewGun = Value
if ViewGun then
while ViewGun do
task.wait(0.5)
pcall(function()
		for i,v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == "GunDrop" then
				game.Workspace.CurrentCamera.CameraSubject = v
			end
		end
		end)
	    if not ViewGun then
        game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid')
	game.Workspace.CurrentCamera.CameraType = "Custom"
	game.Players.LocalPlayer.CameraMinZoomDistance = 0.5
	game.Players.LocalPlayer.CameraMaxZoomDistance = 400
	game.Players.LocalPlayer.CameraMode = "Classic"
	game.Players.LocalPlayer.Character.Head.Anchored = false
	break
        end
		end
		end
    end)

    Options.MyToggle:SetValue(false)
    
    
    
    
    
    
    
        Tabs.Visual:AddButton({
        Title = "Spectate Murderer",
        Description = "",
        Callback = function()
           for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
game.Workspace.CurrentCamera.CameraSubject = v.Character.Humanoid
end
end
end
    })
    
    
    
    
    
    
    
    
    
    
        Tabs.Visual:AddButton({
        Title = "Spectate Sheriff",
        Description = "",
        Callback = function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
game.Workspace.CurrentCamera.CameraSubject = v.Character.Humanoid
end
end
end
    })
    
    
    
    
-- Function to update the dropdown with the current player list
local function UpdatePlayerListDropdown(Dropdown)
    local playerList = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        table.insert(playerList, player.Name)
    end
    Dropdown:SetValues(playerList)
end

-- Create the dropdown with player names
local Dropdown = Tabs.Visual:AddDropdown("Dropdown", {
    Title = "Spectate Player",
    Values = {},  -- Start with an empty list
    Multi = false,
    Default = 0,
})

-- Update the dropdown with the current player list
UpdatePlayerListDropdown(Dropdown)

-- Callback function when dropdown value changes
Dropdown:OnChanged(function(Value)
    print("Dropdown changed:", Value)

    -- Script to spectate the selected player
    local User = game.Players:FindFirstChild(Value)
    if User then
        game.Workspace.CurrentCamera.CameraSubject = User.Character.Humanoid
    else
        warn("Invalid Player!")
    end
end)

-- Connect to player added/removed events to update the dropdown
game.Players.PlayerAdded:Connect(function(player)
    UpdatePlayerListDropdown(Dropdown)
end)

game.Players.PlayerRemoving:Connect(function(player)
    UpdatePlayerListDropdown(Dropdown)
end)


    
    
    
    
    
    
    
    
        Tabs.Visual:AddButton({
        Title = "Stop Specatating",
        Description = "",
        Callback = function()
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid')
end
    })
    
    
    
    
    
    
    
    
     Tabs.Combat:AddButton({
        Title = "Grab Gun",
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
        end
    })
    
    
    
    
    
    
    
        Tabs.Teleport:AddButton({
        Title = "Lobby",
        Description = "",
        Callback = function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108, 138, 37)
        end
    })
    
    
    
    
    
    
    
        Tabs.Teleport:AddButton({
        Title = "Map",
        Description = "",
        Callback = function()
for i,v in pairs(game.Workspace:GetDescendants()) do
if v.Name == "House2" or v.Name == "MilBase" or v.Name == "Mansion2" or v.Name == "Hospital3" or v.Name == "PoliceStation" or v.Name == "nSOffice" or v.Name == "Bank2" or v.Name == "Office3" or v.Name == "Hotel" or v.Name == "Factory" or v.Name == "Workplace" or v.Name == "BioLab" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Spawns.Spawn.CFrame
elseif v.Name == "ResearchFacility" then
lp.Character.HumanoidRootPart.CFrame = v.Spawns.PlayerSpawn.CFrame
end
end
        end
    })
    
    
    
    
    
    
    
    
    
    
        Tabs.Teleport:AddButton({
        Title = "Voting Room",
        Description = "",
        Callback = function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108, 141, 86)
        end
    })
    
    
    
    
    
    
    
    
    
    
        Tabs.Teleport:AddButton({
        Title = "Void",
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
        end
    })
    
    
    
    
    
    
    
    
    
    
    
        Tabs.Teleport:AddButton({
        Title = "Murderer",
        Description = "",
        Callback = function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
end
end
        end
    })
    
    
    
    
    
    
    
    
    
    
    
        Tabs.Teleport:AddButton({
        Title = "Sheriff",
        Description = "",
        Callback = function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
end
end
        end
    })
    
    
    
    
    
    
    
    
    
        local Toggle = Tabs.Trolling:AddToggle("MyToggle", {Title = "Fake Gun", Default = false })

    Toggle:OnChanged(function(val)
    if val then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("FakeGun"):FireServer(unpack({
    [1] = true
}))
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("FakeGun"):FireServer(unpack({
    [1] = false
}))
end
    end)

    Options.MyToggle:SetValue(false)
    
    
    
    
    
    
    
    
    
    
    
        Tabs.Trolling:AddButton({
        Title = "Trap All",
        Description = "",
        Callback = function()
for i,x in pairs(Players:GetPlayers()) do
if x ~= lp then
game:GetService("ReplicatedStorage"):WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(unpack({
    [1] = x.Character.HumanoidRootPart.CFrame
}))
end
end
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
        Tabs.Trolling:AddButton({
        Title = "Trap Murderer",
        Description = "",
        Callback = function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
game:GetService("ReplicatedStorage"):WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame
}))
end
end
        end
    })
    
    
    
    
    
    
    
            Tabs.Trolling:AddButton({
        Title = "Trap Sheriff",
        Description = "",
        Callback = function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
game:GetService("ReplicatedStorage"):WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame
}))
end
end
        end
    })
    
    
    
    
  
    
    
            Tabs.Emotes:AddButton({
        Title = "Get Emotes",
        Description = "",
        Callback = function()
require(game:GetService('ReplicatedStorage').Modules.EmoteModule).GeneratePage({"headless","zombie","zen","ninja","floss","dab","sit"},game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Game:FindFirstChild("Emotes"),'IDE-Ware Emotes')
        end
    })
    
    
    
    
    
    
    
                Tabs.Emotes:AddButton({
        Title = "FE Roblox Emotes",
        Description = "",
        Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FEmotesGui/main/FEmotesGui.lua", true))()
        end
    })
    
    






            Tabs.Animations:AddButton({
        Title = "None",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=0"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=0"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=0"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=0"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=0"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=0"
Animate.swimidle.SwimIdle.AnimationId = "http://www.roblox.com/asset/?id=0"
Animate.swim.Swim.AnimationId = "http://www.roblox.com/asset/?id=0"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Princess",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=941003647"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=941013098"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=941028902"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=941015281"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=941008832"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=940996062"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=941000007"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Sneaky",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1132473842"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1132477671"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1132510133"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1132494274"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1132489853"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1132461372"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1132469004"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Ghost",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616006778"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616008087"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616008936"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616005863"
Animate.swimidle.SwimIdle.AnimationId = "http://www.roblox.com/asset/?id=616012453"
Animate.swim.Swim.AnimationId = "http://www.roblox.com/asset/?id=616011509"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Cowboy",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1014390418"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1014398616"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1014421541"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1014401683"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1014394726"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1014380606"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1014384571"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Popstar",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1212900985"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1150842221"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1212980338"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1212980348"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1212954642"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1213044953"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1212900995"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Confident",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1069977950"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1069987858"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1070017263"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1070001516"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1069984524"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1069946257"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1069973677"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Patrol",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1149612882"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1150842221"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1151231493"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1150967949"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1148811837"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1148811837"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1148863382"
        end
    })
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Zombie",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616158929"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616160636"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616161997"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Werewolf",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083195517"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083214717"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083178339"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083216690"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083218792"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083182000"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083189019"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Vampire",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083445855"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083450166"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083473930"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083462077"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083455352"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083439238"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083443587"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Toy",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=782841498"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=782845736"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=782843345"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=782842708"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=782847020"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=782843869"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=782846423"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "SuperHero",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616111295"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616113536"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616122287"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616117076"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616115533"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616104706"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616108001"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Stylish",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616136790"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616138447"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616146177"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616140816"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616139451"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616133594"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616134815"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Robot",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616088211"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616089559"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616095330"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616091570"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616090535"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616086039"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616087089"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Pirate",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=750781874"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=750782770"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=750785693"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=750783738"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=750782230"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=750779899"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=750780242"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Ninja",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=656117400"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=656118341"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=656121766"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=656118852"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=656117878"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=656114359"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=656115606"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Mage",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=707742142"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=707855907"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=707897309"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=707861613"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=707853694"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=707826056"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Levitation",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616006778"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616008087"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616010382"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616008936"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616003713"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616005863"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Knight",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=657595757"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=657568135"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=657552124"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=657564596"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=658409194"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=658360781"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=657600338"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Elder",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=845397899"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=845400520"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=845403856"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=845386501"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=845398858"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=845392038"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=845396048"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Cartoony",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=742637544"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=742638445"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=742640026"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=742638842"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=742637942"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=742636889"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=742637151"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Bubbly",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=910004836"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=910009958"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=910034870"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=910025107"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=910016857"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=910001910"
Animate.swimidle.SwimIdle.AnimationId = "http://www.roblox.com/asset/?id=910030921"
Animate.swim.Swim.AnimationId = "http://www.roblox.com/asset/?id=910028158"
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
            Tabs.Animations:AddButton({
        Title = "Astronaut",
        Description = "",
        Callback = function()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=891621366"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=891633237"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=891667138"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=891636393"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=891627522"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=891609353"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=891617961"
        end
    })
    
    
    
    
    
    
    
    
    
        Tabs.Premium:AddButton({
        Title = "Get Fake Gun",
        Description = "",
        Callback = function()
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("FakeGun"):FireServer(unpack({
    [1] = true -- set to true to activate
}))
        end
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
        Tabs.Premium:AddButton({
        Title = "Drop Fake Gun",
        Description = "",
        Callback = function()
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("FakeGun"):FireServer(unpack({
    [1] = true -- set to true to activate
}))

wait(0.2)

game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace
        end
    })
    
    
    
    
    
    
    
    

            Tabs.Premium:AddButton({
        Title = "Clear Dropped Guns (Server Side)",
        Description = "",
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
        end
    })
    
    
    
    
    
    
    
                Tabs.Premium:AddButton({
        Title = "Clear Dropped Guns (Client Side)",
        Description = "",
        Callback = function()
-- Get all children of the Workspace
local children = game.Workspace:GetChildren()

-- Iterate through each child
for _, child in pairs(children) do
    -- Check if the child is a Tool
    if child:IsA("Tool") then
        -- Delete the tool
        child:Destroy()
    end
end
        end
    })
    
    
    
    
    
    
    
    
    
                Tabs.Premium:AddButton({
        Title = "Clear Fake Guns From Inventory",
        Description = "",
        Callback = function()
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
        end
    })
    
    
    
    
    
    
    
    
                Tabs.Premium:AddButton({
        Title = "Break Sheriff Gun",
        Description = "",
        Callback = function()
for _, v in pairs(game:GetService("Players"):GetPlayers()) do
    if v ~= game.Players.LocalPlayer and v.Backpack:FindFirstChild("Gun") and v.Character ~= nil then
        v.Backpack.Gun.KnifeServer.ShootGun:InvokeServer(1, 0, "AH")
    elseif v ~= game.Players.LocalPlayer and v.Character:FindFirstChild("Gun") and v.Character ~= nil then
        v.Character.Gun.KnifeServer.ShootGun:InvokeServer(1, 0, "AH")
    end
end
        end
    })
    
    
    
    
    
    
    
    
    
        Tabs.Player:AddButton({
        Title = "Extra Life",
        Description = "",
        Callback = function()
local accessories = {}

function GodMode()
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
end

GodMode()
        end
    })



local players = game:GetService("Players")

local function UpdateplayerListPaint(Dropdown)
    local playerListPaint = {"All"}
    for _, player in pairs(players:GetPlayers()) do
        table.insert(playerListPaint, player.Name)
    end
    Dropdown:SetValues(playerListPaint)
end

-- Create the dropdown with player names
local Dropdown = Tabs.Premium:AddDropdown("Dropdown", {
    Title = "Paint",
    Values = {},  -- Start with an empty list
    Multi = false,
    Default = 0,
})

-- Update the dropdown with the current player list
UpdateplayerListPaint(Dropdown)

-- Callback function when dropdown value changes
Dropdown:OnChanged(function(fetarget)
    fetargetname = fetarget
end)

function EquipSpray()
    game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
    wait()
    for _, obj in pairs(players.LocalPlayer.Backpack:GetChildren()) do
        if obj.Name == "SprayPaint" then
            obj.Parent = players.LocalPlayer.Character
        end
    end
end

function fepenisfunc()
    -- Top Penis
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,-0.7))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,-1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,-1.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,-2))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Top, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,-2.5))
    
    ----Bottom Penis
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.3,-0.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.3,-1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.3,-1.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.3,-2))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Bottom, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.3,-2.5))

    -- Left Penis
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.15,-1.15,-0.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.15,-1.15,-1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.15,-1.15,-1.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.15,-1.15,-2))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Left, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.15,-1.15,-2.5))

    -- Right Penis
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.15,-1.15,-0.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.15,-1.15,-1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.15,-1.15,-1.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.15,-1.15,-2))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Right, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.15,-1.15,-2.5))
    
    -- Front Penis
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Front, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.15,-2.65))

    -- Left Sack
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.5,-1,-0.7))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Front, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.5,-1.15,-0.85))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.5,-1.3,-0.7))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.65,-1.15,-0.7))
    
    -- Right side
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.5,-1,-0.7))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Front, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.5,-1.15,-0.85))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.5,-1.3,-0.7))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.65,-1.15,-0.7))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Penis", Default = false })

Toggle:OnChanged(function(fepenis)
    if fepenis == true then
        fepenisloop = true
        while fepenisloop do
            function fepenisloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        fepenistarget = players:FindFirstChild(v.Name)
                        fepenisfunc()
                        task.wait()
                    end
                else
                    fepenistarget = players:FindFirstChild(fetargetname)
                    fepenisfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(fepenisloopfix)
        end
    end
    if fepenis == false then
        fepenisloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)


function feblackpenisfunc()
    -- Top Penis
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Top, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,-0.7))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Top, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,-1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Top, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,-1.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Top, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,-2))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Top, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,-2.5))
    
    ----Bottom Penis
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Bottom, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.3,-0.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Bottom, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.3,-1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Bottom, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.3,-1.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Bottom, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.3,-2))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Bottom, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.3,-2.5))

    -- Left Penis
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Left, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.15,-1.15,-0.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Left, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.15,-1.15,-1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Left, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.15,-1.15,-1.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Left, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.15,-1.15,-2))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Left, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.15,-1.15,-2.5))

    -- Right Penis
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Right, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.15,-1.15,-0.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Right, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.15,-1.15,-1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Right, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.15,-1.15,-1.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Right, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.15,-1.15,-2))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Right, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.15,-1.15,-2.5))
    
    -- Front Penis
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Front, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.15,-2.65))

    -- Left Sack
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Top, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.5,-1,-0.7))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Front, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.5,-1.15,-0.85))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Bottom, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.5,-1.3,-0.7))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Right, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.65,-1.15,-0.7))
    
    -- Right side
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Top, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.5,-1,-0.7))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Front, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.5,-1.15,-0.85))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Bottom, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.5,-1.3,-0.7))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Left, 0.5, (feblackpenistarget.Character.HumanoidRootPart), feblackpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.65,-1.15,-0.7))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Black Penis", Default = false })

Toggle:OnChanged(function(feblackpenis)
    if feblackpenis == true then
        feblackpenisloop = true
        while feblackpenisloop do
            function feblackpenisloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        feblackpenistarget = players:FindFirstChild(v.Name)
                        feblackpenisfunc()
                        task.wait()
                    end
                else
                    feblackpenistarget = players:FindFirstChild(fetargetname)
                    feblackpenisfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(feblackpenisloopfix)
        end
    end
    if feblackpenis == false then
        feblackpenisloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)




function nazigermanyfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(8, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(8, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(8, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(8, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(8, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-8, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-8, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-8, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-8, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-8, 14, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Nazi", Default = false })

Toggle:OnChanged(function(nazigermany)
    if nazigermany == true then
        nazigermanyloop = true
        while nazigermanyloop do
            function nazigermanyloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        nazigermanytarget = players:FindFirstChild(v.Name)
                        nazigermanyfunc()
                        task.wait()
                    end
                else
                    nazigermanytarget = players:FindFirstChild(fetargetname)
                    nazigermanyfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(nazigermanyloopfix)
        end
    end
    if nazigermany == false then
        nazigermanyloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)




function cumfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 3, (cumtarget.Character.RightHand), cumtarget.Character.RightHand.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Top, 3, (cumtarget.Character.LeftLowerArm), cumtarget.Character.LeftLowerArm.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Top, 3, (cumtarget.Character.RightLowerArm), cumtarget.Character.RightLowerArm.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 3, (cumtarget.Character.LeftUpperArm), cumtarget.Character.LeftUpperArm.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Right, 3, (cumtarget.Character.LowerTorso), cumtarget.Character.LowerTorso.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Left, 3, (cumtarget.Character.LeftLowerLeg), cumtarget.Character.LeftLowerLeg.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Top, 3, (cumtarget.Character.LeftUpperLeg), cumtarget.Character.LeftUpperLeg.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 3, (cumtarget.Character.LeftFoot), cumtarget.Character.LeftFoot.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 3, (cumtarget.Character.RightFoot), cumtarget.Character.RightFoot.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Left, 3, (cumtarget.Character.RightLowerLeg), cumtarget.Character.RightLowerLeg.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Right, 3, (cumtarget.Character.RightUpperLeg), cumtarget.Character.RightUpperLeg.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Left, 3, (cumtarget.Character.UpperTorso), cumtarget.Character.UpperTorso.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Right, 3, (cumtarget.Character.Head), cumtarget.Character.Head.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 3, (cumtarget.Character.Head), cumtarget.Character.Head.CFrame)
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Cum", Default = false })

Toggle:OnChanged(function(cum)
    if cum == true then
        cumloop = true
        while cumloop do
            function cumloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        cumtarget = players:FindFirstChild(v.Name)
                        cumfunc()
                        task.wait()
                    end
                else
                    cumtarget = players:FindFirstChild(fetargetname)
                    cumfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(cumloopfix)
        end
    end
    if cum == false then
        cumloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)




	
	
end


-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
