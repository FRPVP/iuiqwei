 local Sound = Instance.new("Sound",game:GetService("SoundService"))
 Sound.SoundId = "rbxassetid://1846291721"
 Sound:Play()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Plr = Players.LocalPlayer
local RS = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()
local lp = game.Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")
local camera = game.Workspace.CurrentCamera
local hum = lp.Character.HumanoidRootPart
local TweenService  = game:GetService("TweenService")
 
local function moveto(obj, speed)
    local info = TweenInfo.new(speed,Enum.EasingStyle.Linear)
    local tween = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, info, {CFrame = obj})
        tween:Play()
end

local function getdistancefc(part)
    return (part.Position - camera.CFrame.Position).Magnitude
end

local function gplr(String)
	local Found = {}
	local strl = String:lower()
	if strl == "all" then
		for i,v in pairs(game:FindService("Players"):GetPlayers()) do
			table.insert(Found,v)
		end
	elseif strl == "others" then
		for i,v in pairs(game:FindService("Players"):GetPlayers()) do
			if v.Name ~= lp.Name then
				table.insert(Found,v)
			end
		end 
	elseif strl == "me" then
		for i,v in pairs(game:FindService("Players"):GetPlayers()) do
			if v.Name == lp.Name then
				table.insert(Found,v)
			end
		end 
	else
		for i,v in pairs(game:FindService("Players"):GetPlayers()) do
			if v.Name:lower():sub(1, #String) == String:lower() then
				table.insert(Found,v)
			end
		end 
	end
	return Found 
end

if game.PlaceId == 142823291 then
if not game.CoreGui:FindFirstChild("DCCMM2") then

local loadeddccmm2 = Instance.new("Folder", game.CoreGui)
loadeddccmm2.Name = "DCCMM2"

function loadcurui()
local Client = game.Players.LocalPlayer
local Interface = "null"
local UserInputService = game.UserInputService

function GodMode()

    if game.Players.LocalPlayer.Character then

        if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then

            game.Players.LocalPlayer.Character.Humanoid.Name = "deku"

        end

        local v = game.Players.LocalPlayer.Character["deku"]:Clone()

        v.Parent = game.Players.LocalPlayer.Character

        v.Name = "Humanoid"

        wait(0.1)

        game.Players.LocalPlayer.Character["deku"]:Destroy()

        workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid

        game.Players.LocalPlayer.Character.Animate.Disabled = false

    end

end

function lay()
local Human = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
	if not Human then
		return
	end
	Human.Sit = true
	task.wait(.1)
	Human.RootPart.CFrame = Human.RootPart.CFrame * CFrame.Angles(math.pi * .5, 0, 0)
	for _, v in ipairs(Human:GetPlayingAnimationTracks()) do
		v:Stop()
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



function XrayOn(obj)
    for _,v in pairs(obj:GetChildren()) do
        if (v:IsA("BasePart")) and not v.Parent:FindFirstChild("Humanoid") then
            v.LocalTransparencyModifier = 0.75
        end
        XrayOn(v)
    end
end

function XrayOff(obj)
    for _,v in pairs(obj:GetChildren()) do
        if (v:IsA("BasePart")) and not v.Parent:FindFirstChild("Humanoid") then
            v.LocalTransparencyModifier = 0
        end 
        XrayOff(v)
    end
end

local folder = Instance.new("Folder",CoreGui)
folder.Name = "ESP Holder"
	
local function AddBillboard(player)
    local billboard = Instance.new("BillboardGui",folder)
    billboard.Name = player.Name
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.fromOffset(200,50)
    billboard.ExtentsOffset = Vector3.new(0,3,0)
    billboard.Enabled = false

    local textlabel = Instance.new("TextLabel",billboard)
    textlabel.TextSize = 20
    textlabel.Text = player.Name
    textlabel.Font = Enum.Font.SourceSans
    textlabel.BackgroundTransparency = 1
    textlabel.Size = UDim2.fromScale(1,1)
textlabel.TextStrokeTransparency = 0
textlabel.TextYAlignment = Enum.TextYAlignment.Bottom
textlabel.ZIndex = 0
    if getgenv().AllEsp then
        billboard.Enabled = true
    end
    repeat
        wait()
        pcall(function()
            billboard.Adornee = player.Character.Head
            if player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife") then
                textlabel.TextColor3 = Color3.fromRGB(238,44,44)
                if not billboard.Enabled and getgenv().MurderEsp then
                    billboard.Enabled = true
                end
            elseif player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun") then
                textlabel.TextColor3 = Color3.fromRGB(0,0,255)
                if not billboard.Enabled and getgenv().SheriffEsp then
                    billboard.Enabled = true
                end
            else
                textlabel.TextColor3 = Color3.fromRGB(127,255,0)
            end
        end)
    until not player.Parent
end

for _,player in pairs(game:GetService("Players"):GetPlayers()) do
    if player ~= game:GetService("Players").LocalPlayer then
        coroutine.wrap(AddBillboard)(player)
    end
end
Players.PlayerAdded:Connect(AddBillboard)

Players.PlayerRemoving:Connect(function(player)
    folder[player.Name]:Destroy()
end)

function GetMurderer()
    for i,v in pairs(Players:GetChildren()) do 
        if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") and v.Name == "Tool" then
            return v.Name
        end
    end
    return nil
end

function GetSheriff()
    for i,v in pairs(Players:GetChildren()) do 
        if v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") and v.Name == "Tool" then
            return v.Name
        end
        return nil
    end
end

RS.RenderStepped:Connect(function()
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
end)

local uilibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kiet1308/tvkhub/main/rac"))()
local windowz = uilibrary:CreateWindow("Tranquil", "Murder Mystery 2", true)

local PlayerP = windowz:CreatePage("LocalPlayer")
local PlayerPS = PlayerP:CreateSection("LocalPlayer")
local VisualP = windowz:CreatePage("Visual")
local VisualPS = VisualP:CreateSection("Visual")
local ModeP = windowz:CreatePage("Game Modes")
local ModePS = ModeP:CreateSection("Game Modes")
local TeleportP = windowz:CreatePage("Teleports")
local TeleportPS = TeleportP:CreateSection("Teleports")
local TrollingP = windowz:CreatePage("Trolling")
local TrollingPS = TrollingP:CreateSection("Trolling")
local AutofarmP = windowz:CreatePage("Autofarm")
local AutofarmPS = AutofarmP:CreateSection("Autofarm")
local AnimationsP = windowz:CreatePage("Animations")
local AnimationsPS = AnimationsP:CreateSection("Animations")
local PremiumP = windowz:CreatePage("Premium")
local PremiumPS = PremiumP:CreateSection("Premium")
local SettingsP = windowz:CreatePage("Settings")
local SettingsPS = SettingsP:CreateSection("Settings")

PlayerPS:CreateToggle("Noclip", {Toggled=false , Description = false}, function(t)
getgenv().Noclip = t
if Noclip then
Nclp = RS.RenderStepped:Connect(function()
game.Players.LocalPlayer.Character.Head.CanCollide = false
game.Players.LocalPlayer.Character.UpperTorso.CanCollide = false
game.Players.LocalPlayer.Character.LowerTorso.CanCollide = false
game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = false
end)
else
Nclp:Disconnect()
wait(1)
game.Players.LocalPlayer.Character.Head.CanCollide = true
game.Players.LocalPlayer.Character.UpperTorso.CanCollide = true
game.Players.LocalPlayer.Character.LowerTorso.CanCollide = true
game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = true
end
end)

PlayerPS:CreateToggle("Inf Jump", {Toggled=false , Description = false}, function(value)
   if value then
InfJump = game:GetService("UserInputService").JumpRequest:connect(function()
if value then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
		end
end)
else
InfJump:Disconnect()
end
end)

PlayerPS:CreateToggle("Tp Tool", {Toggled=false , Description = false}, function(t)
   if t then
if lp.Backpack:FindFirstChild("Click Teleport") then return end
if not lp.Backpack:FindFirstChild("Click Teleport") then
tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Click Teleport"
tool.Activated:connect(function()
local pos = mouse.Hit+Vector3.new(0,2.5,0)
pos = CFrame.new(pos.X,pos.Y,pos.Z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end)
tool.Parent = game.Players.LocalPlayer.Backpack
end
else
if lp.Backpack:FindFirstChild("Click Teleport") then
tool:Destroy()
end
end
end)


PlayerPS:CreateToggle("Fly", {Toggled=false , Description = false}, function(t)
   if t then
if not mflyspeed then
 local controlModule = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild('PlayerModule'):WaitForChild("ControlModule"))
	 local bv = Instance.new("BodyVelocity")
	 bv.Name = "VelocityHandler"
	 bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
	 bv.MaxForce = Vector3.new(0,0,0)
	 bv.Velocity = Vector3.new(0,0,0)
	 
	 local bg = Instance.new("BodyGyro")
	 bg.Name = "GyroHandler"
	 bg.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
	 bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
	 bg.P = 1000
	 bg.D = 50
	 
	 local Signal1
	 Signal1 = game.Players.LocalPlayer.CharacterAdded:Connect(function(NewChar)
	 local bv = Instance.new("BodyVelocity")
	 bv.Name = "VelocityHandler"
	 bv.Parent = NewChar:WaitForChild("Humanoid").RootPart
	 bv.MaxForce = Vector3.new(0,0,0)
	 bv.Velocity = Vector3.new(0,0,0)
	 
	 local bg = Instance.new("BodyGyro")
	 bg.Name = "GyroHandler"
	 bg.Parent = NewChar:WaitForChild("Humanoid").HumanoidRootPart
	 bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
	 bg.P = 1000
	 bg.D = 50
	 end)
	 
	 local camera = game.Workspace.CurrentCamera
	 
	 local Signal2
	 Signal2 = RS.RenderStepped:Connect(function()
	 if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
	 
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.MaxForce = Vector3.new(9e9,9e9,9e9)
	 game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler.MaxTorque = Vector3.new(9e9,9e9,9e9)
	 game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
	 
	 game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler.CFrame = camera.CoordinateFrame
	 local direction = controlModule:GetMoveVector()
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = Vector3.new()
	 if direction.X > 0 then
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + camera.CFrame.RightVector*(direction.X*80)
	 end
	 if direction.X < 0 then
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + camera.CFrame.RightVector*(direction.X*80)
	 end
	 if direction.Z > 0 then
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - camera.CFrame.LookVector*(direction.Z*80)
	 end
	 if direction.Z < 0 then
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - camera.CFrame.LookVector*(direction.Z*80)
	 end
	 end
	 end)
else
local controlModule = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild('PlayerModule'):WaitForChild("ControlModule"))
	 local bv = Instance.new("BodyVelocity")
	 bv.Name = "VelocityHandler"
	 bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
	 bv.MaxForce = Vector3.new(0,0,0)
	 bv.Velocity = Vector3.new(0,0,0)
	 
	 local bg = Instance.new("BodyGyro")
	 bg.Name = "GyroHandler"
	 bg.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
	 bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
	 bg.P = 1000
	 bg.D = 50
	 
	 local Signal1
	 Signal1 = game.Players.LocalPlayer.CharacterAdded:Connect(function(NewChar)
	 local bv = Instance.new("BodyVelocity")
	 bv.Name = "VelocityHandler"
	 bv.Parent = NewChar:WaitForChild("Humanoid").RootPart
	 bv.MaxForce = Vector3.new(0,0,0)
	 bv.Velocity = Vector3.new(0,0,0)
	 
	 local bg = Instance.new("BodyGyro")
	 bg.Name = "GyroHandler"
	 bg.Parent = NewChar:WaitForChild("Humanoid").HumanoidRootPart
	 bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
	 bg.P = 1000
	 bg.D = 50
	 end)
	 
	 local camera = game.Workspace.CurrentCamera
	 
	 local Signal2
	 Signal2 = RS.RenderStepped:Connect(function()
	 if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
	 
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.MaxForce = Vector3.new(9e9,9e9,9e9)
	 game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler.MaxTorque = Vector3.new(9e9,9e9,9e9)
	 game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
	 
	 game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler.CFrame = camera.CoordinateFrame
	 local direction = controlModule:GetMoveVector()
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = Vector3.new()
	 if direction.X > 0 then
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + camera.CFrame.RightVector*(direction.X*mflyspeed)
	 end
	 if direction.X < 0 then
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity + camera.CFrame.RightVector*(direction.X*mflyspeed)
	 end
	 if direction.Z > 0 then
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - camera.CFrame.LookVector*(direction.Z*mflyspeed)
	 end
	 if direction.Z < 0 then
	 game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler.Velocity - camera.CFrame.LookVector*(direction.Z*mflyspeed)
	 end
	 end
	 end)
	end
else
game.Players.LocalPlayer.Character.HumanoidRootPart.VelocityHandler:Destroy()
	 game.Players.LocalPlayer.Character.HumanoidRootPart.GyroHandler:Destroy()
	 game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
	 Signal1:Disconnect()
	 Signal2:Disconnect()
end
end)

