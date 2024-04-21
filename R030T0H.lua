while true do
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local posOfPenis = player.Character.HumanoidRootPart.CFrame

            -- Spray painting the penis on all sides
            for _, normalId in ipairs(Enum.NormalId:GetEnumItems()) do
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                game.Players.LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, normalId, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1,-2.5))
            end
        end
    end
    wait(16)
end
