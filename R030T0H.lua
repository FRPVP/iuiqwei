local Stipid = 13850207336
local Sbaseid = 12976059241

local function sprayPaint(targetPlayer)
    if game.Players.LocalPlayer.Character ~= nil then
        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") then
                if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
                    local posofpl = workspace[v.Name].HumanoidRootPart.CFrame
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                    game.Players.LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                    game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1,-0.7))
                    -- Add more FireServer calls for different directions
                end
            end
        end
    end
end

-- Example usage:
sprayPaint("Final_Ruze")