PlayerPS:CreateTextbox("Fly Speed", false, function(vv)
 mflyspeed = vv
end)

PlayerPS:CreateToggle("Remove Kill Barriers", {Toggled=false , Description = false}, function(val)
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

PlayerPS:CreateToggle("Loop Interact", {Toggled=false , Description = false}, function(val)
if val then 
loopinteract = RS.RenderStepped:Connect(function()
workspace:WaitForChild("ResearchFacility"):WaitForChild("Interactive"):WaitForChild("ScanSystem"):WaitForChild("Scanner"):WaitForChild("InteractiveBox"):WaitForChild("Interact"):FireServer()
workspace:WaitForChild("ResearchFacility"):WaitForChild("Interactive"):WaitForChild("CloningSystem"):WaitForChild("InteractiveBox"):WaitForChild("Interact"):FireServer()
workspace:WaitForChild("ResearchFacility"):WaitForChild("Interactive"):WaitForChild("SirenSystem"):WaitForChild("InteractiveBox"):WaitForChild("Interact"):FireServer()
workspace:WaitForChild("MilBase"):WaitForChild("Door"):WaitForChild("InteractiveBox"):WaitForChild("Interact"):FireServer()
end)
else
loopinteract:Disconnect()
end
end)

PlayerPS:CreateTextbox("SpeedHack", false, function(vv)
if Speed then Speed:Disconnect() end
Speed = RS.RenderStepped:Connect(function()
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = vv
end)
end)

PlayerPS:CreateTextbox("JumpHack", false, function(vv)
   if Jump then Jump:Disconnect() end
Jump = RS.RenderStepped:Connect(function()
game.Players.LocalPlayer.Character.Humanoid.JumpPower = vv
end)
end)

PlayerPS:CreateButton("Notify Roles", function ()
for _,a in pairs(game.Players:GetPlayers())  do 
if a.Character ~= nil and a.Backpack:FindFirstChild("Knife") or a.Character:FindFirstChild("Knife") then 
notif("Murder is ".. a.Name .."!")
end 
end
for _,b in pairs(game.Players:GetPlayers())  do 
if b.Character ~= nil and b.Backpack:FindFirstChild("Gun") or b.Character:FindFirstChild("Gun") then
notif("Sheriff is ".. b.Name .."!")
 end end
end)

PlayerPS:CreateButton("Blurt Roles", function ()
for _,a in pairs(game.Players:GetPlayers())  do if a.Character ~= nil and a.Backpack:FindFirstChild("Knife") or a.Character:FindFirstChild("Knife") then game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack({
    [1] = "Murderer : ".. a.Name,
    [2] = "normalchat"
})) end end
for _,b in pairs(game.Players:GetPlayers())  do if b.Character ~= nil and b.Backpack:FindFirstChild("Gun") or b.Character:FindFirstChild("Gun") then game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack({
    [1] = "Sheriff : ".. b.Name,
    [2] = "normalchat"
})) end end
end)

PlayerPS:CreateButton("Lay Down", function ()
lay()
end)

