function fehowfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (fehowtarget.Character.RightUpperLeg), fehowtarget.Character.RightUpperLeg.CFrame * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (fehowtarget.Character.LeftUpperLeg), fehowtarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (fehowtarget.Character.RightLowerLeg), fehowtarget.Character.RightLowerLeg.CFrame * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (fehowtarget.Character.LeftLowerLeg), fehowtarget.Character.LeftLowerLeg.CFrame * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (fehowtarget.Character.HumanoidRootPart), fehowtarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (fehowtarget.Character.LeftHand), fehowtarget.Character.LeftHand.CFrame * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (fehowtarget.Character.RightHand), fehowtarget.Character.RightHand.CFrame * CFrame.new(0, 0, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Test2", Default = false })

Toggle:OnChanged(function(fehow)
    if fehow == true then
        fehowloop = true
        while fehowloop do
            function fehowloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            fehowtarget = players:FindFirstChild(v.Name)
                            fehowfunc()
                            task.wait()
                        end
                    end
                else
                    fehowtarget = players:FindFirstChild(fetargetname)
                    fehowfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(fehowloopfix)
        end
    end
    if fehow == false then
        fehowloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
