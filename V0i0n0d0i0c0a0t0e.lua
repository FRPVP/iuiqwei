 local Sound = Instance.new("Sound",game:GetService("SoundService"))
 Sound.SoundId = "rbxassetid://9120129807"
 Sound:Play()

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Vindicate " .. Fluent.Version,
    SubTitle = "MM2",
    TabWidth = 120,
    Size = UDim2.fromOffset(480, 360),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Aqua",
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


local section = Tabs.Player:AddSection("Mods")
    
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
    



local section = Tabs.Player:AddSection("Traverse Travel")

	
    
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
    






	
    
local flybutton = "" -- Empty string to remove the key binding
local flyparent = "HumanoidRootPart"
local flyspeed = 40

local invisible_subkey = ""
local invisiblebutton = "r"
local invisible_max_distance = 9e10

local controls = {
    front = "w",
    back = "s",
    right = "d",
    left = "a",
    up = "space",
    down = "leftcontrol",
    add_speed = "rightbracket",
    sub_speed = "leftbracket",
    reset_speed = "minus"
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

local Toggle = Tabs.Player:AddToggle("MyToggle", {Title = "Fly (R for Invisibility)", Default = false })

Toggle:OnChanged(function()
    flying = Toggle.Value
    if flying then
        fly()
    end
end)

Options.MyToggle:SetValue(false)

uis.InputBegan:Connect(function(keyinput, paused)
    if paused then return end

    local key = keyinput.KeyCode.Name:lower()

    if Toggle.Value then
        if key == invisiblebutton then
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
            flyspeed += 25
        end
        textgui.TextTransparency = 0
        textgui.Text = flyspeed
        wait(0.1)
        while uis:IsKeyDown(keyinput.KeyCode) do
            flyspeed += 25
            textgui.Text = flyspeed
            wait(0.05)
        end
        textgui.TextTransparency = 1
    elseif key == controls.sub_speed then
        if (flyspeed - 25) < 1 then
            flyspeed = 1
        else    
            flyspeed -= 25
        end
        textgui.TextTransparency = 0
        textgui.Text = flyspeed
        wait(0.1)
        while uis:IsKeyDown(keyinput.KeyCode) do
            if (flyspeed - 25) < 1 then
                flyspeed = 1
            else    
                flyspeed -= 25
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

uis.InputEnded:Connect(function(key, paused)
    if paused then return end

    key = key.KeyCode.Name:lower()

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
    flyspeed = vv
    end)

    Slider:SetValue(40)

    
    
    local Input = Tabs.Player:AddInput("Input", {
        Title = "Fly Speed",
        Default = "40",
        Placeholder = "Placeholder",
        Numeric = true, -- Only allows numbers
        Finished = true, -- Only calls callback when you press enter
        Callback = function(vv)
        flyspeed = vv
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
    
    
    


local section = Tabs.Player:AddSection("MM2")
	
    
    
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
    
    
    
    


local section = Tabs.Visual:AddSection("ESP")
	










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







local Toggle = Tabs.Visual:AddToggle("MyToggle", {Title = "Gun ESP", Default = false })

local BillboardGui = nil
local RenderSteppedConnection = nil
local Gun = Workspace:FindFirstChild("GunDrop")

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
    if Toggle.Value then
        CreateBillboardAboveGun(gun)
    end
end

local function OnGunRemoved(gun)
    DestroyBillboard()
end

Toggle:OnChanged(function()
    if Toggle.Value then
        if Gun then
            OnGunAdded(Gun)
        end
    else
        DestroyBillboard()
    end

    print("Toggle changed:", Toggle.Value)
end)

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

	



	



local Toggle = Tabs.Visual:AddToggle("", {Title = "Highlight Gun", Default = false })

local GunHighlight = nil
local GunHandleAdornment = nil
local RenderSteppedConnection = nil

Toggle:OnChanged(function()
    if Toggle.Value then
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

    print("Toggle changed:", Toggle.Value)
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





local section = Tabs.Visual:AddSection("Roles")	







Tabs.Visual:AddButton({
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

	


	

Tabs.Visual:AddButton({
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



local section = Tabs.Visual:AddSection("Spectate")





local section = Tabs.Trolling:AddSection("Perks")


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





	

local Stealth -- Declare Stealth variable outside of the scope

local Toggle = Tabs.Trolling:AddToggle("", {Title = "Ghost", Default = false })

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

local Toggle = Tabs.Trolling:AddToggle("", {Title = "Sprint Trail", Default = false })

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










Tabs.Trolling:AddButton({
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

local Toggle = Tabs.Trolling:AddToggle("", {Title = "Loop Traps", Default = false })

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
local Slider = Tabs.Trolling:AddSlider("Trap Spawn Delay", {
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
        Title = "Free Xbox Knife",
        Description = "",
        Callback = function()
	local Event = game:GetService("ReplicatedStorage").Remotes.Extras.IsXbox
	Event:FireServer(A_1)
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

-- Accessing the Toggle
local Toggle = Tabs.Visual:AddToggle("MyToggle", {Title = "View Gun", Default = false })

Toggle:OnChanged(function()
    if Toggle.Value then
        toggleCameraFocus()
    else
        -- Restore original camera focus (assuming it was on the player)
        local character = game.Players.LocalPlayer.Character
        local camera = game.Workspace.CurrentCamera
        camera.CameraSubject = character:FindFirstChildOfClass("Humanoid") or character.PrimaryPart
    end
end)

Options.MyToggle:SetValue(false)







	
    
    
    
        local function toggleSpectateMurderer()
    local isSpectating = Options.SpectateMurderer.Value

    if isSpectating then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and (player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife")) then
                game.Workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
                break
            end
        end
    else
        -- Restore original camera focus (assuming it was on the player)
        local character = game.Players.LocalPlayer.Character
        local camera = game.Workspace.CurrentCamera
        camera.CameraSubject = character:FindFirstChildOfClass("Humanoid") or character.PrimaryPart
    end
end

-- Accessing the Toggle
local Toggle = Tabs.Visual:AddToggle("SpectateMurderer", {Title = "Spectate Murderer", Default = false })

Toggle:OnChanged(function()
    toggleSpectateMurderer()
end)

Options.SpectateMurderer:SetValue(false)
    
    
    
    
    
    
    
    
    
    
        local function toggleSpectateSheriff()
    local spectatingEnabled = Options.SpectateSheriff.Value

    if spectatingEnabled then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and (player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun")) then
                game.Workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
                break
            end
        end
    else
        -- Restore original camera focus (assuming it was on the player)
        local character = game.Players.LocalPlayer.Character
        local camera = game.Workspace.CurrentCamera
        camera.CameraSubject = character:FindFirstChildOfClass("Humanoid") or character.PrimaryPart
    end
end

-- Accessing the Toggle
local Toggle = Tabs.Visual:AddToggle("SpectateSheriff", {Title = "Spectate Sheriff", Default = false })

Toggle:OnChanged(function()
    toggleSpectateSheriff()
end)

Options.SpectateSheriff:SetValue(false)
    
    
    
    

local section = Tabs.Combat:AddSection("Sheriff")

    
    
    
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
    
    
    
    local section = Tabs.Combat:AddSection("Murderer")
    









local section = Tabs.Teleport:AddSection("MM2")





	
    
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
    
    
    
    
    
local section = Tabs.Teleport:AddSection("Other")




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
    
    
    
    



local section = Tabs.Emotes:AddSection("MM2")


	
    
    
            Tabs.Emotes:AddButton({
        Title = "Get Emotes",
        Description = "",
        Callback = function()
require(game:GetService('ReplicatedStorage').Modules.EmoteModule).GeneratePage({"headless","zombie","zen","ninja","floss","dab","sit"},game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Game:FindFirstChild("Emotes"),'IDE-Ware Emotes')
        end
    })
    
    




local section = Tabs.Animations:AddSection("Roblox")

	


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
    
    
    
    
    



local section = Tabs.Premium:AddSection("Fake Gun")
	
    
    
    
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
    
    
    
    
    



local Toggle = Tabs.Premium:AddToggle("", {Title = "Fake Gun Rain", Default = false })

local dropGunEnabled = false
local dropGunConnection = nil

Toggle:OnChanged(function()
    local toggleValue = Toggle.Value
    print("Toggle changed:", toggleValue)
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
end)

Options.MyToggle:SetValue(false)





	
    
    

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
    
    
    
    


local section = Tabs.Premium:AddSection("Break Gun")

	
    
    
    
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
    
    
    




local Toggle = Tabs.Premium:AddToggle("", {Title = "Loop Break Gun", Default = false })

local loopBreakG = nil

Toggle:OnChanged(function(val)
    if val then
        loopBreakG = RS.RenderStepped:Connect(function()
            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Backpack:FindFirstChild("Gun") and v.Character ~= nil then
                    v.Backpack.Gun.KnifeServer.ShootGun:InvokeServer(1, 0, "AH")
                elseif v ~= game.Players.LocalPlayer and v.Character:FindFirstChild("Gun") and v.Character ~= nil then
                    v.Character.Gun.KnifeServer.ShootGun:InvokeServer(1, 0, "AH")
                end
            end
        end)
    else
        if loopBreakG then
            loopBreakG:Disconnect()
        end
    end
end)







	

local section = Tabs.Premium:AddSection("Trade")



	


local function SendTradeRequestToPlayer(targetPlayerName)
    local targetPlayer = game:GetService("Players"):FindFirstChild(targetPlayerName)

    if targetPlayer then
        local args = {
            [1] = targetPlayer
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Trade"):WaitForChild("SendRequest"):InvokeServer(unpack(args))

        game:GetService("ReplicatedStorage"):WaitForChild("Trade"):WaitForChild("AcceptRequest"):FireServer()
    else
        warn("Player not found:", targetPlayerName)
    end
end

local function UpdatePlayerDropdown(Dropdown)
    local playerList = {"All"}
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        table.insert(playerList, player.Name)
    end
    Dropdown:SetValues(playerList)
end

-- Create the dropdown with player names
local PlayerDropdown = Tabs.Premium:AddDropdown("PlayerDropdown", {
    Title = "Force Trade Target",
    Values = {},  -- Start with an empty list
    Multi = false,
    Default = 0,
})

-- Update the dropdown with the current player list
UpdatePlayerDropdown(PlayerDropdown)

-- Function to handle player join
local function OnPlayerAdded(player)
    UpdatePlayerDropdown(PlayerDropdown)
end

-- Function to handle player leaving
local function OnPlayerRemoving(player)
    UpdatePlayerDropdown(PlayerDropdown)
end

-- Connect player events
game:GetService("Players").PlayerAdded:Connect(OnPlayerAdded)
game:GetService("Players").PlayerRemoving:Connect(OnPlayerRemoving)

local selectedPlayer = "All" -- Default selected player

-- Callback function when dropdown value changes
PlayerDropdown:OnChanged(function(playerName)
    selectedPlayer = playerName
end)

Tabs.Premium:AddButton({
    Title = "Force Trade",
    Description = "",
    Callback = function()
        if selectedPlayer ~= "All" then
            SendTradeRequestToPlayer(selectedPlayer)
        else
            print("Please select a valid player.")
        end
    end
})



local function ToggleLoop()
    if selectedPlayer ~= "All" then
        while isLooping do
            SendTradeRequestToPlayer(selectedPlayer)
            wait(0) -- Adjust the delay as needed
        end
    else
        print("Please select a valid player.")
    end
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Loop Force Trade", Default = false })

Toggle:OnChanged(function()
    isLooping = Toggle.Value
    if isLooping then
        ToggleLoop()
    end
end)

Options.MyToggle:SetValue(false)




local section = Tabs.Premium:AddSection("Fling")	
    




Tabs.Premium:AddButton({
    Title = "Silent Fling Murderer",
    Description = "",
    Callback = function()
    local function OpsikFling(playerName)
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

    local checkForQuap = function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local Murder
    local LP = Players.LocalPlayer
    
    -- Functions --
    function CreateHighlight(player)
        local highlight = Instance.new("Highlight", player.Character)
        highlight.FillColor = Color3.fromRGB(225, 0, 0) -- Red color for the sheriff
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
            wait(0.5)  -- Shorter wait time after fling

            RemoveHighlight(player)  -- Remove the highlight after fling
        end
    end

    -- Get the player's role (assuming this is done once at the beginning)
    local roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    for i, v in pairs(roles) do
        if v.Role == "Murderer" then
            Murder = i
            local murderer = Players:FindFirstChild(Murder)
            if murderer then
                CreateHighlight(murderer)
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("Stealth"):FireServer(true)  -- Enable stealth
                wait(0.5)  -- Wait for 0.5 seconds with stealth enabled
                SkidFlingTarget(murderer)  -- Fling the highlighted murderer
                wait(0.5)  -- Wait for 0.5 seconds with stealth still enabled
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("Stealth"):FireServer(false)  -- Disable stealth
            end
            break  -- No need to continue checking once a murderer is found
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
    if Targets[1] and Targets[1]:lower() == "roar" then
        checkForQuap()
    end
end

-- Call the function to perform the fling when the script is executed with a player name
-- (e.g., "performFling 'playerName'" or "performFling 'murderer'")
OpsikFling("roar")
    end
})





Tabs.Premium:AddButton({
    Title = "Silent Fling Sheriff",
    Description = "",
    Callback = function()
    local function TreesFling(playerName)
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

    local checkForMonk = function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local Sheriff
    local LP = Players.LocalPlayer
    
    -- Functions --
    function CreateHighlight(player)
        local highlight = Instance.new("Highlight", player.Character)
        highlight.FillColor = Color3.fromRGB(0, 0, 225)
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
            wait(0.5)  -- Shorter wait time after fling

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
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("Stealth"):FireServer(true)  -- Enable stealth
                wait(0.5)  -- Wait for 0.5 seconds with stealth enabled
                SkidFlingTarget(sheriff)
                wait(0.5)  -- Wait for 0.5 seconds with stealth still enabled
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("Stealth"):FireServer(false)  -- Disable stealth
            end
            break
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
    if Targets[1] and Targets[1]:lower() == "cheese" then
        checkForMonk()
    end
end

-- Call the function to perform the fling when the script is executed with a player name
-- (e.g., "performFling 'playerName'" or "performFling 'murderer'")
TreesFling("cheese")
    end
})





	

local section = Tabs.Premium:AddSection("Spray Paint (Abusive)")




	

local players = game:GetService("Players")

local function UpdatePlayerListDropdown(Dropdown)
    local playerList = {"All"}
    for _, player in pairs(players:GetPlayers()) do
        table.insert(playerList, player.Name)
    end
    Dropdown:SetValues(playerList)
end

-- Create the dropdown with player names
local Dropdown = Tabs.Premium:AddDropdown("Dropdown", {
    Title = "Target",
    Values = {},  -- Start with an empty list
    Multi = false,
    Default = 0,
})

-- Update the dropdown with the current player list
UpdatePlayerListDropdown(Dropdown)

-- Function to handle player join
local function OnPlayerAdded(player)
    UpdatePlayerListDropdown(Dropdown)
end

-- Function to handle player leaving
local function OnPlayerRemoving(player)
    UpdatePlayerListDropdown(Dropdown)
end

-- Connect player events
players.PlayerAdded:Connect(OnPlayerAdded)
players.PlayerRemoving:Connect(OnPlayerRemoving)

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







function heatplayerfunc(heatplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(80373024, Enum.NormalId.Back, 15, (heatplayertarget.Character.Head), heatplayertarget.Character.Head.CFrame * CFrame.new(0, math.huge, 0))
end

Tabs.Premium:AddButton({
    Title = "Reset",
    Description = "",
    Icon = "", -- Replace "icon.png" with the path to your icon file
    Callback = function()
        -- Check if a name is selected
        if fetargetname == "All" then
            EquipSpray() -- Equip the spray first
            -- Iterate over all players and execute heatplayerfunc on each player except yourself
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player ~= game:GetService("Players").LocalPlayer then
                    heatplayerfunc(player)
                end
            end
        elseif fetargetname ~= "" then
            EquipSpray() -- Equip the spray first
            -- Find the player with the selected name
            local heatplayertarget = game:GetService("Players"):FindFirstChild(fetargetname)
            if heatplayertarget then
                heatplayerfunc(heatplayertarget) -- Execute heatplayerfunc on the player
            else
                print("Player not found.")
            end
        else
            print("Please select a name from the dropdown.")
        end
    end
})

	



function resetplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(80373024, Enum.NormalId.Back, 15, (resetplayertarget.Character.Head), resetplayertarget.Character.Head.CFrame * CFrame.new(0, math.huge, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Loop Reset", Default = false })

Toggle:OnChanged(function(resetplayer)
    if resetplayer == true then
        resetplayerloop = true
        while resetplayerloop do
            function resetplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            resetplayertarget = players:FindFirstChild(v.Name)
                            resetplayerfunc()
                            task.wait()
                        end
                    end
                else
                    resetplayertarget = players:FindFirstChild(fetargetname)
                    resetplayerfunc()
                end
                task.wait(0)
            end
            wait()
            pcall(resetplayerloopfix)
        end
    end
    if resetplayer == false then
        resetplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)







function reerplayerfunc(reerplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Back, 6.331, (reerplayertarget.Character.HumanoidRootPart), reerplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 99999, 0))
end

Tabs.Premium:AddButton({
    Title = "Remove Collides (15sec)",
    Description = "",
    Icon = "", -- Replace "icon.png" with the path to your icon file
    Callback = function()
        -- Check if a name is selected
        if fetargetname == "All" then
            EquipSpray() -- Equip the spray first
            -- Iterate over all players and execute reerplayerfunc on each player except yourself
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player ~= game:GetService("Players").LocalPlayer then
                    reerplayerfunc(player)
                end
            end
        elseif fetargetname ~= "" then
            EquipSpray() -- Equip the spray first
            -- Find the player with the selected name
            local reerplayertarget = game:GetService("Players"):FindFirstChild(fetargetname)
            if reerplayertarget then
                reerplayerfunc(reerplayertarget) -- Execute reerplayerfunc on the player
            else
                print("Player not found.")
            end
        else
            print("Please select a name from the dropdown.")
        end
    end
})






function collideplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Back, 6.331, (collideplayertarget.Character.HumanoidRootPart), collideplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 99999, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Loop Remove Collides", Default = false })

Toggle:OnChanged(function(collideplayer)
    if collideplayer == true then
        collideplayerloop = true
        while collideplayerloop do
            function collideplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            collideplayertarget = players:FindFirstChild(v.Name)
                            collideplayerfunc()
                            task.wait()
                        end
                    end
                else
                    collideplayertarget = players:FindFirstChild(fetargetname)
                    collideplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(collideplayerloopfix)
        end
    end
    if collideplayer == false then
        collideplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)







function poolplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Top, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Bottom, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Bottom, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Top, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Front, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Back, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Front, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Back, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Right, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Left, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Right, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Left, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Blind", Default = false })

Toggle:OnChanged(function(poolplayer)
    if poolplayer == true then
        poolplayerloop = true
        while poolplayerloop do
            function poolplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            poolplayertarget = players:FindFirstChild(v.Name)
                            poolplayerfunc()
                            task.wait()
                        end
                    end
                else
                    poolplayertarget = players:FindFirstChild(fetargetname)
                    poolplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(poolplayerloopfix)
        end
    end
    if poolplayer == false then
        poolplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)










Tabs.Premium:AddButton({
    Title = "Steal Gun From Sheriff",
    Description = "",
    Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local Sheriff -- Variable to store the player with the Sheriff role
local SprayExecuted = false -- Flag to track whether the spray script has been executed

-- > Additional Script < --

-- Get references to the player and workspace
local player = game.Players.LocalPlayer
local workspace = game:GetService("Workspace")

-- Variable to store the original position
local originalPosition = player.Character.HumanoidRootPart.CFrame

-- Function to find and teleport to the GunDrop part
local function teleportToGunDrop()
    local gunDrop = workspace:FindFirstChild("GunDrop") -- Check if GunDrop exists in Workspace

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

-- > Functions <--

function FindSheriff()
    if not Sheriff then
        for _, v in pairs(Players:GetChildren()) do
            if v ~= LP then
                local playerData = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
                local role = playerData[v.Name]
                if role and role.Role == "Sheriff" then
                    Sheriff = v
                    if Sheriff ~= LP and not SprayExecuted then
                        ExecuteSprayScript() -- Execute the spray script when Sheriff is found
                        SprayExecuted = true
                        teleportToGunDrop() -- Execute the teleport script after the spray script
                    end
                    break
                end
            end
        end
    end
end

function ExecuteSprayScript()
    if LP.Character and Sheriff then
        local args = {
            [1] = 80373024,
            [2] = Enum.NormalId.Back,
            [3] = 15,
            [4] = workspace[Sheriff.Name].Head,
            [5] = CFrame.new(0, math.huge, 0)
        }
        if LP.Backpack.Toys:FindFirstChild("SprayPaint") then
            ReplicateToy("SprayPaint", 2) -- Replicate SprayPaint twice
            LP.Backpack.SprayPaint.Parent = LP.Character
            LP.Character.SprayPaint.Remote:FireServer(unpack(args))
            LP.Character.SprayPaint.Parent = LP.Backpack
        elseif LP.Backpack:FindFirstChild("SprayPaint") then
            LP.Backpack.SprayPaint.Parent = LP.Character
            LP.Character.SprayPaint.Remote:FireServer(unpack(args))
            LP.Character.SprayPaint.Parent = LP.Backpack
        elseif LP.Character:FindFirstChild("SprayPaint") then
            LP.Character.SprayPaint.Remote:FireServer(unpack(args))
        end
    end
end

function ReplicateToy(toyName, replicateCount)
    local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras")
    local replicateToyRemote = remotes:WaitForChild("ReplicateToy")
    
    for _ = 1, replicateCount do
        replicateToyRemote:InvokeServer(toyName)
    end
end

-- > Loop < --

RunService.RenderStepped:Connect(function()
    FindSheriff()
end)
end
})







function feslipfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (fesliptarget.Character.LeftUpperLeg), fesliptarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (fesliptarget.Character.LeftUpperLeg), fesliptarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -2, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Slip Up", Default = false })

Toggle:OnChanged(function(feslip)
    if feslip == true then
        fesliploop = true
        while fesliploop do
            function fesliploopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            fesliptarget = players:FindFirstChild(v.Name)
                            feslipfunc()
                            task.wait()
                        end
                    end
                else
                    fesliptarget = players:FindFirstChild(fetargetname)
                    feslipfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(fesliploopfix)
        end
    end
    if feslip == false then
        fesliploop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)










function opiwhdaplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Back, 6.331, (opiwhdaplayertarget.Character.HumanoidRootPart), opiwhdaplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 99999, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (opiwhdaplayertarget.Character.LeftUpperLeg), opiwhdaplayertarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -100, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (opiwhdaplayertarget.Character.LeftUpperLeg), opiwhdaplayertarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -100, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Void", Default = false })

Toggle:OnChanged(function(opiwhdaplayer)
    if opiwhdaplayer == true then
        opiwhdaplayerloop = true
        while opiwhdaplayerloop do
            function opiwhdaplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            opiwhdaplayertarget = players:FindFirstChild(v.Name)
                            opiwhdaplayerfunc()
                            task.wait()
                        end
                    end
                else
                    opiwhdaplayertarget = players:FindFirstChild(fetargetname)
                    opiwhdaplayerfunc()
                end
                task.wait(0)
            end
            wait()
            pcall(opiwhdaplayerloopfix)
        end
    end
    if opiwhdaplayer == false then
        opiwhdaplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)










	
	


local section = Tabs.Premium:AddSection("Spray Paint (Fun)")





	

local players = game:GetService("Players")

local function QuantumLeapPlayerList(Dropdown)
    local playerList = {"All"}
    for _, player in pairs(players:GetPlayers()) do
        table.insert(playerList, player.Name)
    end
    Dropdown:SetValues(playerList)
end

local Dropdown = Tabs.Premium:AddDropdown("Dropdown", {
    Title = "Target",
    Values = {},
    Multi = false,
    Default = 0,
})

QuantumLeapPlayerList(Dropdown)

local function HyperdriveEngage(player)
    QuantumLeapPlayerList(Dropdown)
end

local function WormholeExit(player)
    QuantumLeapPlayerList(Dropdown)
end

players.PlayerAdded:Connect(HyperdriveEngage)
players.PlayerRemoving:Connect(WormholeExit)

Dropdown:OnChanged(function(infinityStones)
    infinityGauntlet = infinityStones
end)








function febigpenisfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.9, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.5, -2.9, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.5, -2.9, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.5, -0.6, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -0.6, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.5, -0.6, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Left, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-3.65, -1.75, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Right, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(3.65, -1.75, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Front, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.5, -1.75, -3.15))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Front, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.5, -1.75, -3.15))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Back, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.5, -1.75, -0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Back, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -1.75, -0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Back, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.5, -1.75, -0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Left, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-1.15, -1.75, -4.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Right, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(1.15, -1.75, -4.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Left, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-1.15, -1.75, -6.75))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Right, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(1.15, -1.75, -6.75))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -0.6, -4.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -0.6, -6.75))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.9, -4.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.9, -6.75))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Left, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-1.15, -1.75, -9))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Right, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(1.15, -1.75, -9))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Top, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -0.6, -9))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Bottom, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.9, -9))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2.5, (febigpenistarget.Character.HumanoidRootPart), febigpenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -1.75, -10.15))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Big Penis", Default = false })