PlayerPS:CreateButton("Play Dead", function ()
-- Get the local player
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

getgenv().BetterESP = false -- Initialize BetterESP

VisualPS:CreateToggle("Esp Players", {Toggled = false, Description = false}, function(val)
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

VisualPS:CreateToggle("Esp Players V2", {Toggled=false , Description = false}, function(val)
getgenv().AllEsp = val
        for i, v in pairs(folder:GetChildren()) do
            if v:IsA("BillboardGui") and game:GetService("Players")[tostring(v.Name)] then
                if getgenv().AllEsp then
                    v.Enabled = true
                else
                    v.Enabled = false
                end
            end
        end
end)

VisualPS:CreateToggle("Esp Only Murder", {Toggled=false , Description = false}, function(val)
 getgenv().MurderEsp = val
        while getgenv().MurderEsp do
            wait()
            pcall(function()
                for i, v in pairs(folder:GetChildren()) do
                    if v:IsA("BillboardGui") and Players[tostring(v.Name)] then
                        if game:GetService("Players")[tostring(v.Name)].Character:FindFirstChild("Knife") or game:GetService("Players")[tostring(v.Name)].Backpack:FindFirstChild("Knife")  then
                            if getgenv().MurderEsp then
                                v.Enabled = true
                            else
                                v.Enabled = false
                            end
                        end
                    end
                end
            end)
        end
end)

VisualPS:CreateToggle("Esp Only Sheriff", {Toggled=false , Description = false}, function(val)
getgenv().SheriffEsp = val
        while getgenv().SheriffEsp do
            wait()
            pcall(function()
                for i, v in pairs(folder:GetChildren()) do
                    if v:IsA("BillboardGui") and game:GetService("Players")[tostring(v.Name)] then
                        if game:GetService("Players")[tostring(v.Name)].Character:FindFirstChild("Gun") or game:GetService("Players")[tostring(v.Name)].Backpack:FindFirstChild("Gun")  then
                            if getgenv().SheriffEsp then
                                v.Enabled = true
                            else
                                v.Enabled = false
                            end
                        end
                    end
                end
            end)
        end
end)

VisualPS:CreateToggle("Esp Gun", {Toggled=false , Description = false}, function(Value)
getgenv().EspGun = Value
if EspGun then
while wait(1) do
task.wait(0.5)
pcall(function()
for i,v in pairs(game.Workspace:GetDescendants()) do
if v.Name == "GunDrop" and not v:FindFirstChild("EspGun") then
local bill= Instance.new("BillboardGui",v)
    bill.Name = "EspGun"
    bill.AlwaysOnTop = true
    bill.Size = UDim2.fromOffset(200,50)
    bill.ExtentsOffset = Vector3.new(0,3,0)
    bill.Enabled = true

    local textlabel = Instance.new("TextLabel",bill)
    textlabel.TextSize = 20
    textlabel.Text = "GunDrop"
    textlabel.Font = Enum.Font.SourceSans
    textlabel.BackgroundTransparency = 1
    textlabel.Size = UDim2.fromScale(1,1)
    textlabel.TextColor3 = Color3.fromRGB(0,155,155)
textlabel.TextStrokeTransparency = 0
textlabel.TextYAlignment = Enum.TextYAlignment.Bottom
textlabel.ZIndex = 0
    repeat
            billboard.Adornee = v
    until not obj.Parent
end
end
end)
if not EspGun then
bill:Destroy()
textlabel:Destroy()
break
end
end
end
end)

VisualPS:CreateToggle("Highlight All Players", {Toggled=false , Description = false}, function(value)
if value then
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local roles
 
-- > Functions <--
 
function CreateHighlight() -- make any new highlights for new players
	for i, v in pairs(Players:GetChildren()) do
		if v ~= LP and v.Character and not v.Character:FindFirstChild("Highlight") then
			local Highlight = Instance.new("Highlight", v.Character)           
		end
	end
end
 
function UpdateHighlights() -- Get Current Role Colors (messy)
	for _, v in pairs(Players:GetChildren()) do
		if v ~= LP and v.Character and v.Character:FindFirstChild("Highlight") then
			Highlight = v.Character:FindFirstChild("Highlight")
			if v.Name == Sheriff and IsAlive(v) then
				Highlight.FillColor = Color3.fromRGB(0, 0, 225)
			elseif v.Name == Murder and IsAlive(v) then
				Highlight.FillColor = Color3.fromRGB(225, 0, 0)
			elseif v.Name == Hero and IsAlive(v) and not IsAlive(game.Players[Sheriff]) then
				Highlight.FillColor = Color3.fromRGB(255, 250, 0)
			else
				Highlight.FillColor = Color3.fromRGB(0, 225, 0)
			end
		end
	end
end	
 
Highlighting = RS.RenderStepped:connect(function()
	CreateHighlight()
	UpdateHighlights()
end)
else
Highlighting:Disconnect()
wait(0.9)
for _,Highlight in pairs(game:GetDescendants()) do
if Highlight:IsA("Highlight") then
Highlight:Destroy()
end
end
end
end)

VisualPS:CreateToggle("Highlight Only Murder", {Toggled=false , Description = false}, function(value)
if value then
HighM = RS.RenderStepped:Connect(function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
if v.Character ~= game.Players.LocalPlayer.Character then
if not v:FindFirstChild("EspM") then
local EspM = Instance.new("Highlight", v.Character)
EspM.Adornee = v.Character
EspM.Name = "EspM"
EspM.FillColor = Color3.fromRGB(255,48,48)
EspM.FillTransparency = 0.4
EspM.OutlineColor = Color3.new(0,0,0)
EspM.OutlineTransparency = 0
end
end
end
end
end)
else
HighM:Disconnect()
wait(1.5)
for _,EspM in pairs(game:GetDescendants()) do
if EspM:IsA("Highlight") then
EspM:Destroy()
end
end
end
end)

VisualPS:CreateToggle("Highlight Only Sheriff", {Toggled=false , Description = false}, function(value)
if value then
HighS = RS.RenderStepped:Connect(function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
if v.Character ~= game.Players.LocalPlayer.Character then
if not v:FindFirstChild("EspS") then
local EspS = Instance.new("Highlight", v)
EspS.Adornee = v.Character
EspS.Name = "EspS"
EspS.FillColor = Color3.fromRGB(48,48,255)
EspS.FillTransparency = 0.6
EspS.OutlineColor = Color3.new(0,0,0)
EspS.OutlineTransparency = 0
end
end
end
end
end)
else
HighS:Disconnect()
wait(1.5)
for _,EspS in pairs(game:GetDescendants()) do
if EspS:IsA("Highlight") then
EspS:Destroy()
end
end
end
end)

VisualPS:CreateToggle("Highlight Gun", {Toggled=false , Description = false}, function(Value)
getgenv().HighlGun = Value
if HighlGun then
while wait(1) do
task.wait(0.5)
pcall(function()
for i,v in pairs(game.Workspace:GetDescendants()) do
if v.Name == "GunDrop" and not v:FindFirstChild("HighlightGun") then
local HighGun = Instance.new("Highlight", v)
HighGun.FillColor = Color3.fromRGB(0, 155, 155)
HighGun.FillTransparency = 0.4
HighGun.OutlineColor = Color3.new(0,0,139)
HighGun.OutlineTransparency = 0
HighGun.Name = "HighlightGun"
    repeat
            HighGun.Adornee = v
    until not obj.Parent
end
end
end)
if not HighlGun then
HighGun:Destroy()
break
end
end
end
end)

getgenv().GlowCham = false -- Initialize BetterESP

VisualPS:CreateToggle("Glow Chams", {Toggled = false, Description = false}, function(val)
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
        surfaceLight.Brightness = 100 -- Adjust brightness as needed
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

VisualPS:CreateToggle("Chams All Players", {Toggled=false , Description = false}, function(value)
if value then
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local roles
 
-- > Functions <--
 
function CreateChams()
	for i, v in pairs(Players:GetChildren()) do
		if v ~= LP and v.Character and not v.Character:FindFirstChildOfClass("BoxHandleAdornment") then
			local ChamsTorso = Instance.new("BoxHandleAdornment", v.Character)
			ChamsTorso.AlwaysOnTop = true
			ChamsTorso.Transparency = 0.55
			ChamsTorso.ZIndex = 0
			ChamsTorso.Size = v.Character.HumanoidRootPart.Size
			ChamsTorso.Adornee = v.Character.HumanoidRootPart
		end
	end
end
 
function UpdateChams() -- Get Current Role Colors (messy)
	for _, v in pairs(Players:GetChildren()) do
		if v ~= LP and v.Character and v.Character:FindFirstChild("BoxHandleAdornment") then
			ChamsTorso = v.Character:FindFirstChild("BoxHandleAdornment")
			if v.Name == Sheriff and IsAlive(v) then
				ChamsTorso.Color3 = Color3.fromRGB(0, 0, 225)
			elseif v.Name == Murder and IsAlive(v) then
				ChamsTorso.Color3 = Color3.fromRGB(225, 0, 0)
			elseif v.Name == Hero and IsAlive(v) and not IsAlive(game.Players[Sheriff]) then
				ChamsTorso.Color3 = Color3.fromRGB(255, 250, 0)
			else
				ChamsTorso.Color3 = Color3.fromRGB(0, 225, 0)
			end
		end
	end
end	
 

-- > Loops < --
 
ChamsL = RS.RenderStepped:connect(function()
	CreateChams()
	UpdateChams()
end)
else
ChamsL:Disconnect()
wait(0)
for _,ChamsTorso in pairs(game:GetDescendants()) do
if ChamsTorso:IsA("BoxHandleAdornment") then
ChamsTorso:Destroy()
end
end
end
end)

VisualPS:CreateToggle("Chams Only Murder", {Toggled=false , Description = false}, function(val)
getgenv().ChamsMurder = val
while ChamsMurder do task.wait(0.5)
pcall(function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
if v.Character ~= game.Players.LocalPlayer.Character then
if not v:FindFirstChildOfClass("BoxHandleAdornment") then
local ChamsM = Instance.new("BoxHandleAdornment", v.Character)
			ChamsM.AlwaysOnTop = true
			ChamsM.Transparency = 0.55
			ChamsM.ZIndex = 0
			ChamsM.Size = v.Character.HumanoidRootPart.Size
			ChamsM.Adornee = v.Character.HumanoidRootPart
ChamsM.Color3 = Color3.fromRGB(225,0,0)
else
end
end
end
end
end)
if not ChamsMurder then
for _,ChamsM in pairs(game:GetDescendants()) do
if ChamsM:IsA("BoxHandleAdornment") then
ChamsM:Destroy()
end
end
break
end
end
end)

VisualPS:CreateToggle("Chams Only Sheriff", {Toggled=false , Description = false}, function(value)
getgenv().ChamsSheriff = value
while ChamsSheriff do task.wait(0.5)
pcall(function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
if v.Character ~= game.Players.LocalPlayer.Character then
if not v:FindFirstChildOfClass("BoxHandleAdornment") then
local ChamsS = Instance.new("BoxHandleAdornment", v.Character)
			ChamsS.AlwaysOnTop = true
			ChamsS.Transparency = 0.55
			ChamsS.ZIndex = 0
			ChamsS.Size = v.Character.HumanoidRootPart.Size
			ChamsS.Adornee = v.Character.HumanoidRootPart
ChamsS.Color3 = Color3.fromRGB(0,0,225)
else
end
end
end
end
end)
if not ChamsSheriff then
for _,ChamsS in pairs(game:GetDescendants()) do
if ChamsS:IsA("BoxHandleAdornment") then
ChamsS:Destroy()
end
end
break
end
end
end)

VisualPS:CreateToggle("Chams Gun", {Toggled=false , Description = false}, function(value)
getgenv().ChamsGun = value
if ChamsGun then
while wait(1) do
task.wait(0.5)
pcall(function()
for i,v in pairs(game.Workspace:GetDescendants()) do
if v.Name == "GunDrop" and not v:FindFirstChild("ChamsGun") then
local Chamgun = Instance.new("BoxHandleAdornment", v)
Chamgun.Color3 = Color3.fromRGB(0,155,155)
Chamgun.Transparency = 0.6
Chamgun.ZIndex = 0
Chamgun.Size = v.Size
Chamgun.AlwaysOnTop = true
Chamgun.Name = "ChamsGun"
    repeat
            Chamgun.Adornee = v
    until not obj.Parent
end
end
end)
if not ChamsGun then
Chamgun:Destroy()
break
end
end
end
end)

VisualPS:CreateToggle("View Dropped Gun", {Toggled=false , Description = false}, function(Value)
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

VisualPS:CreateButton("View Murder", function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
game.Workspace.CurrentCamera.CameraSubject = v.Character.Humanoid
end
end
end)

VisualPS:CreateButton("View Sheriff", function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
game.Workspace.CurrentCamera.CameraSubject = v.Character.Humanoid
end
end
end)

VisualPS:CreateTextbox("View Player", false, function(vv)
local User = gplr(vv)
if User[1] then
User = User[1]
game.Workspace.CurrentCamera.CameraSubject =  User.Character.Humanoid
else
error("Invaild Player!")
end
end)

VisualPS:CreateButton("Stop Spectating", function()
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid')
end)

ModePS:CreateButton("Grab Gun(innocent)", function()
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
end)

ModePS:CreateButton("Grab Gun(When Murd Camper)(innocent)", function()
for _, Child in pairs(Client.PlayerGui.MainGUI:GetDescendants()) do
    if Child.Name == "Full" and Child.Parent.Name == "CoinBag" and Child.Parent.Parent.Name == "Dock" and Child.Parent.Parent.Parent.Name == "Lobby" and UserInputService.TouchEnabled then
        Interface = "Mobile"
        for i,v in pairs(game.Workspace:GetDescendants()) do
 if v.Name == "GunDrop" then
 lastCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
 wait(0.1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, -3, 0)
    moveto(v.CFrame + Vector3.new(0,5.9,0), 0.15)
    wait(0.15)
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = lastCFrame
  wait(0.1)
 lastCFrame = nil
 end
 end
    elseif Child.Name == "Full" and Child.Parent.Name == "TabletCashBag" and Child.Parent.Parent.Name == "Game" and Child.Parent.Parent.Parent.Name == "MainGUI" and UserInputService.TouchEnabled then
        Interface = "Tablet"
        for i,v in pairs(game.Workspace:GetDescendants()) do
 if v.Name == "GunDrop" then
 lastCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
 wait(0.1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, -3, 0)
    moveto(v.CFrame + Vector3.new(0,5.9,0), 0.15)
    wait(0.15)
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = lastCFrame
  wait(0.1)
 lastCFrame = nil
 end
 end
    elseif Child.Name == "Full" and Child.Parent.Name == "TabletCashBag" and Child.Parent.Parent.Name == "Game" and Child.Parent.Parent.Parent.Name == "MainGUI" and not UserInputService.TouchEnabled then
        Interface = "Pc"
        for i,v in pairs(game.Workspace:GetDescendants()) do
 if v.Name == "GunDrop" then
 lastCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
 wait(0.1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, -3, 0)
    moveto(v.CFrame + Vector3.new(0,5.9,0), 0.15)
    wait(0.15)
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = lastCFrame
  wait(0.1)
 lastCFrame = nil
 end
 end
    end
end
end)

ModePS:CreateToggle("Auto Grab Gun(innocent)", {Toggled=false , Description = false}, function(Value)
   getgenv().autograbgun = Value
while autograbgun do task.wait(2)
pcall(function()
if game.Players.LocalPlayer.Backpack:FindFirstChild("Knife") then return end
for _, Child in pairs(Client.PlayerGui.MainGUI:GetDescendants()) do
    if Child.Name == "Full" and Child.Parent.Name == "CoinBag" and Child.Parent.Parent.Name == "Dock" and Child.Parent.Parent.Parent.Name == "Lobby" and UserInputService.TouchEnabled then
        Interface = "Mobile"
        for i,v in pairs(game.Workspace:GetDescendants()) do
 if v.Name == "GunDrop" then
 lastCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
 wait(0.1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, -3, 0)
    moveto(v.CFrame, 0.5)
    wait(0.5)
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = lastCFrame
  wait(0.1)
 lastCFrame = nil
        end
        end
    elseif Child.Name == "Full" and Child.Parent.Name == "TabletCashBag" and Child.Parent.Parent.Name == "Game" and Child.Parent.Parent.Parent.Name == "MainGUI" and UserInputService.TouchEnabled then
        Interface = "Tablet"
        for i,v in pairs(game.Workspace:GetDescendants()) do
 if v.Name == "GunDrop" then
 lastCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
 wait(0.1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, -3, 0)
    moveto(v.CFrame, 0.5)
    wait(0.5)
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = lastCFrame
  wait(0.1)
 lastCFrame = nil
        end
        end
    elseif Child.Name == "Full" and Child.Parent.Name == "TabletCashBag" and Child.Parent.Parent.Name == "Game" and Child.Parent.Parent.Parent.Name == "MainGUI" and not UserInputService.TouchEnabled then
        Interface = "Pc"
        for i,v in pairs(game.Workspace:GetDescendants()) do
 if v.Name == "GunDrop" then
 lastCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
 wait(0.1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, -3, 0)
    moveto(v.CFrame, 0.5)
    wait(0.5)
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = lastCFrame
  wait(0.1)
 lastCFrame = nil
        end
        end
    end
end
        end)
 if not autograbgun then
 break
 end
end
end)

ModePS:CreateToggle("Gun Status", {Toggled=false , Description = false}, function(val)
if val then
gunstatuson = game.Workspace.ChildAdded:Connect(function(gun)
for i,gun in pairs(game.Workspace:GetDescendants()) do
if gun.Name == "GunDrop" then
warn("Gun Dropped!")
end
end
end)
gunstatusoff = game.Workspace.ChildRemoved:Connect(function(gun)
for i,gun in pairs(game.Workspace:GetDescendants()) do
if gun.Name == "GunDrop" then
warn("Gun Not Dropped!")
end
end
end)
else
gunstatuson:Disconnect()
gunstatusoff:Disconnect()
end
end)

ModePS:CreateToggle("Silent Aim(sheriff)", {Toggled=false , Description = false}, function(value)
SilentAimEnable = value
end)

ModePS:CreateDropdown("Aim Part", {
   List = {"Head", "Humanoid"},
   Default = "Humanoid"}, function(value)
       getgenv().ShooterHarp = value
end)

ModePS:CreateButton("Shoot Murder(sheriff)", function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
        for i, MyTool in pairs(Players.LocalPlayer.Character:GetChildren()) do
                                    if MyTool.Name == "Gun" and MyTool:IsA("Tool") and MyTool:FindFirstChild("KnifeServer") then
        popit = lp.Character.HumanoidRootPart.CFrame   
        wait(0.1)
        telep = RS.RenderStepped:Connect(function()
        hum.CFrame = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,2.35)
        end)
        wait(0.2)
        MyTool.KnifeServer.ShootGun:InvokeServer(1, v.Character.HumanoidRootPart.Position, "AH")
        wait(0.1)
        telep:Disconnect()
        wait(0.9)
        hum.CFrame = popit 
        wait(0.1)
        popit = nil
end
end
end
end
end)

ModePS:CreateToggle("Auto Shoot Murder V1", {Toggled=false , Description = false}, function(val)
if val then
AutoShootMurd1 = RS.RenderStepped:Connect(function()
for _, Player in pairs(Players:GetPlayers()) do
                        if Player.Name ~= Players.LocalPlayer.Name then
                            if Player and Player.Character and Player.Character:FindFirstChild("Knife") then
                                for i, MyTool in pairs(Players.LocalPlayer.Character:GetChildren()) do
                                    if MyTool.Name == "Gun" and MyTool:IsA("Tool") and MyTool:FindFirstChild("KnifeServer") then
                                     if getgenv().ShooterHarp == "Head" then
                                        MyTool.KnifeServer.ShootGun:InvokeServer(1, Player.Character.Head.Position, "AH")
                                     elseif getgenv().ShooterHarp == "Humanoid" then
                                     MyTool.KnifeServer.ShootGun:InvokeServer(1, Player.Character.HumanoidRootPart.Position, "AH")
                                        end
                                    end
                                end
                            end
                        end
                    end
end)
else
AutoShootMurd1:Disconnect()
end
end)

ModePS:CreateToggle("Auto Shoot Murder V2", {Toggled=false , Description = false}, function(val)
if val then
while wait(7) do
pcall(function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
        for i, MyTool in pairs(Players.LocalPlayer.Character:GetChildren()) do
                                    if MyTool.Name == "Gun" and MyTool:IsA("Tool") and MyTool:FindFirstChild("KnifeServer") then
        popit = lp.Character.HumanoidRootPart.CFrame   
        wait(0.1)
        telep = RS.RenderStepped:Connect(function()
        lp.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,2.35)
        end)
        wait(0.35)
        MyTool.KnifeServer.ShootGun:InvokeServer(1, v.Character.HumanoidRootPart.Position, "AH")
        wait(0.1)
        telep:Disconnect()
        wait(0.9)
        hum.CFrame = popit 
        wait(0.1)
        popit = nil
end
end
end
end
end)
if not val then
break
end
end
end
end)

ModePS:CreateToggle("Aim At Murder(sheriff)", {Toggled=false , Description = false}, function(value)
if value then
aimatmurd = RS.RenderStepped:Connect(function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
camera.CFrame = CFrame.new(camera.CFrame.Position,v.Character.HumanoidRootPart.Position)
end
end
end)
else
if aimatmurd then
aimatmurd:Disconnect()
end
end
end)

ModePS:CreateToggle("Knife Silent Aim (murder)", {Toggled=false , Description = false}, function(Value)
KnifeSilentAimEnabled = Value
end)

ModePS:CreateButton("Kill All V1 (murder)", function()
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
if v.Name == "Knife" then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
for i,g in pairs(Players:GetPlayers()) do
if g ~= lp then
wait(0.1)
g.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2)
wait(0.1)
g.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2)
wait(0.1)
g.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2)
wait(0.1)
g.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2)
wait(0.1)
g.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2)
end
end
end
end
end)

