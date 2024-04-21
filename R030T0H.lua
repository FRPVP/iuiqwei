Stipid = 13850207336
Sbaseid = 12976059241

local function sprayPaintPlayer(player)
    if player == game.Players.LocalPlayer then
        return  -- Skip spraying the local player
    end

    local sprayPositions = {
        {Enum.NormalId.Top, CFrame.new(0,-1,-0.7)},
        {Enum.NormalId.Top, CFrame.new(0,-1,-1)},
        {Enum.NormalId.Top, CFrame.new(0,-1,-1.5)},
        {Enum.NormalId.Top, CFrame.new(0,-1,-2)},
        {Enum.NormalId.Bottom, CFrame.new(0,-1.3,-0.5)},
        {Enum.NormalId.Bottom, CFrame.new(0,-1.3,-1)},
        {Enum.NormalId.Bottom, CFrame.new(0,-1.3,-1.5)},
        {Enum.NormalId.Bottom, CFrame.new(0,-1.3,-2)},
        {Enum.NormalId.Left, CFrame.new(-0.15,-1.15,-0.5)},
        {Enum.NormalId.Left, CFrame.new(-0.15,-1.15,-1)},
        {Enum.NormalId.Left, CFrame.new(-0.15,-1.15,-1.5)},
        {Enum.NormalId.Left, CFrame.new(-0.15,-1.15,-2)},
        {Enum.NormalId.Right, CFrame.new(0.15,-1.15,-0.5)},
        {Enum.NormalId.Right, CFrame.new(0.15,-1.15,-1)},
        {Enum.NormalId.Right, CFrame.new(0.15,-1.15,-1.5)},
        {Enum.NormalId.Right, CFrame.new(0.15,-1.15,-2)},
        {Enum.NormalId.Front, CFrame.new(0,-1.15,-2.65)}
    }

    for _, pos in ipairs(sprayPositions) do
        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, pos[1], 0.5, player.Character.HumanoidRootPart, player.Character.HumanoidRootPart.CFrame * pos[2])
        game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, pos[1], 0.5, player.Character.HumanoidRootPart, player.Character.HumanoidRootPart.CFrame * pos[2])
    end
end

for _, player in ipairs(game.Players:GetPlayers()) do
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        sprayPaintPlayer(player)
    end
end
