function poolplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Top, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Bottom, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Bottom, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Top, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Front, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Back, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Front, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Back, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Right, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Left, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Right, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Left, 32, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Blind", Default = false })

Toggle:OnChanged(function(poolplayer)
    if poolplayer == true then
        poolplayerloop = true
        while poolplayerloop do
            function poolplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        poolplayertarget = players:FindFirstChild(v.Name)
                        poolplayerfunc()
                        task.wait()
                    end
                else
                    poolplayertarget = players:FindFirstChild(fetargetname)
                    poolplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(poolplayerloopfix)
        end
    end
    if poolplayer == false then
        poolplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