ModePS:CreateButton("Kill All V2 (murder)", function()
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
if v.Name == "Knife" then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
for i,g in pairs(Players:GetPlayers()) do
if g ~= lp then
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
end
end
end
end
end)

ModePS:CreateButton("Kill Sheriff V1 (murder)", function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
wait(0.1)
for i,b in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
if b.Name == "Knife" then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(b)
wait(0.1)
v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6)
wait(0.1)
v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6)
wait(0.1)
v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6)
wait(0.1)
v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6)
wait(0.1)
v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6)
end
end
end
end
end)

ModePS:CreateButton("Kill Sheriff V2 (murder)", function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
wait(0.1)
for i,b in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
if b.Name == "Knife" then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(b)
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6), 
    [2] = v.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6), 
    [2] = v.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6), 
    [2] = v.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6), 
    [2] = v.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6), 
    [2] = v.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6), 
    [2] = v.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6), 
    [2] = v.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6), 
    [2] = v.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6), 
    [2] = v.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6), 
    [2] = v.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6), 
    [2] = v.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6), 
    [2] = v.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6), 
    [2] = v.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6), 
    [2] = v.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6), 
    [2] = v.Character.HumanoidRootPart.Position
}))
end
end
end
end
end)

ModePS:CreateToggle("Auto Kill All V1 (murder)", {Toggled=false , Description = false}, function(Value)
if Value then
AutoKillAll = RS.RenderStepped:Connect(function()
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
if v.Name == "Knife" then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
for i,g in pairs(Players:GetPlayers()) do
if g ~= lp then
wait(0.1)
g.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2)
wait(0.1)
g.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2)
wait(0.1)
g.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2)
wait(0.1)
g.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2)
wait(0.1)
g.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2)
end
end
end
end
end)
else
AutoKillAll:Disconnect()
end
end)

ModePS:CreateToggle("Auto Kill All V2 (murder)", {Toggled=false , Description = false}, function(Value)
if Value then
AutoKillAll2 = RS.RenderStepped:Connect(function()
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
if v.Name == "Knife" then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
for i,g in pairs(Players:GetPlayers()) do
if g ~= lp then
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = g.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-0.6),
    [2] = g.Character.HumanoidRootPart.Position
}))
end
end
end
end
end)
else
AutoKillAll2:Disconnect()
end
end)

ModePS:CreateTextbox("Kill Player V1 (murder)", false, function(vv)
local User = gplr(vv)
if User[1] then
User = User[1]
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
if v.Name == "Knife" then
lp.Character.Humanoid:EquipTool(v)
wait(0.001)
game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Sit = false
wait(0.1)
User.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2)
wait(0.1)
User.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2)
wait(0.1)
User.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2)
wait(0.1)
User.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2)
wait(0.1)
User.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2)
end
end
else
error("Invaild Player!")
end
end)

ModePS:CreateTextbox("Kill Player V2 (murder)", false, function(vv)
local User = gplr(vv)
if User[1] then
User = User[1]
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
if v.Name == "Knife" then
lp.Character.Humanoid:EquipTool(v)
wait(1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2),
    [2] = User.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2),
    [2] = User.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2),
    [2] = Players[val].Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2),
    [2] = User.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2),
    [2] = User.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2),
    [2] = User.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2),
    [2] = User.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2),
    [2] = User.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2),
    [2] = User.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2),
    [2] = User.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2),
    [2] = Players[val].Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2),
    [2] = User.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2),
    [2] = User.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2),
    [2] = User.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2),
    [2] = User.Character.HumanoidRootPart.Position
}))
wait(0.1)
game:GetService("Players").LocalPlayer.Character.Knife.Throw:FireServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,-2),
    [2] = User.Character.HumanoidRootPart.Position
}))
end
end
else
error("Invaild Player!")
end
end)

TeleportPS:CreateButton("Lobby", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108, 138, 37)
end)

TeleportPS:CreateButton("Voting Room", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108, 141, 86)
end)

TeleportPS:CreateButton("Map", function()
for i,v in pairs(game.Workspace:GetDescendants()) do
if v.Name == "House2" or v.Name == "MilBase" or v.Name == "Mansion2" or v.Name == "Hospital3" or v.Name == "PoliceStation" or v.Name == "nSOffice" or v.Name == "Bank2" or v.Name == "Office3" or v.Name == "Hotel" or v.Name == "Factory" or v.Name == "Workplace" or v.Name == "BioLab" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Spawns.Spawn.CFrame
elseif v.Name == "ResearchFacility" then
lp.Character.HumanoidRootPart.CFrame = v.Spawns.PlayerSpawn.CFrame
end
end
end)

TeleportPS:CreateButton("Under Map", function()
for i,v in pairs(game.Workspace:GetDescendants()) do
if v.Name == "House2" or v.Name == "MilBase" or v.Name == "Mansion2" or v.Name == "Hospital3" or v.Name == "PoliceStation" or v.Name == "nSOffice" or v.Name == "Bank2" or v.Name == "Office3" or v.Name == "Hotel" or v.Name == "Factory" or v.Name == "Workplace" or v.Name == "BioLab" then
lp.Character.HumanoidRootPart.CFrame = v.Spawns.Spawn.CFrame + Vector3.new(0,100,0)
elseif v.Name == "ResearchFacility" then
lp.Character.HumanoidRootPart.CFrame = v.Spawns.PlayerSpawn.CFrame + Vector3.new(0,100,0)
end
end
end)

TeleportPS:CreateButton("Void(Safe)", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-74, -6, 693)
end)

TeleportPS:CreateButton("Murder", function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
end
end
end)

TeleportPS:CreateButton("Sheriff", function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
end
end
end)

TeleportPS:CreateTextbox("Player", false, function(vv)
local User = gplr(vv)
if User[1] then
User = User[1]
lp.Character.HumanoidRootPart.CFrame = User.Character.HumanoidRootPart.CFrame
else
error("Invaild Player!")
end
end)

TrollingPS:CreateToggle("Stealth(Ghost Perk Required)", {Toggled=false , Description = false}, function(val)
if val then
Stealth = RS.RenderStepped:Connect(function()
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("Stealth"):FireServer(unpack({
    [1] = true
}))
end)
else
Stealth:Disconnect()
wait(1)
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("Stealth"):FireServer(unpack({
    [1] = false
}))
end
end)

TrollingPS:CreateToggle("Fake Gun(Fake Gun Perk Required)", {Toggled=false , Description = false}, function(val)
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

TrollingPS:CreateToggle("Trail(Sprint Perk Required)", {Toggled=false , Description = false}, function(val)
if val then
sprint = RS.RenderStepped:Connect(function()
game:GetService("Players").LocalPlayer.Character.SpeedTrail.Toggle:FireServer(unpack({
    [1] = true
}))
end)
else
sprint:Disconnect()
wait(1.1)
game:GetService("Players").LocalPlayer.Character.SpeedTrail.Toggle:FireServer(unpack({
    [1] = false
}))
end
end)

TrollingPS:CreateButton("Spawn Trap(Trap Perk Required)", function()
game:GetService("ReplicatedStorage"):WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(unpack({
    [1] = lp.Character.HumanoidRootPart.CFrame
}))
end)

TrollingPS:CreateToggle("Loop Spawn Trap(TrapPerk Required)", {Toggled=false , Description = false}, function(val)
if val then
loopspawntrap = RS.RenderStepped:Connect(function()
game:GetService("ReplicatedStorage"):WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(unpack({
    [1] = lp.Character.HumanoidRootPart.CFrame
}))
end)
else
loopspawntrap:Disconnect()
end
end)

TrollingPS:CreateTextbox("Target Player", false, function(vv)
TargetedPlayer = vv
end)

TrollingPS:CreateButton("Trap Target(Trap Perk Required)", function()
local User = gplr(TargetedPlayer)
if User[1] then
User = User[1]
game:GetService("ReplicatedStorage"):WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame
}))
else
error("Invaild Player!")
end
end)

