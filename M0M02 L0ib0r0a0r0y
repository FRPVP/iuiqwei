local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

roles = game:GetService("ReplicatedStorage"):FindFirstChild("GetPlayerData", true):InvokeServer()

local MM2 = Library:NewWindow("MM2 Mods")

local Mains = MM2:NewSection("Main")
local Sprayfunc = MM2:NewSection("Spray Paint Mods")
local Sprayfun = MM2:NewSection("Spray Paint Fun")
local Trapfunc = MM2:NewSection("Trap Perk Mods")
local Gunfunc = MM2:NewSection("Fake Gun Perk Mods")
local Stealthfunc = MM2:NewSection("Stealth Perk Mods")
local Multi = MM2:NewSection("MultiCrash")
local Opti = MM2:NewSection("Optimization")

if not workspace:FindFirstChild("KillpartsVisual") then
local folder = Instance.new("Folder", workspace)
folder.Name = "KillpartsVisual"
end

function CreateHighlight()
	for i, v in pairs(game.Players:GetPlayers()) do
		if v ~= game:GetService("Players").LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") and not v.Character:FindFirstChild("ESP_Highlight") then
			local esphigh = Instance.new("Highlight", v.Character)
            esphigh.Name = "ESP_Highlight"
            esphigh.FillColor = Color3.fromRGB(160, 160, 160)
            esphigh.OutlineTransparency = 1
            esphigh.FillTransparency = applyesptrans   
        end
	end
end

function UpdateHighlights()
	for _, v in pairs(game.Players:GetPlayers()) do
		if v ~= game:GetService("Players").LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("ESP_Highlight") then
			local Highlight = v.Character:FindFirstChild("ESP_Highlight")
			if v.Name == Sheriff and IsAlive(v) then
				Highlight.FillColor = Color3.fromRGB(0, 0, 225)
                Highlight.FillTransparency = applyesptrans
			elseif v.Name == Murder and IsAlive(v) then
				Highlight.FillColor = Color3.fromRGB(225, 0, 0)
                Highlight.FillTransparency = applyesptrans
			elseif v.Name == Hero and IsAlive(v) and v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
				Highlight.FillColor = Color3.fromRGB(255, 255, 0)
                Highlight.FillTransparency = applyesptrans
			elseif not IsAlive(v) then
				Highlight.FillColor = Color3.fromRGB(100, 100, 100)
                Highlight.FillTransparency = applyesptrans
			else
				Highlight.FillColor = Color3.fromRGB(0, 225, 0)
                Highlight.FillTransparency = applyesptrans
			end
		end
	end
end	

function IsAlive(Player)
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

function HideHighlights()
	for _, v in pairs(game.Players:GetPlayers()) do
		if v ~= game:GetService("Players").LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("ESP_Highlight") then
			v.Character:FindFirstChild("ESP_Highlight"):Destroy()
		end
	end
end

applyesptrans = 0.5
Mains:CreateToggle("ESP Players", function(SeeRoles)
if SeeRoles then
SSeeRoles = true
while SSeeRoles == true do
    roles = game:GetService("ReplicatedStorage"):FindFirstChild("GetPlayerData", true):InvokeServer()
	for i, v in pairs(roles) do
		if v.Role == "Murderer" then
			Murder = i
		elseif v.Role == "Sheriff" then
			Sheriff = i
		elseif v.Role == "Hero" then
			Hero = i
		end
	end
	CreateHighlight()
	UpdateHighlights()
        end
else
    SSeeRoles = false
    task.wait(0.2)
    HideHighlights()
end
end)

