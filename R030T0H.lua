function isuadyplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373265789, Enum.NormalId.Top, 6, (isuadyplayertarget.Character.HumanoidRootPart), isuadyplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373265789, Enum.NormalId.Bottom, 6, (isuadyplayertarget.Character.HumanoidRootPart), isuadyplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373265789, Enum.NormalId.Bottom, 6, (isuadyplayertarget.Character.HumanoidRootPart), isuadyplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373265789, Enum.NormalId.Top, 6, (isuadyplayertarget.Character.HumanoidRootPart), isuadyplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373265789, Enum.NormalId.Front, 6, (isuadyplayertarget.Character.HumanoidRootPart), isuadyplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373265789, Enum.NormalId.Back, 6, (isuadyplayertarget.Character.HumanoidRootPart), isuadyplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373265789, Enum.NormalId.Front, 6, (isuadyplayertarget.Character.HumanoidRootPart), isuadyplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373265789, Enum.NormalId.Back, 6, (isuadyplayertarget.Character.HumanoidRootPart), isuadyplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373265789, Enum.NormalId.Right, 6, (isuadyplayertarget.Character.HumanoidRootPart), isuadyplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373265789, Enum.NormalId.Left, 6, (isuadyplayertarget.Character.HumanoidRootPart), isuadyplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373265789, Enum.NormalId.Right, 6, (isuadyplayertarget.Character.HumanoidRootPart), isuadyplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17373265789, Enum.NormalId.Left, 6, (isuadyplayertarget.Character.HumanoidRootPart), isuadyplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Spongebob Sex 4", Default = false })

Toggle:OnChanged(function(isuadyplayer)
    if isuadyplayer == true then
        isuadyplayerloop = true
        while isuadyplayerloop do
            function isuadyplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        isuadyplayertarget = players:FindFirstChild(v.Name)
                        isuadyplayerfunc()
                        task.wait()
                    end
                else
                    isuadyplayertarget = players:FindFirstChild(infinityGauntlet)
                    isuadyplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(isuadyplayerloopfix)
        end
    end
    if isuadyplayer == false then
        isuadyplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