TrollingPS:CreateToggle("Loop Trap Target(Trap Perk Required)", {Toggled=false , Description = false}, function(val)
if val then
	LoopTrap = RS.RenderStepped:Connect(function()
	local User = gplr(getgenv().Target)
if User[1] then
User = User[1]
game:GetService("ReplicatedStorage"):WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(unpack({
    [1] = User.Character.HumanoidRootPart.CFrame
}))
else
error("Invaild Player!")
end
end)
else
LoopTrap:Disconnect()
end
end)

TrollingPS:CreateButton("Trap Everyone(Trap Perk Required)", function()
for i,x in pairs(Players:GetPlayers()) do
if x ~= lp then
game:GetService("ReplicatedStorage"):WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(unpack({
    [1] = x.Character.HumanoidRootPart.CFrame
}))
end
end
end)

TrollingPS:CreateButton("Trap Murder(Trap Perk Required)", function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
game:GetService("ReplicatedStorage"):WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame
}))
end
end
end)

TrollingPS:CreateButton("Trap Sheriff(Trap Perk Required)", function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
game:GetService("ReplicatedStorage"):WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame
}))
end
end
end)

TrollingPS:CreateToggle("Loop Trap Murder(Trap Perk Required)", {Toggled=false , Description = false}, function(val)
if val then
LoopTrapMurd = RS.RenderStepped:Connect(function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
game:GetService("ReplicatedStorage"):WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame
}))
end
end
end)
else
LoopTrapMurd:Disconnect()
end
end)

TrollingPS:CreateToggle("Loop Trap Sheriff(Trap Perk Required)", {Toggled=false , Description = false}, function(val)
if val then
LoopTrapSher = RS.RenderStepped:Connect(function()
for _,v in pairs(game.Players:GetPlayers()) do
if v.Character ~= nil and v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
game:GetService("ReplicatedStorage"):WaitForChild("TrapSystem"):WaitForChild("PlaceTrap"):InvokeServer(unpack({
    [1] = v.Character.HumanoidRootPart.CFrame
}))
end
end
end)
else
LoopTrapSher:Disconnect()
end
end)

TrollingPS:CreateButton("Get Emotes", function()
require(game:GetService('ReplicatedStorage').Modules.EmoteModule).GeneratePage({"headless","zombie","zen","ninja","floss","dab","sit"},game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Game:FindFirstChild("Emotes"),'Free Emotes')
end)

AutofarmPS:CreateToggle("Autofarm Toggle", {Toggled=false , Description = false}, function(val)
autofarm = val
if val then
if not getgenv().safemode and not getgenv().fastermode then
while autofarm do task.wait(2.9)
pcall(function()
for _, Child in pairs(lp.PlayerGui.MainGUI:GetDescendants()) do
    if Child.Name == "Full" and Child.Parent.Name == "CoinBag" and Child.Parent.Parent.Name == "Dock" and Child.Parent.Parent.Parent.Name == "Lobby" and UserInputService.TouchEnabled then
        Interface = "Mobile"
    for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
        moveto(v.CFrame, 2.6)
        end
        end
       elseif Child.Name == "Full" and Child.Parent.Name == "TabletCashBag" and Child.Parent.Parent.Name == "Game" and Child.Parent.Parent.Parent.Name == "MainGUI" and UserInputService.TouchEnabled then
       Interface = "Tablet"
       for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
        moveto(v.CFrame, 2.6)
        end
        end
        elseif Child.Name == "Full" and Child.Parent.Name == "TabletCashBag" and Child.Parent.Parent.Name == "Game" and Child.Parent.Parent.Parent.Name == "MainGUI" and not UserInputService.TouchEnabled then
        Interface = "Pc"
        for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
        moveto(v.CFrame, 2.6)
        end
        end
        end
        end
        end)
 if not autofarm then
 break
 end
end
elseif getgenv().safemode and not getgenv().fastermode then
while autofarm do task.wait(3.1)
pcall(function()
for _, Child in pairs(lp.PlayerGui.MainGUI:GetDescendants()) do
    if Child.Name == "Full" and Child.Parent.Name == "CoinBag" and Child.Parent.Parent.Name == "Dock" and Child.Parent.Parent.Parent.Name == "Lobby" and UserInputService.TouchEnabled then
        Interface = "Mobile"
    for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
        moveto(v.CFrame + Vector3.new(0, -5, 0) , 2.6)
        wait(2.6)
        moveto(v.CFrame , 0.5)
        end
        end
        elseif Child.Name == "Full" and Child.Parent.Name == "TabletCashBag" and Child.Parent.Parent.Name == "Game" and Child.Parent.Parent.Parent.Name == "MainGUI" and UserInputService.TouchEnabled then
        Interface = "Tablet"
            for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
        moveto(v.CFrame + Vector3.new(0, -5, 0) , 2.6)
        wait(2.6)
        moveto(v.CFrame , 0.5)
        end
        end
        elseif Child.Name == "Full" and Child.Parent.Name == "TabletCashBag" and Child.Parent.Parent.Name == "Game" and Child.Parent.Parent.Parent.Name == "MainGUI" and not UserInputService.TouchEnabled then
        Interface = "Pc"
            for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
        moveto(v.CFrame + Vector3.new(0, -5, 0) , 2.6)
        wait(2.6)
        moveto(v.CFrame , 0.5)
        end
        end
        end
        end
        end)
 if not autofarm then
 break
 end
end
elseif getgenv().safemode and getgenv().fastermode then
while autofarm do task.wait(2.5)
pcall(function()
for _, Child in pairs(lp.PlayerGui.MainGUI:GetDescendants()) do
    if Child.Name == "Full" and Child.Parent.Name == "CoinBag" and Child.Parent.Parent.Name == "Dock" and Child.Parent.Parent.Parent.Name == "Lobby" and UserInputService.TouchEnabled then
        Interface = "Mobile"
    for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
        moveto(v.CFrame + Vector3.new(0, -5, 0) , 1.8)
        wait(1.8)
        moveto(v.CFrame , 0.5)
        end
        end
        elseif Child.Name == "Full" and Child.Parent.Name == "TabletCashBag" and Child.Parent.Parent.Name == "Game" and Child.Parent.Parent.Parent.Name == "MainGUI" and UserInputService.TouchEnabled then
        Interface = "Tablet"
        for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
        moveto(v.CFrame + Vector3.new(0, -5, 0) , 1.8)
        wait(1.8)
        moveto(v.CFrame , 0.5)
        end
        end
        elseif Child.Name == "Full" and Child.Parent.Name == "TabletCashBag" and Child.Parent.Parent.Name == "Game" and Child.Parent.Parent.Parent.Name == "MainGUI" and not UserInputService.TouchEnabled then
        Interface = "Pc"
        for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
        moveto(v.CFrame + Vector3.new(0, -5, 0) , 1.8)
        wait(1.8)
        moveto(v.CFrame , 0.5)
        end
        end
        end
        end
        end)
 if not autofarm then
 break
 end
end
elseif not getgenv().safemode and getgenv().fastermode then
while autofarm do task.wait(2.3)
pcall(function()
for _, Child in pairs(lp.PlayerGui.MainGUI:GetDescendants()) do
    if Child.Name == "Full" and Child.Parent.Name == "CoinBag" and Child.Parent.Parent.Name == "Dock" and Child.Parent.Parent.Parent.Name == "Lobby" and UserInputService.TouchEnabled then
        Interface = "Mobile"
    for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
        moveto(v.CFrame , 1.8)
        end
        end
        elseif Child.Name == "Full" and Child.Parent.Name == "TabletCashBag" and Child.Parent.Parent.Name == "Game" and Child.Parent.Parent.Parent.Name == "MainGUI" and UserInputService.TouchEnabled then
        Interface = "Tablet"
        for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
        moveto(v.CFrame , 1.8)
        end
        end
        elseif Child.Name == "Full" and Child.Parent.Name == "TabletCashBag" and Child.Parent.Parent.Name == "Game" and Child.Parent.Parent.Parent.Name == "MainGUI" and not UserInputService.TouchEnabled then
        Interface = "Pc"
        for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
        moveto(v.CFrame , 1.8)
        end
        end
        end
        end
        end)
 if not autofarm then
 break
 end
end
end
end
end)

AutofarmPS:CreateToggle("Faster Mode", {Toggled=false , Description = false}, function(val)
getgenv().fastermode = val
end)

AutofarmPS:CreateToggle("Safe Mode", {Toggled=false , Description = false}, function(val)
getgenv().safemode = val
end)

AutofarmPS:CreateToggle("Void Autofarm", {Toggled=false , Description = false}, function(val)
voidafarm = val
if voidafarm then
if not getgenv().voidfast then
while voidafarm do task.wait(4)
pcall(function()
for _, Child in pairs(lp.PlayerGui.MainGUI:GetDescendants()) do
    if Child.Name == "Full" and Child.Parent.Name == "CoinBag" and Child.Parent.Parent.Name == "Dock" and Child.Parent.Parent.Parent.Name == "Lobby" and UserInputService.TouchEnabled then
        Interface = "Mobile"
    for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
    moveto(v.CFrame + Vector3.new(0, -1.95, 0) , 3.4)
    wait(3.45)
    moveto(CFrame.new(-74, -6, 710), 0.5)
    end
    end
        elseif Child.Name == "Full" and Child.Parent.Name == "TabletCashBag" and Child.Parent.Parent.Name == "Game" and Child.Parent.Parent.Parent.Name == "MainGUI" and UserInputService.TouchEnabled then
        Interface = "Tablet"
        for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
    moveto(v.CFrame + Vector3.new(0, -1.95, 0) , 1.8)
    wait(1.85)
    moveto(CFrame.new(-74, -6, 710), 0.5)
        end
        end
        elseif Child.Name == "Full" and Child.Parent.Name == "TabletCashBag" and Child.Parent.Parent.Name == "Game" and Child.Parent.Parent.Parent.Name == "MainGUI" and not UserInputService.TouchEnabled then
        Interface = "Pc"
        for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
        moveto(v.CFrame + Vector3.new(0, -1.95, 0) , 1.8)
    wait(1.85)
    moveto(CFrame.new(-74, -6, 710), 0.5)
        end
        end
        end
        end
       end)
 if not voidafarm then
 break
 end
end
elseif getgenv().voidfast then
while voidafarm do task.wait(1.1)
pcall(function()
for _, Child in pairs(lp.PlayerGui.MainGUI:GetDescendants()) do
    if Child.Name == "Full" and Child.Parent.Name == "CoinBag" and Child.Parent.Parent.Name == "Dock" and Child.Parent.Parent.Parent.Name == "Lobby" and UserInputService.TouchEnabled then
        Interface = "Mobile"
    for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
    moveto(v.CFrame + Vector3.new(0, -1.95, 0) , 0.9)
    wait(0.99)
    moveto(CFrame.new(-74, -6, 710), 0.25)
        end
        end
        elseif Child.Name == "Full" and Child.Parent.Name == "TabletCashBag" and Child.Parent.Parent.Name == "Game" and Child.Parent.Parent.Parent.Name == "MainGUI" and UserInputService.TouchEnabled then
        Interface = "Tablet"
        for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
        moveto(v.CFrame + Vector3.new(0, -1.95, 0) , 0.9)
    wait(0.99)
    moveto(CFrame.new(-74, -6, 710), 0.25)
        end
        end
        elseif Child.Name == "Full" and Child.Parent.Name == "TabletCashBag" and Child.Parent.Parent.Name == "Game" and Child.Parent.Parent.Parent.Name == "MainGUI" and not UserInputService.TouchEnabled then
        Interface = "Pc"
        for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "Coin_Server" then
        moveto(v.CFrame + Vector3.new(0, -1.95, 0) , 0.9)
    wait(0.99)
    moveto(CFrame.new(-74, -6, 710), 0.25)
        end
        end
        end
        end
        end)
 if not voidafarm then
 break
 end
end
end
end
end)

