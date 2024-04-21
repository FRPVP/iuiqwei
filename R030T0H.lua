local Stipid = 13850207336
local Sbaseid = 12976059241

while true do
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            local posofpl = player.Character.HumanoidRootPart.CFrame

            for _, normalId in ipairs(Enum.NormalId:GetEnumItems()) do
                for _, offset in ipairs({0, -0.5, -1, -1.5, -2, -2.5}) do
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                    game.Players.LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                    game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, normalId, 0.5, player.Character.HumanoidRootPart, posofpl * CFrame.new(0, offset, 0))
                end
            end
        end
    end
    wait(15.5)
end
