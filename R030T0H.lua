breakrounds = false
Sprayops:CreateButton("Break Game", function()
if breakrounds == false then
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Waiting until new round starts...",
    Duration = 3
})
end
breakrounds = true
end)

crashstatus = false
Crashmurder = nil
game:GetService("ReplicatedStorage").Remotes.Gameplay.Fade.OnClientEvent:Connect(function()
if breakrounds == true then
game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Trying to break the game...",
    Duration = 2
})
local getroles = game:GetService("ReplicatedStorage"):FindFirstChild("GetPlayerData", true):InvokeServer()
for i, v in pairs(getroles) do
	if v.Role == "Murderer" then
		 Crashmurder = i
	end
end
for i, p in pairs(game.Players:GetPlayers()) do
	if p.Name == Crashmurder and p.Character ~= nil and p.Character:FindFirstChild("HumanoidRootPart") then
	crashstatus = true
local args = {
    [1] = 0,
    [2] = Enum.NormalId.Back,
    [3] = 15,
    [4] = game.Players[p.Name].Character.HumanoidRootPart,
    [5] = CFrame.new(0, math.huge, 0)
}
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
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
if crashstatus == true then
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "If you see black screen it means it was successful. Rejoin to see result.",
    Duration = 5
})
else
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MM2 Mods",
	Text = "Error.",
    Duration = 5
})
end
end
end)
