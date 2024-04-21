while true do
    if game.Players.LocalPlayer.Character ~= nil then
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character ~= nil and player.Character:FindFirstChild("HumanoidRootPart") then
                local posOfPenis = player.Character.HumanoidRootPart.CFrame
                local sprayPaint = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint")

                if sprayPaint then
                    local remote = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote
                    -- Spray paint positions for the penis
                    local sprayPositions = {
                        {Enum.NormalId.Top, CFrame.new(0,-1,-0.7)},
                        {Enum.NormalId.Top, CFrame.new(0,-1,-1)},
                        {Enum.NormalId.Top, CFrame.new(0,-1,-1.5)},
                        {Enum.NormalId.Top, CFrame.new(0,-1,-2)},
                        {Enum.NormalId.Top, CFrame.new(0,-1,-2.5)},
                        {Enum.NormalId.Bottom, CFrame.new(0,-1.3,-0.5)},
                        {Enum.NormalId.Bottom, CFrame.new(0,-1.3,-1)},
                        {Enum.NormalId.Bottom, CFrame.new(0,-1.3,-1.5)},
                        {Enum.NormalId.Bottom, CFrame.new(0,-1.3,-2)},
                        {Enum.NormalId.Bottom, CFrame.new(0,-1.3,-2.5)},
                        {Enum.NormalId.Left, CFrame.new(-0.15,-1.15,-0.5)},
                        {Enum.NormalId.Left, CFrame.new(-0.15,-1.15,-1)},
                        {Enum.NormalId.Left, CFrame.new(-0.15,-1.15,-1.5)},
                        {Enum.NormalId.Left, CFrame.new(-0.15,-1.15,-2)},
                        {Enum.NormalId.Left, CFrame.new(-0.15,-1.15,-2.5)},
                        {Enum.NormalId.Right, CFrame.new(0.15,-1.15,-0.5)},
                        {Enum.NormalId.Right, CFrame.new(0.15,-1.15,-1)},
                        {Enum.NormalId.Right, CFrame.new(0.15,-1.15,-1.5)},
                        {Enum.NormalId.Right, CFrame.new(0.15,-1.15,-2)},
                        {Enum.NormalId.Right, CFrame.new(0.15,-1.15,-2.5)},
                        {Enum.NormalId.Front, CFrame.new(0,-1.15,-2.65)},
                        {Enum.NormalId.Top, CFrame.new(0.5,-1,-0.7)},
                        {Enum.NormalId.Front, CFrame.new(0.5,-1.15,-0.85)},
                        {Enum.NormalId.Bottom, CFrame.new(0.5,-1.3,-0.7)},
                        {Enum.NormalId.Right, CFrame.new(0.65,-1.15,-0.7)},
                        {Enum.NormalId.Top, CFrame.new(-0.5,-1,-0.7)},
                        {Enum.NormalId.Front, CFrame.new(-0.5,-1.15,-0.85)},
                        {Enum.NormalId.Bottom, CFrame.new(-0.5,-1.3,-0.7)},
                        {Enum.NormalId.Left, CFrame.new(-0.65,-1.15,-0.7)}
                    }

                    for _, posData in ipairs(sprayPositions) do
                        remote:FireServer(12976059241, posData[1], 0.5, player.Character.HumanoidRootPart, posOfPenis * posData[2])
                    end

                    sprayPaint.Parent = game.Players.LocalPlayer.Character
                    wait(0.1) -- Add a small delay before moving the spray paint back to backpack
                    sprayPaint.Parent = game.Players.LocalPlayer.Backpack
                end
            end
        end
    end
    wait(16)
end
