local Stipid = 13850207336
local Sbaseid = 12976059241

-- Function to get the target position of the spray paint
local function getTargetPosition(player)
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        return player.Character.HumanoidRootPart.Position
    end
    return nil
end

-- Get the target position for each player
local targetPositions = {}
for _, player in ipairs(game.Players:GetPlayers()) do
    targetPositions[player] = getTargetPosition(player)
end

-- Main loop
while true do
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            local posofpl = targetPositions[player]
            if posofpl then
                for _, normalId in ipairs(Enum.NormalId:GetEnumItems()) do
                    for _, offset in ipairs({0, -0.5, -1, -1.5, -2, -2.5}) do
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                        game.Players.LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                        game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, normalId, 0.5, player.Character.HumanoidRootPart, posofpl + Vector3.new(0, offset, 0))
                    end
                end
            end
        end
    end
    wait(15.5)
end
