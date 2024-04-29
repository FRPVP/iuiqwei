if not game:IsLoaded() then game.Loaded:Wait() end
local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
roles = game:GetService("ReplicatedStorage"):FindFirstChild("GetPlayerData", true):InvokeServer()
local MM2 = Library:NewWindow("MM2 Mods")

local ESP = MM2:NewSection("Simple ESP")
local Sprayops = MM2:NewSection("Spray OP Stuff")
local Sprayfun = MM2:NewSection("Spray Fun Stuff")
local Multi = MM2:NewSection("Spray Player Crasher")
local Gunfunc = MM2:NewSection("Gun Mods")
local Trapfunc = MM2:NewSection("Trap Perk Mods")
local Stealthfunc = MM2:NewSection("Stealth Perk Mods")
local Opti = MM2:NewSection("Optimization")

if not workspace:FindFirstChild("KillpartsVisual") then
local folder = Instance.new("Folder", workspace)
folder.Name = "KillpartsVisual"
end

function UserFromBox(String)
	for i,v in pairs(game:GetService("Players"):GetPlayers()) do
		if (string.sub(string.lower(v.Name),1,string.len(String))) == string.lower(String) then
			return v
        end
	end
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
			elseif v.Name == Hero and IsAlive(v) and v.Backpack:FindFirstChild("Gun") then
				Highlight.FillColor = Color3.fromRGB(255, 255, 0)
                Highlight.FillTransparency = applyesptrans
			elseif v.Name == Hero and IsAlive(v) and v.Character:FindFirstChild("Gun") then
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
ESP:CreateToggle("ESP Players", function(SeeRoles)
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

ESP:CreateToggle("ESP Gun Drop", function(SeeGun)
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
 
ESP:CreateSlider("ESP Transparency", 0, 1, 0.5, true, function(esptrans)
    applyesptrans = esptrans
end)
------
spraytarget = nil
Sprayops:CreateTextbox("[Shift] Username", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayOPStuffSection["[Shift]UsernameTextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
spraytarget = game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayOPStuffSection["[Shift]UsernameTextBoxHolder"].TextBox.Text
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Player Added: "..spraytarget,
    Duration = 2
})
end)

applyfling = 7
Sprayops:CreateSlider("Fling Strength", 7, 70, 7, false, function(flingstr)
    applyfling = flingstr
end)

Sprayops:CreateButton("Fling [User]", function()
if game.Players.LocalPlayer.Character ~= nil then
if spraytarget ~= nil and game.Players:FindFirstChild(spraytarget) then
if game.Players[spraytarget].Character ~= nil and game.Players[spraytarget].Character:FindFirstChild("LeftHand") then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = applyfling,
    [4] = game.Players[spraytarget].Character.LeftHand,
    [5] = CFrame.new(0, 0, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
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

Sprayops:CreateButton("Destroy [User]", function()
if game.Players.LocalPlayer.Character ~= nil then
if spraytarget ~= nil and game.Players:FindFirstChild(spraytarget) then
if game.Players[spraytarget].Character ~= nil and game.Players[spraytarget].Character:FindFirstChild("HumanoidRootPart") then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = game.Players[spraytarget].Character.HumanoidRootPart,
    [5] = CFrame.new(0, math.huge, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
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

local nocliptip = true
Sprayops:CreateButton("Noclip/God [User]", function()
if game.Players.LocalPlayer.Character ~= nil then
if spraytarget ~= nil and game.Players:FindFirstChild(spraytarget) then
if game.Players[spraytarget].Character ~= nil then
if nocliptip == true then
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Player is invincible and has noclip for 15s. If player is murder he can't stab.",
    Duration = 6
})
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Pressing button while player is standing makes better effect.",
    Duration = 6
})
nocliptip = false
end
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Bottom,
    [3] = 6.331,
    [4] = game.Players[spraytarget].Character.HumanoidRootPart,
    [5] = game.Players[spraytarget].Character.HumanoidRootPart.CFrame * CFrame.new(0, 10010, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
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
if spraytarget == game.Players.LocalPlayer.Name then
if game.Players.LocalPlayer.Character:FindFirstChild("LocalGod_Highlight") then
    game.Players.LocalPlayer.Character:FindFirstChild("LocalGod_Highlight"):Destroy()
end
		local localgod = Instance.new("Highlight", game.Players.LocalPlayer.Character)
        localgod.Name = "LocalGod_Highlight"
        localgod.FillColor = Color3.fromRGB(255, 215, 0)
        localgod.OutlineTransparency = 1
        localgod.FillTransparency = 0.65
wait(16.1)
        if localgod then
        localgod:Destroy()
        end
end
end)

Sprayops:CreateButton("Freeze [User]", function()

end)

breakrounds = false
Sprayops:CreateButton("Break Game", function()
breakrounds = true
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Waiting until new round starts...",
    Duration = 3
})
end)