Toggle:OnChanged(function(febigpenis)
    if febigpenis == true then
        febigpenisloop = true
        while febigpenisloop do
            function febigpenisloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        febigpenistarget = players:FindFirstChild(v.Name)
                        febigpenisfunc()
                        task.wait()
                    end
                else
                    febigpenistarget = players:FindFirstChild(infinityGauntlet)
                    febigpenisfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(febigpenisloopfix)
        end
    end
    if febigpenis == false then
        febigpenisloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)








local Players = game:GetService("Players")
local penisId = 60484593  -- Default spray ID

function allowpenisfunc()
    local localPlayer = Players.LocalPlayer
    local target = allowpenistarget
    local humanoidRootPart = target.Character.HumanoidRootPart
    
    -- Top Penis
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -2.5))

    -- Bottom Penis
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -2.5))

    -- Left Penis
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -2.5))

    -- Right Penis
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -2.5))

    -- Front Penis
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.15, -2.65))

    -- Left Sack
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1.15, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1.3, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.65, -1.15, -0.7))

    -- Right Sack
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1.15, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1.3, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(penisId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.65, -1.15, -0.7))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Penis", Default = false})

Toggle:OnChanged(function(allowpenis)
    if allowpenis then
        allowpenisloop = true
        while allowpenisloop do
            local function allowpenisloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, player in pairs(Players:GetPlayers()) do
                        allowpenistarget = Players:FindFirstChild(player.Name)
                        if allowpenistarget then
                            allowpenisfunc()
                            task.wait()
                        end
                    end
                else
                    allowpenistarget = Players:FindFirstChild(infinityGauntlet)
                    if allowpenistarget then
                        allowpenisfunc()
                    end
                end
                task.wait(15)
            end
            wait()
            pcall(allowpenisloopfix)
        end
    else
        allowpenisloop = false
    end
end)

