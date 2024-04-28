function fehowfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (fehowtarget.Character.LeftUpperLeg), fehowtarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, 99999, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (fehowtarget.Character.LeftUpperLeg), fehowtarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, 99999, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "testing", Default = false })

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