Sprayops:CreateButton("Fling All", function()
if game.Players.LocalPlayer.Character ~= nil then
for i, v in pairs(game.Players:GetPlayers()) do
if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("LeftHand") then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = applyfling,
    [4] = workspace[v.Name].LeftHand,
    [5] = CFrame.new(0, 0, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
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
 
Sprayops:CreateButton("Destroy All", function()
if game.Players.LocalPlayer.Character ~= nil then
for i, v in pairs(game.Players:GetPlayers()) do
if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[v.Name].HumanoidRootPart,
    [5] = CFrame.new(0, math.huge, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
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
end)

Sprayfun:CreateToggle("^ Enable Lava", function(lava)
if lava then
_G.lavag = game:GetService("RunService").RenderStepped:Connect(function()
for i, p in pairs(workspace:FindFirstChild("KillpartsVisual"):GetDescendants()) do
if p.Name == "(Lava Visual Script) kill part" then
for i, v in pairs(game.Players:GetPlayers()) do
if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") and (v.Character:FindFirstChild("HumanoidRootPart").Position-p.Position).Magnitude <= 3.6 then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[v.Name].HumanoidRootPart,
    [5] = CFrame.new(0, math.huge, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
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
_G.lavag:Disconnect()
end
end)

spraytarget2 = nil
Sprayfun:CreateTextbox("[Shift] Username", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayFunStuffSection["[Shift]UsernameTextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
spraytarget2 = game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayFunStuffSection["[Shift]UsernameTextBoxHolder"].TextBox.Text
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Player Added: "..spraytarget2,
    Duration = 2
})
end)

Ssprayid = 60484593
Sprayfun:CreateTextbox("[Shift] Decal ID", function(sprayid)
    Ssprayid = sprayid
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Decal Added.",
    Duration = 2
})
end)

Sprayfun:CreateButton("Box [ID][User]", function()
if game.Players.LocalPlayer.Character ~= nil then
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        local posofpl = game.Players[spraytarget2].Character.HumanoidRootPart.CFrame
        if game.Players[spraytarget2].Character ~= nil then
game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(-2.86, 0.1, 0))
game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        end
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        local posofpl = game.Players[spraytarget2].Character.HumanoidRootPart.CFrame
        if game.Players[spraytarget2].Character ~= nil then
game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(-2.86, 0.1, 0))
game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        end
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
        local posofpl = game.Players[spraytarget2].Character.HumanoidRootPart.CFrame
        if game.Players[spraytarget2].Character ~= nil then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 6, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(-2.86, 0.1, 0))
end
    end
    end
end)

Sprayfun:CreateButton("Floor [ID][User]", function()
if game.Players.LocalPlayer.Character ~= nil then
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        local posofpl = game.Players[spraytarget2].Character.HumanoidRootPart.CFrame
        if game.Players[spraytarget2].Character ~= nil then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 2048, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        end
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        local posofpl = game.Players[spraytarget2].Character.HumanoidRootPart.CFrame
        if game.Players[spraytarget2].Character ~= nil then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 2048, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        end
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
        local posofpl = game.Players[spraytarget2].Character.HumanoidRootPart.CFrame
        if game.Players[spraytarget2].Character ~= nil then
        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 2048, game.Players[spraytarget2].Character.HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
        end
    end
    end
end)

