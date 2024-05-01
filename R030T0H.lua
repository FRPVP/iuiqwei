function rickplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Top, 6, (rickplayertarget.Character.HumanoidRootPart), rickplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Bottom, 6, (rickplayertarget.Character.HumanoidRootPart), rickplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Bottom, 6, (rickplayertarget.Character.HumanoidRootPart), rickplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Top, 6, (rickplayertarget.Character.HumanoidRootPart), rickplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Front, 6, (rickplayertarget.Character.HumanoidRootPart), rickplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Back, 6, (rickplayertarget.Character.HumanoidRootPart), rickplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Front, 6, (rickplayertarget.Character.HumanoidRootPart), rickplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Back, 6, (rickplayertarget.Character.HumanoidRootPart), rickplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Right, 6, (rickplayertarget.Character.HumanoidRootPart), rickplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Left, 6, (rickplayertarget.Character.HumanoidRootPart), rickplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Right, 6, (rickplayertarget.Character.HumanoidRootPart), rickplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Left, 6, (rickplayertarget.Character.HumanoidRootPart), rickplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Rickroll", Default = false })

Toggle:OnChanged(function(rickplayer)
    if rickplayer == true then
        rickplayerloop = true
        while rickplayerloop do
            function rickplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        rickplayertarget = players:FindFirstChild(v.Name)
                        rickplayerfunc()
                        task.wait()
                    end
                else
                    rickplayertarget = players:FindFirstChild(infinityGauntlet)
                    rickplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(rickplayerloopfix)
        end
    end
    if rickplayer == false then
        rickplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