AutofarmPS:CreateToggle("Void Faster Mode", {Toggled=false , Description = false}, function(val)
getgenv().voidfast = val
end)

AnimationsPS:CreateButton("None", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=0"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=0"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=0"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=0"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=0"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=0"
Animate.swimidle.SwimIdle.AnimationId = "http://www.roblox.com/asset/?id=0"
Animate.swim.Swim.AnimationId = "http://www.roblox.com/asset/?id=0"
end)

AnimationsPS:CreateButton("Princess", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=941003647"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=941013098"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=941028902"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=941015281"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=941008832"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=940996062"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=941000007"
end)

AnimationsPS:CreateButton("Sneaky", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1132473842"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1132477671"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1132510133"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1132494274"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1132489853"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1132461372"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1132469004"
end)

AnimationsPS:CreateButton("Ghost", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616006778"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616008087"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616008936"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616005863"
Animate.swimidle.SwimIdle.AnimationId = "http://www.roblox.com/asset/?id=616012453"
Animate.swim.Swim.AnimationId = "http://www.roblox.com/asset/?id=616011509"
end)

AnimationsPS:CreateButton("Cowboy", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1014390418"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1014398616"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1014421541"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1014401683"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1014394726"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1014380606"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1014384571"
end)

AnimationsPS:CreateButton("Popstar", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1212900985"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1150842221"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1212980338"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1212980348"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1212954642"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1213044953"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1212900995"
end)

AnimationsPS:CreateButton("Confident", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1069977950"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1069987858"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1070017263"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1070001516"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1069984524"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1069946257"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1069973677"
end)

AnimationsPS:CreateButton("Patrol", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1149612882"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1150842221"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1151231493"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1150967949"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1148811837"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1148811837"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1148863382"
end)

AnimationsPS:CreateButton("Zombie", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616158929"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616160636"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616161997"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476"
end)

AnimationsPS:CreateButton("Werewolf", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083195517"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083214717"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083178339"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083216690"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083218792"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083182000"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083189019"
end)

AnimationsPS:CreateButton("Vampire", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083445855"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083450166"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083473930"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083462077"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083455352"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083439238"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083443587"
end)

AnimationsPS:CreateButton("Toy", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=782841498"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=782845736"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=782843345"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=782842708"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=782847020"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=782843869"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=782846423"
end)

AnimationsPS:CreateButton("SuperHero", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616111295"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616113536"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616122287"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616117076"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616115533"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616104706"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616108001"
end)

AnimationsPS:CreateButton("Stylish", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616136790"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616138447"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616146177"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616140816"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616139451"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616133594"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616134815"
end)

AnimationsPS:CreateButton("Robot", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616088211"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616089559"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616095330"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616091570"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616090535"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616086039"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616087089"
end)

AnimationsPS:CreateButton("Pirate", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=750781874"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=750782770"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=750785693"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=750783738"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=750782230"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=750779899"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=750780242"
end)

AnimationsPS:CreateButton("Ninja", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=656117400"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=656118341"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=656121766"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=656118852"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=656117878"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=656114359"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=656115606"
end)

AnimationsPS:CreateButton("Mage", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=707742142"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=707855907"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=707897309"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=707861613"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=707853694"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=707826056"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
end)

AnimationsPS:CreateButton("Levitation", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616006778"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616008087"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616010382"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616008936"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616003713"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616005863"
end)

AnimationsPS:CreateButton("Knight", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=657595757"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=657568135"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=657552124"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=657564596"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=658409194"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=658360781"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=657600338"
end)

AnimationsPS:CreateButton("Elder", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=845397899"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=845400520"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=845403856"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=845386501"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=845398858"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=845392038"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=845396048"
end)

AnimationsPS:CreateButton("Cartoony", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=742637544"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=742638445"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=742640026"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=742638842"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=742637942"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=742636889"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=742637151"
end)

AnimationsPS:CreateButton("Bubbly", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=910004836"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=910009958"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=910034870"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=910025107"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=910016857"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=910001910"
Animate.swimidle.SwimIdle.AnimationId = "http://www.roblox.com/asset/?id=910030921"
Animate.swim.Swim.AnimationId = "http://www.roblox.com/asset/?id=910028158"
end)

AnimationsPS:CreateButton("Astronaut", function ()
local Animate = game.Players.LocalPlayer.Character.Animate
Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=891621366"
Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=891633237"
Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=891667138"
Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=891636393"
Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=891627522"
Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=891609353"
Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=891617961"
end)

PremiumPS:CreateButton("Get Fake Gun", function()
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("FakeGun"):FireServer(unpack({
    [1] = true -- set to true to activate
}))
end)

PremiumPS:CreateButton("Drop Fake Gun", function()
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("FakeGun"):FireServer(unpack({
    [1] = true -- set to true to activate
}))

wait(0.2)

game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace
end)

PremiumPS:CreateToggle("Fake Gun Rain", {Toggled=false , Description = false}, function(val)
if val then
LoopDropFakeGun = RS.RenderStepped:Connect(function()
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("FakeGun"):FireServer(unpack({
    [1] = true -- set to true to activate
}))

wait(0.2)

game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Workspace
end)
else
LoopDropFakeGun:Disconnect()
end
end)

PremiumPS:CreateButton("Clear Dropped Guns (Server Sided)", function()
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
end)

PremiumPS:CreateButton("Clear Dropped Guns (Client Sided)", function()
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
end)

PremiumPS:CreateButton("Clear Fake Guns From Inventory", function()
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
end)

PremiumPS:CreateButton("Break Gun", function()
for _, v in pairs(game:GetService("Players"):GetPlayers()) do
    if v ~= game.Players.LocalPlayer and v.Backpack:FindFirstChild("Gun") and v.Character ~= nil then
        v.Backpack.Gun.KnifeServer.ShootGun:InvokeServer(1, 0, "AH")
    elseif v ~= game.Players.LocalPlayer and v.Character:FindFirstChild("Gun") and v.Character ~= nil then
        v.Character.Gun.KnifeServer.ShootGun:InvokeServer(1, 0, "AH")
    end
end
end)

PremiumPS:CreateToggle("Loop Break Gun", {Toggled=false , Description = false}, function(val)
if val then
LoopBreakG = RS.RenderStepped:Connect(function()
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Backpack:FindFirstChild("Gun") and v.Character ~= nil then
            v.Backpack.Gun.KnifeServer.ShootGun:InvokeServer(1, 0, "AH")
        elseif v ~= game.Players.LocalPlayer and v.Character:FindFirstChild("Gun") and v.Character ~= nil then
            v.Character.Gun.KnifeServer.ShootGun:InvokeServer(1, 0, "AH")
        end
    end
end)
else
LoopBreakG:Disconnect()
end
end)

PremiumPS:CreateButton("2 Lives", function()
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
end)

PremiumPS:CreateToggle("Loop 2 Lives", {Toggled=false , Description = false}, function(val)
   godmodetoggle = val
if godmodetoggle then
while wait(0.5) do task.wait(0.25)
pcall(function()
GodMode()
end)
if not godmodetoggle then
break
end
end
end
end)

local TouchFlig = nil -- Declare TouchFlig outside the toggle function