Mains:CreateToggle("ESP Gun Drop", function(SeeGun)
if SeeGun then
    SSeeGun = true
    while SSeeGun == true do
        repeat wait()
        until workspace:FindFirstChild("GunDrop")
        if workspace:FindFirstChild("GunDrop") and not workspace.GunDrop:FindFirstChild("Esp_gun") then
            if SSeeGun == true then
                game:GetService("StarterGui"):SetCore("SendNotification",{
                	Title = "MM2 Mods",
                	Text = "Gun is Dropped",
                	Icon = "rbxassetid://6467185020",
                   Duration = 2
                })
                local espgunhigh = Instance.new("Highlight", workspace:FindFirstChild("GunDrop"))
                espgunhigh.Name = "Esp_gun"
                espgunhigh.FillColor = Color3.fromRGB(0, 0, 0)
                espgunhigh.OutlineTransparency = 1
                espgunhigh.FillTransparency = 0
            end
        end
    end
else
    SSeeGun = false
    task.wait(0.2)
    if workspace:FindFirstChild("GunDrop") and workspace.GunDrop:FindFirstChild("Esp_gun") then
        workspace.GunDrop:FindFirstChild("Esp_gun"):Destroy()
    end
end
end)

Mains:CreateSlider("ESP Transparency", 0, 1, 0.5, true, function(esptrans)
    applyesptrans = esptrans
end)

Mains:CreateButton("Create Fake Knife", function()
if game.Players.LocalPlayer.Character ~= nil then
local lp = game.Players.LocalPlayer
local tool;local handle;local knife;
local animation1 = Instance.new("Animation")
animation1.AnimationId = "rbxassetid://2467567750"
local animation2 = Instance.new("Animation")
animation2.AnimationId = "rbxassetid://1957890538"
local anims = {animation1,animation2}
tool = Instance.new("Tool")
tool.Name = "Fake Knife"
tool.Grip = CFrame.new(0, -1.16999984, 0.0699999481, 1, 0, 0, 0, 1, 0, 0, 0, 1)
tool.GripForward = Vector3.new(-0, -0, -1)
tool.GripPos = Vector3.new(0,-1.17,0.0699999)
tool.GripRight = Vector3.new(1,0,0)
tool.GripUp = Vector3.new(0,1,0)
handle = Instance.new("Part")
handle.Size = Vector3.new(0.310638815, 3.42103457, 1.08775854)
handle.Name = "Handle"
handle.Transparency = 1
handle.Parent = tool
tool.Parent = lp.Backpack
knife=lp.Character:WaitForChild("KnifeDisplay")
knife.Massless = true
lp:GetMouse().Button1Down:Connect(function()
if tool and  tool.Parent == lp.Character then
local an = lp.Character.Humanoid:LoadAnimation(anims[math.random(1,2)])
an:Play()
end
end)
local aa = Instance.new("Attachment",handle)
local ba = Instance.new("Attachment",knife)
local hinge = Instance.new("HingeConstraint",knife)
hinge.Attachment0=aa hinge.Attachment1=ba
hinge.LimitsEnabled = true
hinge.LowerAngle = 0
hinge.Restitution = 0
hinge.UpperAngle = 0
lp.Character:WaitForChild"UpperTorso":FindFirstChild("Weld"):Destroy()
game:GetService"RunService".Heartbeat:Connect(function()
setsimulationradius(1/0,1/0)
if tool.Parent == lp.Character then
knife.CFrame = handle.CFrame
else
knife.CFrame = lp.Character:WaitForChild"UpperTorso".CFrame
end
end)
end
end)

Mains:CreateButton("Break Gun", function()
for _, v in pairs(game:GetService("Players"):GetPlayers()) do
    if v ~= game.Players.LocalPlayer and v.Backpack:FindFirstChild("Gun") and v.Character ~= nil then
        v.Backpack.Gun.KnifeServer.ShootGun:InvokeServer(1, 0, "AH")
    elseif v ~= game.Players.LocalPlayer and v.Character:FindFirstChild("Gun") and v.Character ~= nil then
        v.Character.Gun.KnifeServer.ShootGun:InvokeServer(1, 0, "AH")
    end
end
end)