Sprayfun:CreateButton("Male Organ [User]", function()
if game.Players.LocalPlayer.Character ~= nil then
if game.Players[spraytarget2].Character ~= nil then
targhumpart = game.Players:FindFirstChild(spraytarget2).Character.HumanoidRootPart
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -2.9, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(2.5, -2.9, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-2.5, -2.9, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(2.5, -0.6, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -0.6, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-2.5, -0.6, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Left, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-3.65, -1.75, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Right, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(3.65, -1.75, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Front, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(2.5, -1.75, -3.15))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Front, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-2.5, -1.75, -3.15))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Back, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(2.5, -1.75, -0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Back, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -1.75, -0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Back, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-2.5, -1.75, -0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Left, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-1.15, -1.75, -4.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Right, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(1.15, -1.75, -4.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Left, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-1.15, -1.75, -6.75))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Right, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(1.15, -1.75, -6.75))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -0.6, -4.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -0.6, -6.75))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -2.9, -4.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -2.9, -6.75))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Left, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-1.15, -1.75, -9))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Right, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(1.15, -1.75, -9))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -0.6, -9))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -2.9, -9))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -1.75, -10.15))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -2.9, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(2.5, -2.9, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-2.5, -2.9, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(2.5, -0.6, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -0.6, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-2.5, -0.6, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Left, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-3.65, -1.75, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Right, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(3.65, -1.75, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Front, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(2.5, -1.75, -3.15))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Front, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-2.5, -1.75, -3.15))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Back, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(2.5, -1.75, -0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Back, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -1.75, -0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Back, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-2.5, -1.75, -0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Left, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-1.15, -1.75, -4.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Right, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(1.15, -1.75, -4.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Left, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-1.15, -1.75, -6.75))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Right, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(1.15, -1.75, -6.75))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -0.6, -4.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -0.6, -6.75))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -2.9, -4.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -2.9, -6.75))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Left, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-1.15, -1.75, -9))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Right, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(1.15, -1.75, -9))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -0.6, -9))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -2.9, -9))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -1.75, -10.15))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -2.9, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(2.5, -2.9, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-2.5, -2.9, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(2.5, -0.6, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -0.6, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-2.5, -0.6, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Left, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-3.65, -1.75, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Right, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(3.65, -1.75, -2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Front, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(2.5, -1.75, -3.15))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Front, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-2.5, -1.75, -3.15))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Back, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(2.5, -1.75, -0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Back, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -1.75, -0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Back, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-2.5, -1.75, -0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Left, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-1.15, -1.75, -4.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Right, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(1.15, -1.75, -4.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Left, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-1.15, -1.75, -6.75))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Right, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(1.15, -1.75, -6.75))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -0.6, -4.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -0.6, -6.75))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -2.9, -4.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(9418596904, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -2.9, -6.75))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Left, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(-1.15, -1.75, -9))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Right, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(1.15, -1.75, -9))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Top, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -0.6, -9))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Bottom, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -2.9, -9))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2.5, targhumpart, targhumpart.CFrame * CFrame.new(0, -1.75, -10.15))
    end
end
end
end)
 
