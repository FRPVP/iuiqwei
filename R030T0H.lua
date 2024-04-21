Stipid = 13850207336
Sbaseid = 12976059241
local isHeOk = false -- Set the initial state to false

PremiumPS:CreateToggle("test", {Toggled=false , Description = false}, function(val)
    isHeOk = val -- Update the script state based on the toggle value

    while isHeOk do
if game.Players.LocalPlayer.Character ~= nil then
        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") then
                if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        local posofpl = workspace[v.Name].HumanoidRootPart.CFrame
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1,-1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1,-1.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1,-2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1,-2.5))                      
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.3,-0.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.3,-1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.3,-1.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.3,-2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.3,-2.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.15,-1.15,-0.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.15,-1.15,-1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.15,-1.15,-1.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.15,-1.15,-2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.15,-1.15,-2.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.15,-1.15,-0.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.15,-1.15,-1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.15,-1.15,-1.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.15,-1.15,-2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.15,-1.15,-2.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, Enum.NormalId.Front, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.15,-2.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.5,-1,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Front, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.5,-1.15,-0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.5,-1.3,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.65,-1.15,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.5,-1,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Front, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.5,-1.15,-0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.5,-1.3,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.65,-1.15,-0.7))
game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        local posofpl = workspace[v.Name].HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1,-1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1,-1.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1,-2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1,-2.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.3,-0.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.3,-1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.3,-1.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.3,-2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.3,-2.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.15,-1.15,-0.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.15,-1.15,-1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.15,-1.15,-1.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.15,-1.15,-2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.15,-1.15,-2.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.15,-1.15,-0.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.15,-1.15,-1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.15,-1.15,-1.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.15,-1.15,-2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.15,-1.15,-2.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, Enum.NormalId.Front, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.15,-2.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.5,-1,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Front, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.5,-1.15,-0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.5,-1.3,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.65,-1.15,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.5,-1,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Front, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.5,-1.15,-0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.5,-1.3,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.65,-1.15,-0.7))
game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
        local posofpl = workspace[v.Name].HumanoidRootPart.CFrame
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1,-1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1,-1.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1,-2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1,-2.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.3,-0.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.3,-1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.3,-1.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.3,-2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.3,-2.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.15,-1.15,-0.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.15,-1.15,-1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.15,-1.15,-1.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.15,-1.15,-2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.15,-1.15,-2.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.15,-1.15,-0.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.15,-1.15,-1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.15,-1.15,-1.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.15,-1.15,-2))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.15,-1.15,-2.5))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Stipid, Enum.NormalId.Front, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0,-1.15,-2.65))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.5,-1,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Front, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.5,-1.15,-0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.5,-1.3,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(0.65,-1.15,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.5,-1,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Front, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.5,-1.15,-0.85))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.5,-1.3,-0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Sbaseid, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posofpl * CFrame.new(-0.65,-1.15,-0.7))
game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
                end
            end
        end
    end
    wait(15.5)
end
end)
