while true do
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            local posofpenis = player.Character.HumanoidRootPart.CFrame
            for _, partEnum in ipairs(Enum.NormalId:GetEnumItems()) do
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, partEnum, 0.5, player.Character.HumanoidRootPart, posofpenis * CFrame.new(0, -1, -2.5))
            end
        end
    end
    wait(16)
end