Mains:CreateButton("(Alive) Grab Gun", function()
if game.Players.LocalPlayer.Character ~= nil then
local gundr = workspace:FindFirstChild("GunDrop")
if gundr and IsAlive(game.Players.LocalPlayer) then
    local oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    repeat
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = gundr.CFrame * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))
        task.wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = gundr.CFrame * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))
        task.wait()
    until not gundr:IsDescendantOf(workspace)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
    oldpos = false
end
end
end)

Mains:CreateButton("(Dead) Grab Gun", function()
if game.Players.LocalPlayer.Character ~= nil then
local gundr = workspace:FindFirstChild("GunDrop")
if gundr then
    local oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    repeat
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = gundr.CFrame * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))
        task.wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = gundr.CFrame * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0))
        task.wait()
    until not gundr:IsDescendantOf(workspace)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
    oldpos = false
end
end
end)

Mains:CreateDropdown("Teleports", {"Lobby", "Map", "PlrY + 100", "PlrY - 100"}, 1, function(tppos)
if game.Players.LocalPlayer.Character ~= nil then
if tppos == "Lobby" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-111, 137, 37)
end
if tppos == "Map" then
for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Model") and v.Name == "Bank2" then
        local spawns = workspace["Bank2"].Spawns:GetChildren()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Bank2"].Spawns:GetChildren()[math.random(1,#spawns)].CFrame * CFrame.new(0, 2, 0)
    elseif v:IsA("Model") and v.Name == "BioLab" then
        local spawns = workspace["BioLab"].Spawns:GetChildren()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["BioLab"].Spawns:GetChildren()[math.random(1,#spawns)].CFrame * CFrame.new(0, 2, 0)
    elseif v:IsA("Model") and v.Name == "Factory" then
        local spawns = workspace["Factory"].Spawns:GetChildren()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Factory"].Spawns:GetChildren()[math.random(1,#spawns)].CFrame * CFrame.new(0, 2, 0)
    elseif v:IsA("Model") and v.Name == "Hospital3" then
        local spawns = workspace["Hospital3"].Spawns:GetChildren()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Hospital3"].Spawns:GetChildren()[math.random(1,#spawns)].CFrame * CFrame.new(0, 2, 0)
    elseif v:IsA("Model") and v.Name == "Hotel" then
        local spawns = workspace["Hotel"].Spawns:GetChildren()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Hotel"].Spawns:GetChildren()[math.random(1,#spawns)].CFrame * CFrame.new(0, 2, 0)
    elseif v:IsA("Model") and v.Name == "House2" then
        local spawns = workspace["House2"].Spawns:GetChildren()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["House2"].Spawns:GetChildren()[math.random(1,#spawns)].CFrame * CFrame.new(0, 2, 0)
    elseif v:IsA("Model") and v.Name == "Mansion2" then
        local spawns = workspace["Mansion2"].Spawns:GetChildren()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Mansion2"].Spawns:GetChildren()[math.random(1,#spawns)].CFrame * CFrame.new(0, 2, 0)
    elseif v:IsA("Model") and v.Name == "MilBase" then
        local spawns = workspace["MilBase"].Spawns:GetChildren()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["MilBase"].Spawns:GetChildren()[math.random(1,#spawns)].CFrame * CFrame.new(0, 2, 0)
    elseif v:IsA("Model") and v.Name == "nSOffice" then
        local spawns = workspace["nSOffice"].Spawns:GetChildren()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["nSOffice"].Spawns:GetChildren()[math.random(1,#spawns)].CFrame * CFrame.new(0, 2, 0)
    elseif v:IsA("Model") and v.Name == "PoliceStation" then
        local spawns = workspace["PoliceStation"].Spawns:GetChildren()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["PoliceStation"].Spawns:GetChildren()[math.random(1,#spawns)].CFrame * CFrame.new(0, 2, 0)
    elseif v:IsA("Model") and v.Name == "ResearchFacility" then
        local spawns = workspace["ResearchFacility"].Spawns:GetChildren()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["ResearchFacility"].Spawns:GetChildren()[math.random(1,#spawns)].CFrame * CFrame.new(0, 2, 0)
    elseif v:IsA("Model") and v.Name == "Workplace" then
        local spawns = workspace["Workplace"].Spawns:GetChildren()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Workplace"].Spawns:GetChildren()[math.random(1,#spawns)].CFrame * CFrame.new(0, 2, 0)
    end
end
end
if tppos == "PlrY + 100" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 100, 0)
end
if tppos == "PlrY - 100" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, -100, 0)
end
    end
end)

function UserFromBox(String)
	for i,v in pairs(game:GetService("Players"):GetPlayers()) do
		if (string.sub(string.lower(v.Name),1,string.len(String))) == string.lower(String) then
			return v
        end
	end
end

Sprayfunc:CreateTextbox("(Shift-Apply) Username", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintModsSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Full Player Name Added",
	Icon = "rbxassetid://6467185020",
    Duration = 2
})
end)

applyfling = 1
Sprayfunc:CreateSlider("Fling Strength", 1, 15, 1, false, function(flingstr)
    applyfling = flingstr
end)

Sprayfunc:CreateButton("Fling [User]", function()
if game.Players.LocalPlayer.Character ~= nil then
if game.Players[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintModsSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].Character ~= nil and game.Players[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintModsSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].Character:FindFirstChild("LeftHand") then
local args = {
    [1] = 80373024,
    [2] = Enum.NormalId.Back,
    [3] = applyfling,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintModsSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].LeftHand,
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
end)

Sprayfunc:CreateButton("Destroy [User]", function()
if game.Players.LocalPlayer.Character ~= nil then
if game.Players[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintModsSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].Character ~= nil and game.Players[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintModsSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].Character:FindFirstChild("Head") then
local args = {
    [1] = 80373024,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintModsSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].Head,
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
end)

Sprayfunc:CreateButton("Ghost [User]", function()
if game.Players.LocalPlayer.Character ~= nil then
if game.Players[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintModsSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].Character ~= nil then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Bottom,
    [3] = 6.331,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintModsSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart,
    [5] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintModsSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart.CFrame * CFrame.new(0, 10010, 0)
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
if game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintModsSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text == game.Players.LocalPlayer.Name then
if game.Players.LocalPlayer.Character:FindFirstChild("LocalGod_Highlight") then
    game.Players.LocalPlayer.Character:FindFirstChild("LocalGod_Highlight"):Destroy()
end
		local localgod = Instance.new("Highlight", game.Players.LocalPlayer.Character)
        localgod.Name = "LocalGod_Highlight"
        localgod.OutlineColor = Color3.fromRGB(255, 215, 0)
        localgod.OutlineTransparency = 0
        localgod.FillTransparency = 1
wait(16.1)
        if localgod then
        localgod:Destroy()
        end
end
end)

Sprayfunc:CreateToggle("Crash/Lag [User]", function(lagdest)
if lagdest then
_G.lagplr = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintModsSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil and p:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 80373024,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintModsSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart,
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
end)
else
_G.lagplr:Disconnect()
end
end)

Sprayfunc:CreateButton("Fling All", function()
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

Sprayfunc:CreateButton("Destroy All", function()
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

Sprayfun:CreateButton("Minecraft Blocks", function()
if game.Players.LocalPlayer.Character ~= nil then
local mouse = game.Players.LocalPlayer:GetMouse()
tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Grass Block"
tool.Activated:connect(function()
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267183944, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267089525, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267183944, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267089525, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267183944, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267089525, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9267155990, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
    end
end)
tool.Parent = game.Players.LocalPlayer.Backpack

tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Oak Planks"
tool.Activated:connect(function()
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9359126658, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
    end
end)
tool.Parent = game.Players.LocalPlayer.Backpack

tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Cobblestone"
tool.Activated:connect(function()
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12616185407, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
    end
end)
tool.Parent = game.Players.LocalPlayer.Backpack

tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Stone"
tool.Activated:connect(function()
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(3162897225, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
    end
end)
tool.Parent = game.Players.LocalPlayer.Backpack

tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Diamond Ore"
tool.Activated:connect(function()
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(11425623081, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
    end
end)
tool.Parent = game.Players.LocalPlayer.Backpack

tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Diamond Block"
tool.Activated:connect(function()
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(4786858334, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(-1.65, 1.65, 0))
    end
end)
tool.Parent = game.Players.LocalPlayer.Backpack

tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Lava (Kills)"
tool.Activated:connect(function()
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
        local savepos = game.Players.LocalPlayer:GetMouse().Hit
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(-1.65, 1.65, 0))
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
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(-1.65, 1.65, 0))
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
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Top, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(0, 3.3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Bottom, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Back, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(0, 1.65, 1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Front, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(0, 1.65, -1.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Right, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(1.65, 1.65, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9886286740, Enum.NormalId.Left, 3.5, workspace.Lobby.Map.Fountain.Nikilis.HumanoidRootPart, CFrame.new(savepos.Position) * CFrame.new(-1.65, 1.65, 0))
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
end)

Sprayfun:CreateToggle("Lava Block Working", function(lava)
if lava then
_G.laggame = game:GetService("RunService").RenderStepped:Connect(function()
for i, p in pairs(workspace:FindFirstChild("KillpartsVisual"):GetDescendants()) do
if p.Name == "(Lava Visual Script) kill part" then
for i, v in pairs(game.Players:GetPlayers()) do
if v ~= game.Players.LocalPlayer and v ~= game.Players:FindFirstChild("corkscrew2L") and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") and (v.Character:FindFirstChild("HumanoidRootPart").Position-p.Position).Magnitude <= 3.6 then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[v.Name].HumanoidRootPart,
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
end
end)
else
_G.lava:Disconnect()
end
end)

Sprayfun:CreateTextbox("(Shift-Apply) Username", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Full Player Name Added",
	Icon = "rbxassetid://6467185020",
    Duration = 2
})
end)

Ssprayid = 60484593
Sprayfun:CreateTextbox("(Shift-Apply) Decal Id", function(sprayid)
    Ssprayid = sprayid
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Decal Loaded",
	Icon = "rbxassetid://6467185020",
    Duration = 2
})
end)

Sprayfun:CreateButton("(ID) Box [User]", function()
if game.Players.LocalPlayer.Character ~= nil then
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        local posofpl = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart.CFrame
        if game.Players[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].Character ~= nil then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(-2.86, 0.1, 0))
game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        end
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        local posofpl = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart.CFrame
        if game.Players[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].Character ~= nil then
game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(-2.86, 0.1, 0))
game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        end
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
        local posofpl = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart.CFrame
        if game.Players[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].Character ~= nil then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(-2.86, 0.1, 0))
end
    end
    end
end)

Sprayfun:CreateButton("(ID) Pool [User]", function()
if game.Players.LocalPlayer.Character ~= nil then
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        local posofpl = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart.CFrame
        if game.Players[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].Character ~= nil then
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 2048, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        end
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        local posofpl = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart.CFrame
        if game.Players[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].Character ~= nil then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 2048, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        end
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
        local posofpl = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart.CFrame
        if game.Players[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].Character ~= nil then
        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 2048, workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
        end
    end
    end
end)

Sprayfun:CreateButton("Old Germany Flag [User]", function()
if game.Players.LocalPlayer.Character ~= nil then
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        local humofplr = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart
        local posofplr = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart.CFrame
        if game.Players[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].Character ~= nil then
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(8, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(8, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(8, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(8, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(8, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-8, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-8, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-8, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-8, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-8, 14, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        end
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        local humofplr = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart
        local posofplr = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart.CFrame
        if game.Players[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].Character ~= nil then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(8, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(8, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(8, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(8, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(8, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-8, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-8, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-8, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-8, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-8, 14, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        end
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
        local humofplr = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart
        local posofplr = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart.CFrame
        if game.Players[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].Character ~= nil then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-4, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-2, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(0, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(2, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(4, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(8, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(8, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(8, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(8, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(8, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-8, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-8, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-8, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-8, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, humofplr, posofplr * CFrame.new(-8, 14, 0))
        end
    end
    end
end)

Sprayfun:CreateButton("(ID) Box All", function()
if game.Players.LocalPlayer.Character ~= nil then
for i, v in pairs(game.Players:GetPlayers()) do
if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") then
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        local posofpl = workspace[v.Name].HumanoidRootPart.CFrame
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-2.86, 0.1, 0))
game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        local posofpl = workspace[v.Name].HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-2.86, 0.1, 0))
game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
        local posofpl = workspace[v.Name].HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-2.86, 0.1, 0))
end
end
end
end
end)

Sprayfun:CreateTextbox("(Shift-Apply) Username2", function(plrbear)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)Username2TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrbear))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Full Player Name Added",
	Icon = "rbxassetid://6467185020",
    Duration = 2
})
end)

killitems = "Pizza"
Sprayfun:CreateDropdown("Choose Item", {"Pizza-killer", "FakeBomb-killer", "Teddy-killer"}, 1, function(item)
if item == "Pizza-killer" then
killitems = "Pizza"
elseif item == "FakeBomb-killer" then
killitems = "FakeBomb"
elseif item == "Teddy-killer" then
killitems = "Teddy"
end
end)

applyrangebear = 5
Sprayfun:CreateSlider("Item-killers Reach", 5, 20, 5, false, function(rangebear)
    applyrangebear = rangebear
end)

Sprayfun:CreateToggle("Item-killers [User]", function(hungryb)
if hungryb then
local owner = game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPaintFunSection["(Shift-Apply)Username2TextBoxHolder"].TextBox.Text
local protect = game.Players.LocalPlayer.Name
_G.superted2 = game:GetService("RunService").RenderStepped:Connect(function()
if game.Players:FindFirstChild(owner) and game.Players:FindFirstChild(owner).Character ~= nil and game.Players:FindFirstChild(owner).Character:FindFirstChild(killitems) then
for i, v in pairs(game.Players:GetPlayers()) do
if v ~= game.Players:FindFirstChild(owner) and v ~= game.Players:FindFirstChild(protect) and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") and (v.Character:FindFirstChild("HumanoidRootPart").Position-game.Players:FindFirstChild(owner).Character:FindFirstChild("HumanoidRootPart").Position).Magnitude <= applyrangebear then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[v.Name].HumanoidRootPart,
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
else
_G.superted2:Disconnect()
end
end)

Sprayfun:CreateToggle("Gun-killer", function(gunkiller)
if gunkiller then
local owner = game.Players.LocalPlayer
_G.supergun = game:GetService("RunService").RenderStepped:Connect(function()
if game.Players:FindFirstChild(owner) and game.Players:FindFirstChild(owner).Character ~= nil and game.Players:FindFirstChild(owner).Character:FindFirstChild("Gun") then
for i, v in pairs(game.Players:GetPlayers()) do
if v ~= game.Players:FindFirstChild(owner) and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") and (v.Character:FindFirstChild("HumanoidRootPart").Position-game.Players:FindFirstChild(owner).Character:FindFirstChild("HumanoidRootPart").Position).Magnitude <= applyrangebear then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[v.Name].HumanoidRootPart,
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
else
_G.supergun:Disconnect()
end
end)

Trapfunc:CreateTextbox("(Shift-Apply) Username", function(plrtrap)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.TrapPerkModsSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrtrap))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Full Player Name Added",
	Icon = "rbxassetid://6467185020",
    Duration = 2
})
end)

Trapfunc:CreateButton("Trap [User]", function()
if game.Players[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.TrapPerkModsSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].Character ~= nil then
local plrpos = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.TrapPerkModsSection["(Shift-Apply)UsernameTextBoxHolder"].TextBox.Text].HumanoidRootPart.CFrame
game:GetService("ReplicatedStorage").TrapSystem.PlaceTrap:InvokeServer(plrpos)
end
end)

Trapfunc:CreateButton("Trap all", function()
for i, v in pairs(game.Players:GetPlayers()) do
if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") then
local plrallpos = workspace[v.Name].HumanoidRootPart.CFrame
game:GetService("ReplicatedStorage").TrapSystem.PlaceTrap:InvokeServer(plrallpos)
end
end
end)

Trapfunc:CreateButton("Trap Tool", function()
if game.Players.LocalPlayer.Character ~= nil then
local mouse = game.Players.LocalPlayer:GetMouse()
tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Place Traps"
tool.Activated:connect(function()
local pos = mouse.Hit+Vector3.new(0,0,0)
game:GetService("ReplicatedStorage").TrapSystem.PlaceTrap:InvokeServer(pos)
end)
tool.Parent = game.Players.LocalPlayer.Backpack
end
end)

Gunfunc:CreateButton("Create Fake Gun", function()
if game.Players.LocalPlayer.Character ~= nil then
game:GetService("ReplicatedStorage").Remotes.Gameplay.FakeGun:FireServer(true)
end
end)

Gunfunc:CreateToggle("Create Fake Guns", function(autogun)
if autogun then
Aautogun = true
while Aautogun == true do
if game.Players.LocalPlayer.Character ~= nil then
game:GetService("ReplicatedStorage").Remotes.Gameplay.FakeGun:FireServer(true)
wait(0.075)
end
end
else
Aautogun = false
end
end)

Stealthfunc:CreateToggle("Invisible", function(invis)
if invis then
    if game.Players.LocalPlayer.Character ~= nil then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("Stealth"):FireServer(true)
    end
else
    if game.Players.LocalPlayer.Character ~= nil then  
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("Stealth"):FireServer(false)
    end
end
end)

Opti:CreateToggle("Anti Display", function(antidis)
if antidis then
_G.antidisplay = game:GetService("RunService").RenderStepped:Connect(function()
for i, v in pairs(game.Players:GetPlayers()) do
    if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("GunDisplay") then
        v.Character:FindFirstChild("GunDisplay"):Destroy()
    elseif v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("KnifeDisplay") then
        v.Character:FindFirstChild("KnifeDisplay"):Destroy()
    end
end
end)
else
_G.antidisplay:Disconnect()
end
end)

Opti:CreateToggle("Anti Spray", function(antisumlags)
if antisumlags then
_G.antisumlags = game:GetService("RunService").RenderStepped:Connect(function()
if workspace:FindFirstChild("Spray") then
for _, v in pairs(workspace:GetDescendants()) do
    if v.Name == "Spray" and v.Size == Vector3.new(4, 0.2, 4) then
        v:Destroy()
    end
end
end
end)
else
_G.antisumlags:Disconnect()
end
end)

Multi:CreateTextbox("(Shift-Apply) Username1", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username1TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Full Player Name Added",
	Icon = "rbxassetid://6467185020",
    Duration = 2
})
end)
Multi:CreateToggle("Crash/Lag [User]", function(lagdest)
if lagdest then
_G.lagplrm = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username1TextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil and p.Character:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 80373024,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username1TextBoxHolder"].TextBox.Text].HumanoidRootPart,
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
end)
else
_G.lagplrm:Disconnect()
end
end)

Multi:CreateTextbox("(Shift-Apply) Username2", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username2TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Full Player Name Added",
	Icon = "rbxassetid://6467185020",
    Duration = 2
})
end)
Multi:CreateToggle("Crash/Lag [User]", function(lagdest)
if lagdest then
_G.lagplrm2 = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username2TextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil and p.Character:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 80373024,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username2TextBoxHolder"].TextBox.Text].HumanoidRootPart,
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
end)
else
_G.lagplrm2:Disconnect()
end
end)

Multi:CreateTextbox("(Shift-Apply) Username3", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username3TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Full Player Name Added",
	Icon = "rbxassetid://6467185020",
    Duration = 2
})
end)
Multi:CreateToggle("Crash/Lag [User]", function(lagdest)
if lagdest then
_G.lagplrm3 = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username3TextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil and p.Character:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 80373024,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username3TextBoxHolder"].TextBox.Text].HumanoidRootPart,
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
end)
else
_G.lagplrm3:Disconnect()
end
end)