local Input = Tabs.Premium:AddInput("Input", {
    Title = "ID",
    Default = tostring(penisId),
    Placeholder = "Enter Spray ID",
    Numeric = true, -- Only allows numbers
    Finished = false, -- Only calls callback when you press enter
    Callback = function(Value)
        penisId = tonumber(Value) or penisId
        print("Spray ID changed:", penisId)
    end
})

Input:OnChanged(function()
    penisId = tonumber(Input.Value) or penisId
    print("Spray ID updated:", penisId)
end)

Options.MyToggle:SetValue(false)










local Players = game:GetService("Players")
local bigpenisId = 60484593  -- Default spray ID

function allowbigpenisfunc()
    local localPlayer = Players.LocalPlayer
    local target = allowbigpenistarget
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

local Toggle = Tabs.Premium:AddToggle("", {Title = "Big Penis", Default = false })

Toggle:OnChanged(function(allowbigpenis)
    if allowbigpenis then
        allowbigpenisloop = true
        while allowbigpenisloop do
            local function allowbigpenisloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, player in pairs(Players:GetPlayers()) do
                        allowbigpenistarget = Players:FindFirstChild(player.Name)
                        if allowbigpenistarget then
                            allowbigpenisfunc()
                            task.wait()
                        end
                    end
                else
                    allowbigpenistarget = Players:FindFirstChild(infinityGauntlet)
                    if allowbigpenistarget then
                        allowbigpenisfunc()
                    end
                end
                task.wait(15)
            end
            wait()
            pcall(allowbigpenisloopfix)
        end
    else
        allowbigpenisloop = false
    end
end)

