local Stipid = 13850207336
local Sbaseid = 12976059241

if game.Players.LocalPlayer.Character ~= nil then
    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") then
            if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
                local posofpl = workspace[v.Name].HumanoidRootPart.CFrame
                
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                game.Players.LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                
                -- Firing spray paint from various directions
                for _, normalId in ipairs(Enum.NormalId:GetEnumItems()) do
                    game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(
                        Sbaseid,
                        normalId,
                        0.5,
                        workspace[v.Name].HumanoidRootPart,
                        posofpl * CFrame.new(Vector3.new())
                    )
                    wait(0.1)
                    game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(
                        Stipid,
                        normalId,
                        0.5,
                        workspace[v.Name].HumanoidRootPart,
                        posofpl * CFrame.new(Vector3.new())
                    )
                    wait(0.1)
                end
                
                game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
            end
        end
    end
end