PremiumPS:CreateToggle("Touch Fling", {Toggled=false , Description=false}, function(val)
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

PremiumPS:CreateTextbox("Fling Player", false, function(playerName)
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local Targets = {playerName}

    local AllBool = false

    local function GetPlayer(Name)
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

    local function Message(_Title, _Text, Time)
        print(_Title)
        print(_Text)
        print(Time)
    end

    local function SkidFling(TargetPlayer)
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
        print("Flinging", TargetPlayer.Name)
    end

    -- Main logic
    if Targets[1] then 
        for _, x in next, Targets do 
            local targetPlayer = GetPlayer(x)
            if targetPlayer then
                SkidFling(targetPlayer)
            end
        end
    else
        return
    end

    if AllBool then
        for _, x in next, Players:GetPlayers() do
            if x ~= Player then
                SkidFling(x)
            end
        end
    end
end)

PremiumPS:CreateTextbox("Silent Fling Player", false, function(playerName)
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local Targets = {playerName}

    local AllBool = false

    local function GetPlayer(Name)
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

    local function Message(_Title, _Text, Time)
        print(_Title)
        print(_Text)
        print(Time)
    end

    local function SkiFling(TargetPlayer)
        -- Call the provided script at the beginning
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("Stealth"):FireServer(unpack({
            [1] = true -- set to true to activate
        }))
        
        wait(1)
        
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
        print("Flinging", TargetPlayer.Name)

        -- Simulate flinging duration with a wait
        wait(1)  -- Adjust the duration as needed

        -- Set the script to false after flinging
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("Stealth"):FireServer(unpack({
            [1] = false -- set to false to deactivate
        }))
    end

    -- Main logic
    if Targets[1] then 
        for _, x in next, Targets do 
            local targetPlayer = GetPlayer(x)
            if targetPlayer then
                SkiFling(targetPlayer)
            end
        end
    else
        return
    end

    if AllBool then
        for _, x in next, Players:GetPlayers() do
            if x ~= Player then
                SkiFling(x)
            end
        end
    end
end)

PremiumPS:CreateButton("Fling All", function()
-- Define the function to perform the fling
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

-- Call the function to perform the fling when the script is executed with a player name (e.g., "fling 'playerName'")
performFling("all")
end)

PremiumPS:CreateButton("Fling Murderer", function()
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
end)

PremiumPS:CreateButton("Fling Murderer V2", function()
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
end)

PremiumPS:CreateButton("Fling Sheriff", function()
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
end)

PremiumPS:CreateButton("Fling Sheriff V2", function()
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
end)

PremiumPS:CreateButton("Fling Murderer and Sheriff", function()
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
end)

PremiumPS:CreateButton("Silent Fling Murderer", function()
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
end)

PremiumPS:CreateButton("Silent Fling Sheriff", function()
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
end)

PremiumPS:CreateToggle("Spam Trade GUI", {Toggled=false , Description = false}, function(val)
if val then
local function CreateGUI()
    local gui = Instance.new("ScreenGui")
    local mainFrame = Instance.new("Frame")
    local dragFrame = Instance.new("Frame")
    local titleLabel = Instance.new("TextLabel")
    local closeButton = Instance.new("TextButton")
    local playerTextBox = Instance.new("TextBox")
    local tradeButton = Instance.new("TextButton")
    local looptradeButton = Instance.new("TextButton")

    gui.Parent = game.CoreGui

    mainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    mainFrame.BackgroundTransparency = 0.5
    mainFrame.Position = UDim2.new(0, 670, 0, 100)
    mainFrame.Size = UDim2.new(0, 200, 0, 30)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = gui

    -- Create an outline frame
    local outlineFrame = Instance.new("Frame")
    outlineFrame.Size = UDim2.new(1, 0, 1, 1)
    outlineFrame.Position = UDim2.new(-0.00, 0, -0.04, 0)
    outlineFrame.Parent = mainFrame

    local function rainbowColor()
        local frequency = 0.7
        local time = tick()
        local r = math.sin(frequency * time + 0) * 127 + 128
        local g = math.sin(frequency * time + 2) * 127 + 128
        local b = math.sin(frequency * time + 4) * 127 + 128
        return Color3.new(r / 255, g / 255, b / 255)
    end

    local function updateOutlineColor()
        outlineFrame.BackgroundColor3 = rainbowColor()
    end

    game:GetService("RunService").RenderStepped:Connect(updateOutlineColor)

    dragFrame.Name = "DragFrame"
    dragFrame.Parent = mainFrame
    dragFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    dragFrame.BackgroundTransparency = 0.8
    dragFrame.Size = UDim2.new(1, 0, 0, 30)

    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.Font = Enum.Font.Roboto
    titleLabel.Text = "MM2 Spam Trade GUI"
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.TextSize = 20
    titleLabel.TextStrokeTransparency = 0.2
    titleLabel.Parent = mainFrame

    local dragging = false
    local dragStart
    local startPos

    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    playerTextBox.Name = "PlayerTextBox"
    playerTextBox.Parent = mainFrame
    playerTextBox.BackgroundColor3 = Color3.new(0, 0, 0)
    playerTextBox.BackgroundTransparency = 0
    playerTextBox.Position = UDim2.new(0.5, -100, 0.5, 15)
    playerTextBox.Size = UDim2.new(0, 200, 0, 30)
    playerTextBox.Font = Enum.Font.Roboto
    playerTextBox.PlaceholderText = "User here! (can be short)"
    playerTextBox.Text = ""
    playerTextBox.TextColor3 = Color3.new(1, 1, 1)
    playerTextBox.TextSize = 16
    playerTextBox.TextStrokeTransparency = 0

local function autoCompletePlayerName()
    local partialName = playerTextBox.Text:lower() -- Convert to lowercase for case-insensitive comparison
    local players = game:GetService("Players"):GetPlayers()

    for _, player in pairs(players) do
        local playerName = player.Name:lower()
        if playerName:sub(1, #partialName) == partialName then
            playerTextBox.Text = player.Name
            break
        end
    end
end

playerTextBox.Focused:Connect(function()
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Return then
            autoCompletePlayerName()
        end
    end)
end)

    tradeButton.Name = "TradeButton"
    tradeButton.Parent = mainFrame
    tradeButton.BackgroundColor3 = Color3.new(0, 0.0, 0)
    tradeButton.Position = UDim2.new(0.5, -100, 0.5, 46)
    tradeButton.Size = UDim2.new(0, 100, 0, 30)
    tradeButton.Font = Enum.Font.Roboto
    tradeButton.Text = "Trade"
    tradeButton.TextColor3 = Color3.new(1, 1, 1)
    tradeButton.TextSize = 16
    tradeButton.TextStrokeTransparency = 0.2

    looptradeButton.Name = "LoopTradeButton"
    looptradeButton.Parent = mainFrame
    looptradeButton.BackgroundColor3 = Color3.new(0, 0.0, 0)
    looptradeButton.Position = UDim2.new(0.5, 0, 0.5, 46)
    looptradeButton.Size = UDim2.new(0, 100, 0, 30)
    looptradeButton.Font = Enum.Font.Roboto
    looptradeButton.Text = "Loop"
    looptradeButton.TextColor3 = Color3.new(1, 1, 1)
    looptradeButton.TextSize = 16
    looptradeButton.TextStrokeTransparency = 0.2

    tradeButton.MouseButton1Click:Connect(function()
        local targetPlayerName = playerTextBox.Text
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
    end)

    local isLooping = false
    local loopTradeConnection

    local function startLoop()
        isLooping = true

        loopTradeConnection = spawn(function()
            while isLooping do
                local targetPlayerName = playerTextBox.Text
                local targetPlayer = game:GetService("Players"):FindFirstChild(targetPlayerName)

                if targetPlayer then
                    local args = {
                        [1] = targetPlayer
                    }

                    game:GetService("ReplicatedStorage"):WaitForChild("Trade"):WaitForChild("SendRequest"):InvokeServer(unpack(args))

                    game:GetService("ReplicatedStorage"):WaitForChild("Trade"):WaitForChild("AcceptRequest"):FireServer()

                    wait(0) -- Adjust the delay as needed
                else
                    warn("Player not found:", targetPlayerName)
                end
            end
        end)
    end

    local function stopLoop()
        isLooping = false
        if loopTradeConnection then
            loopTradeConnection:Destroy()
        end
    end

looptradeButton.MouseButton1Click:Connect(function()
    local targetPlayerName = playerTextBox.Text
    if targetPlayerName ~= "" then
        if isLooping then
            stopLoop()
            looptradeButton.Text = "Loop"
            looptradeButton.TextColor3 = Color3.new(1, 1, 1) -- Change text color to white
        else
            startLoop()
            looptradeButton.Text = "Stop"
            looptradeButton.TextColor3 = Color3.new(1, 0, 0) -- Change text color to red
        end
    else
        warn("Please enter a player name before starting the loop.")
    end
end)
end

CreateGUI()
	else
        local gui = game.CoreGui:FindFirstChild("ScreenGui") -- Assuming "ScreenGui" is the name of the ScreenGui
        if gui then
            gui:Destroy()
        end
    end
end)

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

-- PremiumPS:CreateToggle callback function
PremiumPS:CreateToggle("Remove Trade GUI", {Toggled = false, Description = false}, function(val)
    -- Toggle logic
    if val then
        -- Call the function to remove TradeGUI
        removeTradeGUI()
    else
        -- Call the function to restore TradeGUI
        restoreTradeGUI()
    end
end)

PremiumPS:CreateButton("Get Murderer Knife", function()
for i,s in pairs(Players:GetPlayers()) do
if s ~= Players.LocalPlayer and s.Backpack:FindFirstChild("Knife") or s.Character:FindFirstChild("Knife") then
s.Backpack.Knife.Parent = Players.LocalPlayer.Backpack
end
end
end)

PremiumPS:CreateButton("Get Sheriff Gun", function()
for i,s in pairs(Players:GetPlayers()) do
if s ~= Players.LocalPlayer and s.Backpack:FindFirstChild("Gun") or s.Character:FindFirstChild("Gun") then
s.Backpack.Gun.Parent = Players.LocalPlayer.Backpack
end
end
end)

PremiumPS:CreateButton("Glitch Your Arm", function()
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
end)

local isScriptRunning = false
local selectedPlayer = nil
local playerDropdown = nil

-- Function to update the player list in the dropdown
local function updatePlayerList()
    local playerList = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        table.insert(playerList, player.Name)
    end

    if playerDropdown then
        playerDropdown:Clear()
        playerDropdown:Add(playerList)
    end
end

-- Assuming PremiumPS:CreateDropdown is a function that creates a dropdown menu
playerDropdown = PremiumPS:CreateDropdown("Select Target Player", {List = {}, Default = ""}, function(player)
    selectedPlayer = player
end)

-- Initial population of player list
updatePlayerList()

-- Listen for player added and player removing events
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)

PremiumPS:CreateButton("Reset Player (Spray Paint)", function()
    if selectedPlayer and game.Players[selectedPlayer] and game.Players[selectedPlayer].Character and game.Players[selectedPlayer].Character:FindFirstChild("Head") then
        local args = {
            [1] = 80373024,
            [2] = Enum.NormalId.Back,
            [3] = 15,
            [4] = workspace[selectedPlayer].Head,
            [5] = CFrame.new(0, math.huge, 0)
        }

        if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
            game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
            game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
            game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
            game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
            game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
            game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
            game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
        end
    end
end)

local loopToggle = PremiumPS:CreateToggle("Loop Reset Player (Spray Paint)", { Toggled = false, Description = false }, function(val)
    if val then
        isScriptRunning = true
        while isScriptRunning do
            wait(0)  -- Adjust the delay as needed

            if selectedPlayer and game.Players[selectedPlayer] and game.Players[selectedPlayer].Character and game.Players[selectedPlayer].Character:FindFirstChild("Head") then
                local args = {
                    [1] = 80373024,
                    [2] = Enum.NormalId.Back,
                    [3] = 15,
                    [4] = workspace[selectedPlayer].Head,
                    [5] = CFrame.new(0, math.huge, 0)
                }

                -- Your existing code to reset the player goes here
                if game.Players.LocalPlayer.Character ~= nil then
                    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
                        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
                        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                    end
                end
            end
        end
    else
        isScriptRunning = false
    end
end)

