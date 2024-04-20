Ssprayid = 60484593
local isScriptSpruce = true -- Set the initial state to true

while isScriptSpruce do
    if game.Players.LocalPlayer.Character ~= nil then
        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") then
                if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
                    local posofpl = v.Character.UpperTorso.Position
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                    game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 32, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 32, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 32, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 32, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 32, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 32, posofpl)
                    game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
                    local posofpl = v.Character.UpperTorso.Position
                    game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 32, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 32, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 32, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 32, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 32, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 32, posofpl)
                    game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
                    local posofpl = v.Character.UpperTorso.Position
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 32, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 32, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 32, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 32, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 32, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 32, posofpl)
                    game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                end
            end
        end
    end
    wait(15.5)
end
