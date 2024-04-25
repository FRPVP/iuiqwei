function boxplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Top, 6, (boxplayertarget.Character.HumanoidRootPart), boxplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Bottom, 6, (boxplayertarget.Character.HumanoidRootPart), boxplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Bottom, 6, (boxplayertarget.Character.HumanoidRootPart), boxplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Top, 6, (boxplayertarget.Character.HumanoidRootPart), boxplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Front, 6, (boxplayertarget.Character.HumanoidRootPart), boxplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Back, 6, (boxplayertarget.Character.HumanoidRootPart), boxplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Front, 6, (boxplayertarget.Character.HumanoidRootPart), boxplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Back, 6, (boxplayertarget.Character.HumanoidRootPart), boxplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Right, 6, (boxplayertarget.Character.HumanoidRootPart), boxplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Left, 6, (boxplayertarget.Character.HumanoidRootPart), boxplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Right, 6, (boxplayertarget.Character.HumanoidRootPart), boxplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(16989882575, Enum.NormalId.Left, 6, (boxplayertarget.Character.HumanoidRootPart), boxplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Blind", Default = false })

Toggle:OnChanged(function(boxplayer)
    if boxplayer == true then
        boxplayerloop = true
        while boxplayerloop do
            function boxplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            boxplayertarget = players:FindFirstChild(v.Name)
                            boxplayerfunc()
                            task.wait()
                        end
                    end
                else
                    boxplayertarget = players:FindFirstChild(fetargetname)
                    boxplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(boxplayerloopfix)
        end
    end
    if boxplayer == false then
        boxplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
