function spongeplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17282019822, Enum.NormalId.Top, 6, (spongeplayertarget.Character.HumanoidRootPart), spongeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17282019822, Enum.NormalId.Bottom, 6, (spongeplayertarget.Character.HumanoidRootPart), spongeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17282019822, Enum.NormalId.Bottom, 6, (spongeplayertarget.Character.HumanoidRootPart), spongeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17282019822, Enum.NormalId.Top, 6, (spongeplayertarget.Character.HumanoidRootPart), spongeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17282019822, Enum.NormalId.Front, 6, (spongeplayertarget.Character.HumanoidRootPart), spongeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17282019822, Enum.NormalId.Back, 6, (spongeplayertarget.Character.HumanoidRootPart), spongeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17282019822, Enum.NormalId.Front, 6, (spongeplayertarget.Character.HumanoidRootPart), spongeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17282019822, Enum.NormalId.Back, 6, (spongeplayertarget.Character.HumanoidRootPart), spongeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17282019822, Enum.NormalId.Right, 6, (spongeplayertarget.Character.HumanoidRootPart), spongeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17282019822, Enum.NormalId.Left, 6, (spongeplayertarget.Character.HumanoidRootPart), spongeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17282019822, Enum.NormalId.Right, 6, (spongeplayertarget.Character.HumanoidRootPart), spongeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17282019822, Enum.NormalId.Left, 6, (spongeplayertarget.Character.HumanoidRootPart), spongeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Spongebob Sex 2", Default = false })

Toggle:OnChanged(function(spongeplayer)
    if spongeplayer == true then
        spongeplayerloop = true
        while spongeplayerloop do
            function spongeplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        spongeplayertarget = players:FindFirstChild(v.Name)
                        spongeplayerfunc()
                        task.wait()
                    end
                else
                    spongeplayertarget = players:FindFirstChild(fetargetname)
                    spongeplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(spongeplayerloopfix)
        end
    end
    if spongeplayer == false then
        spongeplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
