local Stipid = 13850207336
local Sbaseid = 12976059241

local function sprayPaint(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local posofpl = player.Character.HumanoidRootPart.CFrame
        
        -- Spray painting patterns
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        
        -- Adjust the position and invoke the server to spray paint
        game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, Enum.NormalId.Top, 0.5, player.Character.HumanoidRootPart, posofpl * CFrame.new(0,-1,-0.7))
        -- Add more spray paint patterns as needed
        
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game.Players.LocalPlayer.Backpack
    end
end

-- Example usage:
for _, player in pairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        sprayPaint(player)
    end
end