local Input = Tabs.Premium:AddInput("Input", {
    Title = "ID",
    Default = tostring(bigpenisId),
    Placeholder = "Enter Spray ID",
    Numeric = true, -- Only allows numbers
    Finished = false, -- Only calls callback when you press enter
    Callback = function(Value)
        bigpenisId = tonumber(Value) or bigpenisId
        print("Spray ID changed:", bigpenisId)
    end
})

Input:OnChanged(function()
    bigpenisId = tonumber(Input.Value) or bigpenisId
    print("Spray ID updated:", bigpenisId)
end)

Options.MyToggle:SetValue(false)









function cumplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14976845153, Enum.NormalId.Front, 1.5, (cumplayertarget.Character.HumanoidRootPart), cumplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.15,-2.90))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Cum on Penis", Default = false })

Toggle:OnChanged(function(cumplayer)
    if cumplayer == true then
        cumplayerloop = true
        while cumplayerloop do
            function cumplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        cumplayertarget = players:FindFirstChild(v.Name)
                        cumplayerfunc()
                        task.wait()
                    end
                else
                    cumplayertarget = players:FindFirstChild(infinityGauntlet)
                    cumplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(cumplayerloopfix)
        end
    end
    if cumplayer == false then
        cumplayerloop = false
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
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        nazigermanytarget = players:FindFirstChild(v.Name)
                        nazigermanyfunc()
                        task.wait()
                    end
                else
                    nazigermanytarget = players:FindFirstChild(infinityGauntlet)
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






	


function communistplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(6978648716, Enum.NormalId.Front, 5, (communistplayertarget.Character.HumanoidRootPart), communistplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,5,0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Communist", Default = false })

Toggle:OnChanged(function(communistplayer)
    if communistplayer == true then
        communistplayerloop = true
        while communistplayerloop do
            function communistplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        communistplayertarget = players:FindFirstChild(v.Name)
                        communistplayerfunc()
                        task.wait()
                    end
                else
                    communistplayertarget = players:FindFirstChild(infinityGauntlet)
                    communistplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(communistplayerloopfix)
        end
    end
    if communistplayer == false then
        communistplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)









function faceplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12579922286, Enum.NormalId.Bottom, 500, (faceplayertarget.Character.HumanoidRootPart), faceplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 500, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Sky Watcher", Default = false })

Toggle:OnChanged(function(faceplayer)
    if faceplayer == true then
        faceplayerloop = true
        while faceplayerloop do
            function faceplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            faceplayertarget = players:FindFirstChild(v.Name)
                            faceplayerfunc()
                            task.wait()
                        end
                    end
                else
                    faceplayertarget = players:FindFirstChild(infinityGauntlet)
                    faceplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(faceplayerloopfix)
        end
    end
    if faceplayer == false then
        faceplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)









function trollplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(10193511157, Enum.NormalId.Front, 1.5, (trollplayertarget.Character.HumanoidRootPart), trollplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,1.2,-1))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Troll Face", Default = false })

Toggle:OnChanged(function(trollplayer)
    if trollplayer == true then
        trollplayerloop = true
        while trollplayerloop do
            function trollplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            trollplayertarget = players:FindFirstChild(v.Name)
                            trollplayerfunc()
                            task.wait()
                        end
                    end
                else
                    trollplayertarget = players:FindFirstChild(infinityGauntlet)
                    trollplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(trollplayerloopfix)
        end
    end
    if trollplayer == false then
        trollplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)









Tabs.Premium:AddButton({
    Title = "Minecraft Blocks",
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
tool.Name = "Lava (Kills)"
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
end
})









function laughplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12877195347, Enum.NormalId.Front, 1.5, (laughplayertarget.Character.HumanoidRootPart), laughplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,1.2,-1))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "LOL", Default = false })