PremiumPS:CreateButton("Reset All (Spray Paint)", function()
if game.Players.LocalPlayer.Character ~= nil then
for i, v in pairs(game.Players:GetPlayers()) do
if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("Head") then
local args = {
    [1] = 80373024,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[v.Name].Head,
    [5] = CFrame.new(0, math.huge, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
    end
end
end
end
end)

local isScriptRunning = false -- Set the initial state to false

PremiumPS:CreateToggle("Loop Reset All (Spray Paint)", {Toggled=false , Description = false}, function(val)
    isScriptRunning = val -- Update the script state based on the toggle value

    while isScriptRunning do
        if game.Players.LocalPlayer.Character ~= nil then
            for i, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("Head") then
                    local args = {
                        [1] = 80373024,
                        [2] = Enum.NormalId.Back,
                        [3] = 15,
                        [4] = workspace[v.Name].Head,
                        [5] = CFrame.new(0, math.huge, 0)
                    }
                    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
                        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
                        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                    end
                end
            end
        end

        wait(1)
    end
end)

local isScriptFunky = false
local selectedGlitchPlayer = ""
local glitchPlayerDropdown = nil
local applyFlingStrength = 1

-- Function to update the glitch player list in the dropdown
local function updateGlitchPlayerList()
    local glitchPlayerList = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        table.insert(glitchPlayerList, player.Name)
    end

    if glitchPlayerDropdown then
        glitchPlayerDropdown:Clear()
        glitchPlayerDropdown:Add(glitchPlayerList)
    end
end

-- Assuming PremiumPS:CreateDropdown is a function that creates a dropdown menu
glitchPlayerDropdown = PremiumPS:CreateDropdown("Select Target Glitch Player", {List = {}, Default = ""}, function(player)
    selectedGlitchPlayer = player
end)

-- Initial population of glitch player list
updateGlitchPlayerList()

-- Listen for player added and player removing events
game.Players.PlayerAdded:Connect(updateGlitchPlayerList)
game.Players.PlayerRemoving:Connect(updateGlitchPlayerList)

applyfling = 1
PremiumPS:CreateSlider("Glitch Strength", {Min = 1, Max = 15, DefaultValue = 1}, function(flingstr)
    applyFlingStrength = flingstr
end)

PremiumPS:CreateButton("Glitch Player (Spray Paint)", function()
    if selectedGlitchPlayer ~= "" then
        if game.Players.LocalPlayer.Character ~= nil then
            local targetPlayer = nil

            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Name:sub(1, #selectedGlitchPlayer):lower() == selectedGlitchPlayer:lower() then
                    targetPlayer = player
                    break
                end
            end

            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("LeftHand") then
                local args = {
                    [1] = 80373024,
                    [2] = Enum.NormalId.Back,
                    [3] = applyFlingStrength,
                    [4] = workspace[targetPlayer.Name].LeftHand,
                    [5] = CFrame.new(0, 0, 0)
                }

                -- Your existing code to glitch the player goes here
                if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                    game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                    game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
                    game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                    game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                end
            end
        end
    end
end)

local glitchLoopToggle = PremiumPS:CreateToggle("Loop Glitch Player (Spray Paint)", { Toggled = false, Description = false }, function(val)
    isScriptFunky = val -- Update the toggle state

    while isScriptFunky do
        wait(glitchLoopDelay)

        if selectedGlitchPlayer ~= "" then
            if game.Players.LocalPlayer.Character ~= nil then
                local targetPlayer = nil

                for _, player in pairs(game.Players:GetPlayers()) do
                    if player.Name:sub(1, #selectedGlitchPlayer):lower() == selectedGlitchPlayer:lower() then
                        targetPlayer = player
                        break
                    end
                end

                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("LeftHand") then
                    local args = {
                        [1] = 80373024,
                        [2] = Enum.NormalId.Back,
                        [3] = applyFlingStrength,
                        [4] = workspace[targetPlayer.Name].LeftHand,
                        [5] = CFrame.new(0, 0, 0)
                    }

                    -- Your existing code to glitch the player goes here
                    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
                        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
                        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                    end
                end
            end
        end
    end
end)

PremiumPS:CreateButton("Glitch All (Spray Paint)", function ()
if game.Players.LocalPlayer.Character ~= nil then
for i, v in pairs(game.Players:GetPlayers()) do
if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("LeftHand") then
local args = {
    [1] = 80373024,
    [2] = Enum.NormalId.Back,
    [3] = applyfling,
    [4] = workspace[v.Name].LeftHand,
    [5] = CFrame.new(0, 0, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
    end
end
end
end
end)

local isScriptCucking = false

PremiumPS:CreateToggle("Loop Glitch All", {Toggled=false , Description = false}, function(val)
    isScriptCucking = val -- Update the script state based on the toggle value

while isScriptCucking do
    if game.Players.LocalPlayer.Character ~= nil then
        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("LeftHand") then
                local args = {
                    [1] = 80373024,
                    [2] = Enum.NormalId.Back,
                    [3] = applyfling,
                    [4] = workspace[v.Name].LeftHand,
                    [5] = CFrame.new(0, 0, 0)
                }

                if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                    game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                    game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
                    game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                    game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                end
            end
        end
    end
    wait(16.1)
end
end)

Ssprayid = 60484593
local isScriptSpruce = false -- Set the initial state to false

PremiumPS:CreateToggle("Loop Blind All (Spray Paint)", {Toggled=false , Description = false}, function(val)
    isScriptSpruce = val -- Update the script state based on the toggle value

    while isScriptSpruce do
if game.Players.LocalPlayer.Character ~= nil then
        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") then
                if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        local posofpl = workspace[v.Name].HumanoidRootPart.CFrame
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-2.86, 0.1, 0))
game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        local posofpl = workspace[v.Name].HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-2.86, 0.1, 0))
game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
        local posofpl = workspace[v.Name].HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-2.86, 0.1, 0))
game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                end
            end
        end
    end
    wait(15.5)
end
end)

local isScriptShitting = false
local targetPlayerShit = ""
local noclipPlayerDropdown = nil
local noclipLoopDelay = 15.5

-- Function to update the noclip player list in the dropdown
local function updateNoclipPlayerList()
    local noclipPlayerList = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        table.insert(noclipPlayerList, player.Name)
    end

    if noclipPlayerDropdown then
        noclipPlayerDropdown:Clear()
        noclipPlayerDropdown:Add(noclipPlayerList)
    end
end

-- Assuming PremiumPS:CreateDropdown is a function that creates a dropdown menu
noclipPlayerDropdown = PremiumPS:CreateDropdown("Select Target Noclip Player", {List = {}, Default = ""}, function(player)
    targetPlayerShit = player
end)

-- Initial population of noclip player list
updateNoclipPlayerList()

-- Listen for player added and player removing events
game.Players.PlayerAdded:Connect(updateNoclipPlayerList)
game.Players.PlayerRemoving:Connect(updateNoclipPlayerList)

PremiumPS:CreateButton("Apply Noclip to Player", function()
    if game.Players.LocalPlayer.Character ~= nil then
        local targetPlayer = nil

        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Name:sub(1, #targetPlayerShit):lower() == targetPlayerShit:lower() then
                targetPlayer = player
                break
            end
        end

        if targetPlayer and targetPlayer.Character ~= nil then
            local args = {
                [1] = 0,
                [2] = Enum.NormalId.Bottom,
                [3] = 6.331,
                [4] = workspace[targetPlayer.Name].HumanoidRootPart,
                [5] = workspace[targetPlayer.Name].HumanoidRootPart.CFrame * CFrame.new(0, 99999, 0)
            }

            -- Your existing code to make the player noclip goes here
            if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
                game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
                game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
                game.Players.LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
            elseif game.Players.LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
                game.Players.LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                game.Players.LocalPlayer.Character.SprayPaint.Parent = game.Players.LocalPlayer.Backpack
            elseif game.Players.LocalPlayer.Character:FindFirstChild("SprayPaint") then
                game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
            end
        end
    end
end)

PremiumPS:CreateToggle("Loop Apply Noclip to Player (Spray Paint)", { Toggled = false, Description = false }, function(val)
    isScriptShitting = val

    while isScriptShitting do
        if targetPlayerShit then
            local targetPlayer = nil
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Name:sub(1, #targetPlayerShit):lower() == targetPlayerShit:lower() then
                    targetPlayer = player
                    break
                end
            end

            if targetPlayer then
                if targetPlayer.Character and game.Players.LocalPlayer.Character then
                    local args = {
                        [1] = 0,
                        [2] = Enum.NormalId.Bottom,
                        [3] = 6.331,
                        [4] = targetPlayer.Character.HumanoidRootPart,
                        [5] = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 99999, 0)
                    }

                    -- Your existing code to make the player noclip goes here
                    if game.Players.LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
                        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
                        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
                        game.Players.LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                        game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                    elseif game.Players.LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
                        game.Players.LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                        game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                        game.Players.LocalPlayer.Character.SprayPaint.Parent = game.Players.LocalPlayer.Backpack
                    elseif game.Players.LocalPlayer.Character:FindFirstChild("SprayPaint") then
                        game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(unpack(args))
                    end
                end
            end
        end
        wait(noclipLoopDelay)
    end
end)

PremiumPS:CreateButton("Steal Gun From Sheriff", function ()
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
end)

SettingsPS:CreateButton("Reset", function ()
lp.Character.Humanoid.Health = 0
lp.Character.Head:Remove()
lp.Character.Humanoid.BreakJointsOnDeath = false
end)

SettingsPS:CreateButton("Leave Game", function()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function KickPlayer()
    LocalPlayer:Kick("You have been kicked from the server.")
end

KickPlayer()
end)

SettingsPS:CreateButton("Fe Emotes", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FEmotesGui/main/FEmotesGui.lua", true))()
end)

SettingsPS:CreateButton("Shift Lock", function()
loadstring(game:HttpGet('https://pastebin.com/raw/CjNsnSDy'))()
end)

SettingsPS:CreateButton("Rtx", function()
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
end)

SettingsPS:CreateButton("Night Time", function()
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
end)

SettingsPS:CreateButton("A Special Night", function()
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
end)

local gui = Instance.new("ScreenGui")
gui.Name = "ToggleUiDCCHub"
gui.Parent = game.CoreGui

local toggleui = Instance.new("TextButton")
toggleui.Size = UDim2.new(0, 75, 0, 75)
toggleui.Position = UDim2.new(0.01001973976, 0, 0.343832953, 0)
toggleui.BackgroundColor3 = Color3.fromRGB(28,28,28)
toggleui.Active = true
toggleui.Draggable = true
toggleui.Parent = gui
toggleui.Text = "Toggle Ui"
toggleui.TextSize = 18
toggleui.TextScaled = true
toggleui.TextColor3 = Color3.fromRGB(255,255,255)
toggleui.Font = Enum.Font.SourceSans
toggleui.ZIndex = 0

local toggleKey = Enum.KeyCode.M 

UserInputService.InputBegan:Connect(function(input, processed)
    if input.KeyCode == toggleKey and not processed then
        uilibrary:ToggleUI()
    end
end)

toggleui.MouseButton1Click:Connect(function()
uilibrary:ToggleUI()
end)

coroutine.wrap(function()
    repeat wait()
        pcall(function()
            Murderer = GetMurderer()
            Sheriff = GetSheriff()
        end)
    until Murderer and Sheriff
end)()

mouse.Button1Down:Connect(
    function()
        pcall(
            function()
                if SilentAimEnable then
                    for _, Player in pairs(Players:GetPlayers()) do
                        if Player.Name ~= Players.LocalPlayer.Name then
                            if Player and Player.Character and Player.Character:FindFirstChild("Knife") then
                                for i, MyTool in pairs(Players.LocalPlayer.Character:GetChildren()) do
                                    if MyTool.Name == "Gun" and MyTool:IsA("Tool") and MyTool:FindFirstChild("KnifeServer") then
                                     if getgenv().ShooterHarp == "Head" then
                                        MyTool.KnifeServer.ShootGun:InvokeServer(1, Player.Character.Head.Position, "AH")
                                     elseif getgenv().ShooterHarp == "Humanoid" then
                                     MyTool.KnifeServer.ShootGun:InvokeServer(1, Player.Character.HumanoidRootPart.Position, "AH")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        )
    end
)

mouse.Button1Down:Connect(
    function()
        pcall(
            function()
                if KnifeSilentAimEnabled then
                    for _, Player in pairs(Players:GetPlayers()) do
                        if Player ~= Players.LocalPlayer then
                            if Player and lp then
                                for i, MyTool in pairs(Players.LocalPlayer.Character:GetChildren()) do
                                    if MyTool.Name == "Knife" and MyTool:IsA("Tool") and MyTool:FindFirstChild("Throw") then
                                        MyTool.Throw:FireServer(unpack({
                                         [1] = lp.Character.Head.CFrame,
                                         [2] = Player.Character.HumanoidRootPart.Position
                                        }))
                                    end
                                end
                            end
                        end
                    end
                end
            end
        )
    end
)

if not game.Workspace:FindFirstChild("TpVoid") then
local TpVoid = Instance.new("Part", game.Workspace)
TpVoid.Anchored = true
TpVoid.Name = "TpVoid"
TpVoid.Transparency = 0.8
TpVoid.Position = Vector3.new(-74, -9, 694)
TpVoid.Size = Vector3.new(20,0,20)
else
end
end	
loadcurui()
else
warn("Tranquil has already loaded...", 10)
end
end
