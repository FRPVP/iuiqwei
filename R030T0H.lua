local Stipid = 13850207336
local Sbaseid = 12976059241

-- Function to get the target position of the spray paint
local function getTargetPosition(player)
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        return player.Character.HumanoidRootPart.Position
    end
    return nil
end

-- Main loop
while true do
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            local posofpl = getTargetPosition(player)
            if posofpl then
                -- Apply spray paint to the player's position
                for _, normalId in ipairs(Enum.NormalId:GetEnumItems()) do
                    for _, offset in ipairs({0, -0.5, -1, -1.5, -2, -2.5}) do
                        local sprayPosition = posofpl + Vector3.new(0, offset, 0)
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                        game.Players.LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                        game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, normalId, 0.5, player.Character.HumanoidRootPart, sprayPosition)
                    end
                end
                -- Lock the player's position using BodyPosition
                local bodyPosition = Instance.new("BodyPosition")
                bodyPosition.Position = player.Character.HumanoidRootPart.Position
                bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bodyPosition.Parent = player.Character.HumanoidRootPart
                player.Character.HumanoidRootPart.Anchored = true
            end
        end
    end
    wait(15.5)
end
