function feslipfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (fesliptarget.Character.LeftUpperLeg), fesliptarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (fesliptarget.Character.LeftUpperLeg), fesliptarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(7199393435, Enum.NormalId.Top, 3.5, (fesliptarget.Character.HumanoidRootPart), fesliptarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(7199393435, Enum.NormalId.Bottom, 3.5, (fesliptarget.Character.HumanoidRootPart), fesliptarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.85, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Slip Up", Default = false })

Toggle:OnChanged(function(feslip)
    if feslip == true then
        fesliploop = true
        while fesliploop do
            function fesliploopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        fesliptarget = players:FindFirstChild(v.Name)
                        feslipfunc()
                        task.wait()
                    end
                else
                    fesliptarget = players:FindFirstChild(fetargetname)
                    feslipfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(fesliploopfix)
        end
    end
    if feslip == false then
        fesliploop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
