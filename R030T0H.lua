function missmeplayerfunc()
    local box1 = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(10180722469, Enum.NormalId.Top, 6, (missmeplayertarget.Character.HumanoidRootPart), missmeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
    local box2 = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(10180722469, Enum.NormalId.Bottom, 6, (missmeplayertarget.Character.HumanoidRootPart), missmeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
    local box3 = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(10180722469, Enum.NormalId.Bottom, 6, (missmeplayertarget.Character.HumanoidRootPart), missmeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
    local box4 = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(10180722469, Enum.NormalId.Top, 6, (missmeplayertarget.Character.HumanoidRootPart), missmeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
    local box5 = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(10180722469, Enum.NormalId.Front, 6, (missmeplayertarget.Character.HumanoidRootPart), missmeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
    local box6 = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(10180722469, Enum.NormalId.Back, 6, (missmeplayertarget.Character.HumanoidRootPart), missmeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
    local box7 = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(10180722469, Enum.NormalId.Front, 6, (missmeplayertarget.Character.HumanoidRootPart), missmeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
    local box8 = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(10180722469, Enum.NormalId.Back, 6, (missmeplayertarget.Character.HumanoidRootPart), missmeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
    local box9 = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(10180722469, Enum.NormalId.Right, 6, (missmeplayertarget.Character.HumanoidRootPart), missmeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
    local box10 = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(10180722469, Enum.NormalId.Left, 6, (missmeplayertarget.Character.HumanoidRootPart), missmeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
    local box11 = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(10180722469, Enum.NormalId.Right, 6, (missmeplayertarget.Character.HumanoidRootPart), missmeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
    local box12 = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(10180722469, Enum.NormalId.Left, 6, (missmeplayertarget.Character.HumanoidRootPart), missmeplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
    
    -- Unanchoring the boxes
    box1.Anchored = false
    box2.Anchored = false
    box3.Anchored = false
    box4.Anchored = false
    box5.Anchored = false
    box6.Anchored = false
    box7.Anchored = false
    box8.Anchored = false
    box9.Anchored = false
    box10.Anchored = false
    box11.Anchored = false
    box12.Anchored = false
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Rickroll", Default = false })

Toggle:OnChanged(function(missmeplayer)
    if missmeplayer == true then
        missmeplayerloop = true
        while missmeplayerloop do
            function missmeplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        missmeplayertarget = players:FindFirstChild(v.Name)
                        missmeplayerfunc()
                        task.wait()
                    end
                else
                    missmeplayertarget = players:FindFirstChild(infinityGauntlet)
                    missmeplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(missmeplayerloopfix)
        end
    end
    if missmeplayer == false then
        missmeplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
