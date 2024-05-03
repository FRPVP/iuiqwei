function defeatplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373315144, Enum.NormalId.Top, 6, (defeatplayertarget.Character.HumanoidRootPart), defeatplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373315144, Enum.NormalId.Bottom, 6, (defeatplayertarget.Character.HumanoidRootPart), defeatplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373315144, Enum.NormalId.Bottom, 6, (defeatplayertarget.Character.HumanoidRootPart), defeatplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373315144, Enum.NormalId.Top, 6, (defeatplayertarget.Character.HumanoidRootPart), defeatplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373315144, Enum.NormalId.Front, 6, (defeatplayertarget.Character.HumanoidRootPart), defeatplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373315144, Enum.NormalId.Back, 6, (defeatplayertarget.Character.HumanoidRootPart), defeatplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373315144, Enum.NormalId.Front, 6, (defeatplayertarget.Character.HumanoidRootPart), defeatplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373315144, Enum.NormalId.Back, 6, (defeatplayertarget.Character.HumanoidRootPart), defeatplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373315144, Enum.NormalId.Right, 6, (defeatplayertarget.Character.HumanoidRootPart), defeatplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373315144, Enum.NormalId.Left, 6, (defeatplayertarget.Character.HumanoidRootPart), defeatplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373315144, Enum.NormalId.Right, 6, (defeatplayertarget.Character.HumanoidRootPart), defeatplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373315144, Enum.NormalId.Left, 6, (defeatplayertarget.Character.HumanoidRootPart), defeatplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Spongebob Sex 3", Default = false })

Toggle:OnChanged(function(defeatplayer)
    if defeatplayer == true then
        defeatplayerloop = true
        while defeatplayerloop do
            function defeatplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        defeatplayertarget = players:FindFirstChild(v.Name)
                        defeatplayerfunc()
                        task.wait()
                    end
                else
                    defeatplayertarget = players:FindFirstChild(infinityGauntlet)
                    defeatplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(defeatplayerloopfix)
        end
    end
    if defeatplayer == false then
        defeatplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