Sprayfun:CreateButton("Old Germany Flag [User]", function()
if game.Players.LocalPlayer.Character ~= nil then
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        local humofplr = workspace[spraytarget2].HumanoidRootPart
        local posofplr = workspace[spraytarget2].HumanoidRootPart.CFrame
        if game.Players[spraytarget2].Character ~= nil then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
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
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(8, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(8, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(8, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(8, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(8, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-8, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-8, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-8, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-8, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-8, 14, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        end
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        local humofplr = workspace[spraytarget2].HumanoidRootPart
        local posofplr = workspace[spraytarget2].HumanoidRootPart.CFrame
        if game.Players[spraytarget2].Character ~= nil then
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
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(8, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(8, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(8, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(8, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(8, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-8, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-8, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-8, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-8, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-8, 14, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        end
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
        local humofplr = workspace[spraytarget2].HumanoidRootPart
        local posofplr = workspace[spraytarget2].HumanoidRootPart.CFrame
        if game.Players[spraytarget2].Character ~= nil then
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
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 4, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(6, 16, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 18, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-4, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-2, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(0, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(2, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(4, 2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(8, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(8, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(8, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(8, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(8, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-8, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-8, 8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-8, 10, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-8, 12, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Back, 2, humofplr, posofplr * CFrame.new(-8, 14, 0))
        end
    end
    end
end)

Sprayfun:CreateButton("Fake Knife [User]", function()
if game.Players.LocalPlayer.Character ~= nil then
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
		game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
		game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(15093138669, Enum.NormalId.Right, 3, game.Players[spraytarget2].Character.RightHand, game.Players[spraytarget2].Character.RightHand.CFrame * CFrame.new(0, 0, -0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(15096522641, Enum.NormalId.Left, 3, game.Players[spraytarget2].Character.RightHand, game.Players[spraytarget2].Character.RightHand.CFrame * CFrame.new(0, 0, -0.7))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(15093138669, Enum.NormalId.Right, 3, game.Players[spraytarget2].Character.RightHand, game.Players[spraytarget2].Character.RightHand.CFrame * CFrame.new(0, 0, -0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(15096522641, Enum.NormalId.Left, 3, game.Players[spraytarget2].Character.RightHand, game.Players[spraytarget2].Character.RightHand.CFrame * CFrame.new(0, 0, -0.7))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(15093138669, Enum.NormalId.Right, 3, game.Players[spraytarget2].Character.RightHand, game.Players[spraytarget2].Character.RightHand.CFrame * CFrame.new(0, 0, -0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(15096522641, Enum.NormalId.Left, 3, game.Players[spraytarget2].Character.RightHand, game.Players[spraytarget2].Character.RightHand.CFrame * CFrame.new(0, 0, -0.7))
    end
end
end)

Multi:CreateTextbox("[Shift] Username1", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username1TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Player Added.",
    Duration = 2
})
end)
Multi:CreateToggle("Lag Destroy [User]", function(lagdest)
if lagdest then
_G.lagplrm1 = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username1TextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil or p.CharacterAdded:wait() and p.Character:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username1TextBoxHolder"].TextBox.Text].HumanoidRootPart,
    [5] = CFrame.new(0, math.huge, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
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
_G.lagplrm1:Disconnect()
end
end)
 
Multi:CreateTextbox("[Shift] Username2", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username2TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Player Added.",
    Duration = 2
})
end)
Multi:CreateToggle("Lag Destroy [User]", function(lagdest)
if lagdest then
_G.lagplrm2 = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username2TextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil or p.CharacterAdded:wait() and p.Character:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username2TextBoxHolder"].TextBox.Text].HumanoidRootPart,
    [5] = CFrame.new(0, math.huge, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
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
 
Multi:CreateTextbox("[Shift] Username3", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username3TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Player Added.",
    Duration = 2
})
end)
Multi:CreateToggle("Lag Destroy [User]", function(lagdest)
if lagdest then
_G.lagplrm3 = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username3TextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil or p.CharacterAdded:wait() and p.Character:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username3TextBoxHolder"].TextBox.Text].HumanoidRootPart,
    [5] = CFrame.new(0, math.huge, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
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
 
Multi:CreateTextbox("[Shift] Username4", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username4TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Player Added.",
    Duration = 2
})
end)
Multi:CreateToggle("Lag Destroy [User]", function(lagdest)
if lagdest then
_G.lagplrm4 = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username4TextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil or p.CharacterAdded:wait() and p.Character:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username4TextBoxHolder"].TextBox.Text].HumanoidRootPart,
    [5] = CFrame.new(0, math.huge, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
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
 
Multi:CreateTextbox("[Shift] Username5", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username5TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Player Added.",
    Duration = 2
})
end)
Multi:CreateToggle("Lag Destroy [User]", function(lagdest)
if lagdest then
_G.lagplrm5 = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username5TextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil or p.CharacterAdded:wait() and p.Character:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username5TextBoxHolder"].TextBox.Text].HumanoidRootPart,
    [5] = CFrame.new(0, math.huge, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
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
 
Multi:CreateTextbox("[Shift] Username6", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username6TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Player Added.",
    Duration = 2
})
end)
Multi:CreateToggle("Lag Destroy [User]", function(lagdest)
if lagdest then
_G.lagplrm6 = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username6TextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil or p.CharacterAdded:wait() and p.Character:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username6TextBoxHolder"].TextBox.Text].HumanoidRootPart,
    [5] = CFrame.new(0, math.huge, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
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
 
Multi:CreateTextbox("[Shift] Username7", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username7TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Player Added.",
    Duration = 2
})
end)
Multi:CreateToggle("Lag Destroy [User]", function(lagdest)
if lagdest then
_G.lagplrm7 = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username7TextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil or p.CharacterAdded:wait() and p.Character:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username7TextBoxHolder"].TextBox.Text].HumanoidRootPart,
    [5] = CFrame.new(0, math.huge, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
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
 
Multi:CreateTextbox("[Shift] Username8", function(plrspray)
game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username8TextBoxHolder"].TextBox.Text = tostring(UserFromBox(plrspray))
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Player Added.",
    Duration = 2
})
end)
Multi:CreateToggle("Lag Destroy [User]", function(lagdest)
if lagdest then
_G.lagplrm8 = game:GetService("RunService").RenderStepped:Connect(function()
local p = game.Players:FindFirstChild(game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username8TextBoxHolder"].TextBox.Text)
if p and p.Character ~= nil or p.CharacterAdded:wait() and p.Character:FindFirstChild("HumanoidRootPart") then
    if game.Players.LocalPlayer.Character ~= nil then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = workspace[game:GetService("CoreGui").WizardLibrary.Container.MM2ModsWindow.Body.SprayPlayerCrasherSection["[Shift]Username8TextBoxHolder"].TextBox.Text].HumanoidRootPart,
    [5] = CFrame.new(0, math.huge, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
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

Crashmurder = nil
game:GetService("ReplicatedStorage").Remotes.Gameplay.Fade.OnClientEvent:Connect(function()
if breakrounds == true then
task.wait(2)
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Trying to break the game...",
    Duration = 2
})
local getroles = game:GetService("ReplicatedStorage"):FindFirstChild("GetPlayerData", true):InvokeServer()
for i, v in pairs(roles) do
	if v.Role == "Murderer" then
		 Crashmurder = i
	end
end
for i, p in pairs(game.Players:GetPlayers()) do
	if p.Name = Crashmurder then
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = game.Players[p.Name].Character.HumanoidRootPart,
    [5] = CFrame.new(0, math.huge, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
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
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Done. If you see black screen it means it was successful. Rejoin to see result.",
    Duration = 5
})
end
end
end)
