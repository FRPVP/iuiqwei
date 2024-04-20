Ssprayid = 60484593
local isScriptSpruce = false -- Set the initial state to true

while isScriptSpruce do
    if game.Players.LocalPlayer.Character ~= nil then
        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") then
                if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
                    local posofpl = workspace[v.Name].HumanoidRootPart.CFrame
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                    game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3.15, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -2.8, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 3.1))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 2.86))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -2.86))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -3.1))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(2.86, 0.1, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(3.1, 0.1, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-3.1, 0.1, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-2.86, 0.1, 0))
                    game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
                    local posofpl = workspace[v.Name].HumanoidRootPart.CFrame
                    game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3.15, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -2.8, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 3.1))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 2.86))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -2.86))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -3.1))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(2.86, 0.1, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(3.1, 0.1, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-3.1, 0.1, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-2.86, 0.1, 0))
                    game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
                    local posofpl = workspace[v.Name].HumanoidRootPart.CFrame
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 3.15, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -2.8, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, -3, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 3.1))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, 2.86))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -2.86))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0, 0.1, -3.1))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(2.86, 0.1, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(3.1, 0.1, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-3.1, 0.1, 0))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 32, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-2.86, 0.1, 0))
                    game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                end
            end
        end
    end
    wait(15.5)
end