Multi:CreateTextbox("(Shift-Apply) Username4", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username4TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Full Player Name Added",
	Icon = "rbxassetid://6467185020",
    Duration = 2
})
end)
Multi:CreateToggle("Crash/Lag [User]", function(lagdest)
if lagdest then
_G.lagplrm4 = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username4TextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil and p.Character:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 80373024,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username4TextBoxHolder"].TextBox.Text].HumanoidRootPart,
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
end)
else
_G.lagplrm4:Disconnect()
end
end)

Multi:CreateTextbox("(Shift-Apply) Username5", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username5TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Full Player Name Added",
	Icon = "rbxassetid://6467185020",
    Duration = 2
})
end)
Multi:CreateToggle("Crash/Lag [User]", function(lagdest)
if lagdest then
_G.lagplrm5 = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username5TextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil and p.Character:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 80373024,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username5TextBoxHolder"].TextBox.Text].HumanoidRootPart,
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
end)
else
_G.lagplrm5:Disconnect()
end
end)

Multi:CreateTextbox("(Shift-Apply) Username6", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username6TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Full Player Name Added",
	Icon = "rbxassetid://6467185020",
    Duration = 2
})
end)
Multi:CreateToggle("Crash/Lag [User]", function(lagdest)
if lagdest then
_G.lagplrm6 = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username6TextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil and p.Character:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 80373024,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username6TextBoxHolder"].TextBox.Text].HumanoidRootPart,
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
end)
else
_G.lagplrm6:Disconnect()
end
end)