Toggle:OnChanged(function(laughplayer)
    if laughplayer == true then
        laughplayerloop = true
        while laughplayerloop do
            function laughplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        laughplayertarget = players:FindFirstChild(v.Name)
                        laughplayerfunc()
                        task.wait()
                    end
                else
                    laughplayertarget = players:FindFirstChild(infinityGauntlet)
                    laughplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(laughplayerloopfix)
        end
    end
    if laughplayer == false then
        laughplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)








function phubplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17189770364, Enum.NormalId.Front, 5, (phubplayertarget.Character.HumanoidRootPart), phubplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,5,0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "PHub Logo", Default = false })

Toggle:OnChanged(function(phubplayer)
    if phubplayer == true then
        phubplayerloop = true
        while phubplayerloop do
            function phubplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        phubplayertarget = players:FindFirstChild(v.Name)
                        phubplayerfunc()
                        task.wait()
                    end
                else
                    phubplayertarget = players:FindFirstChild(infinityGauntlet)
                    phubplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(phubplayerloopfix)
        end
    end
    if phubplayer == false then
        phubplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)









function filedownplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(15093138669, Enum.NormalId.Right, 3, (filedownplayertarget.Character.RightHand), filedownplayertarget.Character.RightHand.CFrame * CFrame.new(0, 0, -0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(15096522641, Enum.NormalId.Left, 3, (filedownplayertarget.Character.RightHand), filedownplayertarget.Character.RightHand.CFrame * CFrame.new(0, 0, -0.7))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Fake Knife", Default = false })

Toggle:OnChanged(function(filedownplayer)
    if filedownplayer == true then
        filedownplayerloop = true
        while filedownplayerloop do
            function filedownplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        filedownplayertarget = players:FindFirstChild(v.Name)
                        filedownplayerfunc()
                        task.wait()
                    end
                else
                    filedownplayertarget = players:FindFirstChild(infinityGauntlet)
                    filedownplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(filedownplayerloopfix)
        end
    end
    if filedownplayer == false then
        filedownplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)









local Players = game:GetService("Players")
local sprayId = 12781220539  -- Default spray ID

function sprayGood(target)
    local localPlayer = Players.LocalPlayer
    local humanoidRootPart = target.Character.HumanoidRootPart
    local cFrameOffsets = {
        {Enum.NormalId.Top, CFrame.new(0, 3, 0)},
        {Enum.NormalId.Bottom, CFrame.new(0, 3.15, 0)},
        {Enum.NormalId.Bottom, CFrame.new(0, -2.8, 0)},
        {Enum.NormalId.Top, CFrame.new(0, -3, 0)},
        {Enum.NormalId.Front, CFrame.new(0, 0.1, 3.1)},
        {Enum.NormalId.Back, CFrame.new(0, 0.1, 2.86)},
        {Enum.NormalId.Front, CFrame.new(0, 0.1, -2.86)},
        {Enum.NormalId.Back, CFrame.new(0, 0.1, -3.1)},
        {Enum.NormalId.Right, CFrame.new(2.86, 0.1, 0)},
        {Enum.NormalId.Left, CFrame.new(3.1, 0.1, 0)},
        {Enum.NormalId.Right, CFrame.new(-3.1, 0.1, 0)},
        {Enum.NormalId.Left, CFrame.new(-2.86, 0.1, 0)}
    }
    for _, offset in pairs(cFrameOffsets) do
        localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, offset[1], 6, humanoidRootPart, humanoidRootPart.CFrame * offset[2])
    end
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Box Player", Default = false})

Toggle:OnChanged(function(lkasdjplayer)
    if lkasdjplayer == true then
        lkasdjplayerloop = true
        while lkasdjplayerloop do
            function lkasdjplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(Players:GetPlayers()) do
                        local lkasdjplayertarget = Players:FindFirstChild(v.Name)
                        if lkasdjplayertarget then
                            sprayGood(lkasdjplayertarget)
                            task.wait()
                        end
                    end
                else
                    local lkasdjplayertarget = Players:FindFirstChild(infinityGauntlet)
                    if lkasdjplayertarget then
                        sprayGood(lkasdjplayertarget)
                    end
                end
                task.wait(15)
            end
            wait()
            pcall(lkasdjplayerloopfix)
        end
    else
        lkasdjplayerloop = false
    end
end)

local Input = Tabs.Premium:AddInput("Input", {
    Title = "ID",
    Default = tostring(sprayId),
    Placeholder = "Enter Spray ID",
    Numeric = true, -- Only allows numbers
    Finished = false, -- Only calls callback when you press enter
    Callback = function(Value)
        sprayId = tonumber(Value) or sprayId
        print("Spray ID changed:", sprayId)
    end
})

Input:OnChanged(function()
    sprayId = tonumber(Input.Value) or sprayId
    print("Spray ID updated:", sprayId)
end)

Options.MyToggle:SetValue(false)










local section = Tabs.Trolling:AddSection("Fling")




	



local playersService = game:GetService("Players")

local function UpdateTargetListDropdown(Dropdown)
    local targetList = {"All"}
    for _, player in pairs(playersService:GetPlayers()) do
        table.insert(targetList, player.Name)
    end
    Dropdown:SetValues(targetList)
end

-- Create the dropdown with player names
local Dropdown = Tabs.Trolling:AddDropdown("", {
    Title = "Select Fling Target",
    Values = {},  -- Start with an empty list
    Multi = false,
    Default = 0,
})

-- Update the dropdown with the current player list
UpdateTargetListDropdown(Dropdown)

-- Function to handle player join
local function OnPlayerAdded(player)
    UpdateTargetListDropdown(Dropdown)
end

-- Function to handle player leaving
local function OnPlayerRemoving(player)
    UpdateTargetListDropdown(Dropdown)
end

-- Connect player events
playersService.PlayerAdded:Connect(OnPlayerAdded)
playersService.PlayerRemoving:Connect(OnPlayerRemoving)

-- Callback function when dropdown value changes
Dropdown:OnChanged(function(selectedTarget)
    selectedTargetName = selectedTarget
end)






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

Tabs.Trolling:AddButton({
    Title = "Fling",
    Description = "",
    Callback = function()
        performFling(selectedTargetName)
    end
})





local Toggle = Tabs.Trolling:AddToggle("", {Title = "Loop Fling", Default = false })

Toggle:OnChanged(function()
    if Toggle.Value then
        print("Flinging enabled")
        while Toggle.Value do
            performFling(selectedTargetName)
            wait(1) -- Adjust this delay as needed
        end
        print("Flinging disabled")
    end
end)

Options.MyToggle:SetValue(false)








Tabs.Trolling:AddButton({
    Title = "Fling Murderer",
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
	end
})







Tabs.Trolling:AddButton({
    Title = "Fling Murderer V2",
    Description = "",
    Callback = function()
    local function MurdFling(playerName)
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

    local checkForMurderer = function()
        for _, v in pairs(game.Players:GetPlayers()) do
            local character = v.Character
            local backpack = v.Backpack
            
            if character and backpack then
                local knife = character:FindFirstChild("Knife") or backpack:FindFirstChild("Knife")
                if knife then
                    SkidFling(v)
                    rsMurdererExecuted = true  -- Set the executed state
                    break  -- Exit the loop after the first fling
                end
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
    if Targets[1] and Targets[1]:lower() == "murderer" then
        checkForMurderer()
    end
end

-- Call the function to perform the fling when the script is executed with a player name
-- (e.g., "performFling 'playerName'" or "performFling 'murderer'")
MurdFling("murderer")
    end
})





Tabs.Trolling:AddButton({
    Title = "Fling Sheriff",
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
    end
})






Tabs.Trolling:AddButton({
    Title = "Fling Sheriff V2",
    Description = "",
    Callback = function()
    local function SheriffFling(playerName)
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

    local checkForSheriff = function()
        for _, v in pairs(game.Players:GetPlayers()) do
            local character = v.Character
            local backpack = v.Backpack
            
            if character and backpack then
                local gun = character:FindFirstChild("Gun") or backpack:FindFirstChild("Gun")
                if gun then
                    SkidFling(v)
                    rsSheriffExecuted = true  -- Set the executed state
                    break  -- Exit the loop after the first fling
                end
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
    if Targets[1] and Targets[1]:lower() == "sheriff" then
        checkForSheriff()
    end
end

-- Call the function to perform the fling when the script is executed with a player name
-- (e.g., "performFling 'playerName'" or "performFling 'murderer'")
SheriffFling("sheriff")
    end
})






Tabs.Trolling:AddButton({
    Title = "Fling Sheriff & Murderer",
    Description = "",
    Callback = function()
    local function SheriffmurdFling(playerName)
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
                    return Message("Error Occurred", "Targeting is sitting", 5)
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

        local checkForSheriffandMurd = function()
            local foundGun = false
            local foundKnife = false
            for _, v in pairs(game.Players:GetPlayers()) do
                local character = v.Character
                local backpack = v.Backpack

                if character and backpack then
                    local gun = character:FindFirstChild("Gun") or backpack:FindFirstChild("Gun")
                    local knife = character:FindFirstChild("Knife") or backpack:FindFirstChild("Knife")
                    if gun and not foundGun then
                        SkidFling(v)
                        foundGun = true
                    elseif knife and not foundKnife then
                        SkidFling(v)
                        foundKnife = true
                    end
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
                local TPlayer = GetPlayer(x)
                if TPlayer then
                    SkidFling(TPlayer)
                end
            end
        end

        -- Check for the "sheriff" and execute the corresponding logic
        if Targets[1] and Targets[1]:lower() == "sheriffandmurd" then
            checkForSheriffandMurd()
        end
    end

    -- Call the function to perform the fling when the script is executed with a player name
    -- (e.g., "performFling 'playerName'" or "performFling 'sheriff'")
    SheriffmurdFling("sheriffandmurd")
    end
})







local TouchFlig = nil -- Declare TouchFlig outside the toggle function
local hiddenfling = false -- Declare hiddenfling outside the toggle function

local Toggle = Tabs.Trolling:AddToggle("", {Title = "Touch Fling", Default = false})

Toggle:OnChanged(function(val)
    if val then
        if not TouchFlig then -- Check if TouchFlig is not already connected
            TouchFlig = RS.RenderStepped:Connect(function()
                hiddenfling = false

                local function enableWalkfling()
                    if game:GetService("ReplicatedStorage"):FindFirstChild("juisdfj0i32i0eidsuf0iok") then
                        hiddenfling = true
                    else
                        hiddenfling = true
                        local detection = Instance.new("Decal")
                        detection.Name = "juisdfj0i32i0eidsuf0iok"
                        detection.Parent = game:GetService("ReplicatedStorage")

                        -- Fling function
                        local function fling()
                            local hrp, c, vel, movel = nil, nil, nil, 0.1
                            while true do
                                game:GetService("RunService").Heartbeat:Wait()
                                if hiddenfling then
                                    local lp = game.Players.LocalPlayer
                                    while hiddenfling and not (c and c.Parent and hrp and hrp.Parent) do
                                        game:GetService("RunService").Heartbeat:Wait()
                                        c = lp.Character
                                        hrp = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
                                    end
                                    if hiddenfling then
                                        vel = hrp.Velocity
                                        hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
                                        game:GetService("RunService").RenderStepped:Wait()
                                        if c and c.Parent and hrp and hrp.Parent then
                                            hrp.Velocity = vel
                                        end
                                        game:GetService("RunService").Stepped:Wait()
                                        if c and c.Parent and hrp and hrp.Parent then
                                            hrp.Velocity = vel + Vector3.new(0, movel, 0)
                                            movel = movel * -1
                                        end
                                    end
                                end
                            end
                        end

                        fling()
                    end
                end

                -- Call the function to enable walkfling when the script is executed
                enableWalkfling()
            end)
        end
    else
        if TouchFlig then -- Check if TouchFlig is connected
            TouchFlig:Disconnect() -- Disconnect TouchFlig
            TouchFlig = nil -- Set TouchFlig to nil to indicate it's disconnected
            hiddenfling = false
        end
    end
end)








local section = Tabs.Trolling:AddSection("Roles")

	




Tabs.Trolling:AddButton({
    Title = "Take The Murderer's Knife",
    Description = "",
    Callback = function()
    for i,s in pairs(Players:GetPlayers()) do
if s ~= Players.LocalPlayer and s.Backpack:FindFirstChild("Knife") or s.Character:FindFirstChild("Knife") then
s.Backpack.Knife.Parent = Players.LocalPlayer.Backpack
end
end
end
})





Tabs.Trolling:AddButton({
    Title = "Take The Sheriff's Gun",
    Description = "Shoot a player to break the gun!",
    Callback = function()
    for i,s in pairs(Players:GetPlayers()) do
if s ~= Players.LocalPlayer and s.Backpack:FindFirstChild("Gun") or s.Character:FindFirstChild("Gun") then
s.Backpack.Gun.Parent = Players.LocalPlayer.Backpack
end
end
end
})






local section = Tabs.Trolling:AddSection("Others")






Tabs.Trolling:AddButton({
    Title = "2 Lives",
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
    end
})













local section = Tabs.Animations:AddSection("MM2")






Tabs.Animations:AddButton({
    Title = "Break Your Arm",
    Description = "you will soon realize it's literal (reset a couple of times to fix)",
    Callback = function()
    local lp = game.Players.LocalPlayer
local knife = lp.Character:WaitForChild("KnifeDisplay")
knife.Massless = true

local animation1 = Instance.new("Animation")
animation1.AnimationId = "rbxassetid://2467567750"
local animation2 = Instance.new("Animation")
animation2.AnimationId = "rbxassetid://1957890538"
local anims = {animation1, animation2}

-- Play the animation continuously
while wait(0.1) do
    local an = lp.Character.Humanoid:LoadAnimation(anims[math.random(1, 2)])
    an:Play()
end

local aa = Instance.new("Attachment")
local ba = Instance.new("Attachment")
local hinge = Instance.new("HingeConstraint", knife)
hinge.Attachment0 = aa
hinge.Attachment1 = ba
hinge.LimitsEnabled = true
hinge.LowerAngle = 0
hinge.Restitution = 0
hinge.UpperAngle = 0

for _, v in pairs(lp.Character:WaitForChild("UpperTorso"):GetChildren()) do
    if v:IsA("Weld") and v.Part1 == knife then
        v:Destroy()
        break
    end
end

game:GetService("RunService").Heartbeat:Connect(function()
    setsimulationradius(1 / 0, 1 / 0)
    if lp.Character and knife then
        knife.CFrame = lp.Character:WaitForChild("UpperTorso").CFrame * CFrame.new(-0.200027466, -0.399999619, 0.5, 3.22982669e-05, -0.707153201, 0.707060337, 1.33886933e-05, 0.707060337, 0.707153141, -1, -1.33812428e-05, 3.22982669e-05)
    end
end)
end
})



local section = Tabs.Settings:AddSection("Player")

Tabs.Settings:AddButton({
    Title = "Reset Yourself",
    Description = "",
    Callback = function()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Function to reset the character
local function resetCharacter()
    character:BreakJoints()
end

-- Reset the character immediately upon script execution
resetCharacter()
end
})




Tabs.Settings:AddButton({
    Title = "Kick Yourself",
    Description = "",
    Callback = function()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function KickPlayer()
    LocalPlayer:Kick("You have been kicked from the server.")
end

KickPlayer()
end
})









Tabs.Settings:AddButton({
    Title = "Rejoin",
    Description = "",
    Callback = function()
-- Function to rejoin the server
local function RejoinServer()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end

-- Call the function to rejoin the server
RejoinServer()
end
})




local section = Tabs.Settings:AddSection("World")




Tabs.Settings:AddButton({
    Title = "RTX",
    Description = "",
    Callback = function()
local find1 = game.Lighting:FindFirstChildWhichIsA("BloomEffect") if find1 then
    game.Lighting:FindFirstChildWhichIsA("BloomEffect"):Destroy()
end
local find2 = game.Lighting:FindFirstChildWhichIsA("SunRaysEffect") if find2 then
    game.Lighting:FindFirstChildWhichIsA("SunRaysEffect"):Destroy()
end
local find3 = game.Lighting:FindFirstChildWhichIsA("ColorCorrectionEffect") if find3 then
    game.Lighting:FindFirstChildWhichIsA("ColorCorrectionEffect"):Destroy()
end
local find4 = game.Lighting:FindFirstChildWhichIsA("BlurEffect") if find4 then
    game.Lighting:FindFirstChildWhichIsA("BlurEffect"):Destroy()
end
local find5 = game.Lighting:FindFirstChildWhichIsA("Sky") if find5 then
    game.Lighting:FindFirstChildWhichIsA("Sky"):Destroy()
end
local blem = Instance.new("BloomEffect",game.Lighting)
local sanrey = Instance.new("SunRaysEffect",game.Lighting)
local color = Instance.new("ColorCorrectionEffect",game.Lighting)
local blor = Instance.new("BlurEffect",game.Lighting)
Instance.new("Sky",game.Lighting)
game.Lighting.ExposureCompensation = 0.34
game.Lighting.ShadowSoftness = 1
game.Lighting.EnvironmentDiffuseScale = 0.343
game.Lighting.EnvironmentSpecularScale = 1
game.Lighting.Brightness = 2
game.Lighting.ColorShift_Top = Color3.fromRGB(118,117,108)
game.Lighting.OutdoorAmbient = Color3.fromRGB(141,141,141)
game.Lighting.GeographicLatitude = 100
game.Lighting.Ambient = Color3.fromRGB(112,112,112)
blem.Intensity = 0.5
blem.Size = 22
blem.Threshold = 1.5
sanrey.Intensity = 0.117
sanrey.Spread = 1
blor.Size = 2
color.Contrast = 0.3
color.Saturation = 0.2
color.TintColor = Color3.fromRGB(255,252,224)
end
})






Tabs.Settings:AddButton({
    Title = "Night",
    Description = "",
    Callback = function()
local player = game.Players.LocalPlayer
local lighting = game:GetService("Lighting")

-- Function to change the time of day
local function setNighttime()
    lighting.TimeOfDay = 0.2 -- You can adjust this value to control the time of day (0 is midnight, 0.5 is noon)
    lighting.Brightness = 0.5 -- You can adjust this value to control the overall brightness at night
    lighting.FogEnd = 300 -- You can adjust this value to control the fog distance at night
    lighting.GlobalShadows = true -- Enable global shadows for a nighttime effect
end

-- Connect the function to the player's character added event
player.CharacterAdded:Connect(setNighttime)

-- Call the function immediately in case the character is already loaded
if player.Character then
    setNighttime()
end
end
})






Tabs.Settings:AddButton({
    Title = " Special Night",
    Description = "",
    Callback = function()
local player = game.Players.LocalPlayer
local Lighting = game:GetService("Lighting")

-- Function to change the sky to nighttime
local function setNighttime()
    Lighting.TimeOfDay = "18:00:00" -- You can adjust the time as needed
    Lighting.FogEnd = 100 -- Adjust the fog to create a nighttime atmosphere
end

-- Function to reset the sky to default
local function setDefaultTime()
    Lighting.TimeOfDay = "12:00:00" -- Reset the time to default
    Lighting.FogEnd = 1000 -- Reset fog to default
end

-- Connect the functions to events
player.CharacterAdded:Connect(setNighttime)
player.CharacterRemoving:Connect(setDefaultTime)

-- Call the functions initially (in case the player is already in the game)
if player.Character then
    setNighttime()
end
end
})


















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