Multi:CreateTextbox("(Shift-Apply) Username7", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username7TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Full Player Name Added",
	Icon = "rbxassetid://6467185020",
    Duration = 2
})
end)
Multi:CreateToggle("Crash/Lag [User]", function(lagdest)
if lagdest then
_G.lagplrm7 = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username7TextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil and p.Character:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 80373024,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username7TextBoxHolder"].TextBox.Text].HumanoidRootPart,
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
end)
else
_G.lagplrm7:Disconnect()
end
end)

Multi:CreateTextbox("(Shift-Apply) Username8", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username8TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Full Player Name Added",
	Icon = "rbxassetid://6467185020",
    Duration = 2
})
end)
Multi:CreateToggle("Crash/Lag [User]", function(lagdest)
if lagdest then
_G.lagplrm8 = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username8TextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil or p.CharacterAdded:wait() and p.Character:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 80373024,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.MultiCrashSection["(Shift-Apply)Username8TextBoxHolder"].TextBox.Text].HumanoidRootPart,
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
end)
else
_G.lagplrm8:Disconnect()
end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
if input.KeyCode == Enum.KeyCode.Tab then
    if game:GetService("CoreGui").WizardLibrary.Container.Visible == true then
    game:GetService("CoreGui").WizardLibrary.Container.Visible = false
    elseif game:GetService("CoreGui").WizardLibrary.Container.Visible == false then
    game:GetService("CoreGui").WizardLibrary.Container.Visible = true
    end
end
end)

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Loaded. Press Tab to Close/Open GUI",
	Icon = "rbxassetid://6467185020",
    Duration = 2
})
