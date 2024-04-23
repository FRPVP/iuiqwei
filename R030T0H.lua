function cumfunc()
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(-8, 14, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 2048, (nazigermanytarget.Character.HumanoidRootPart), nazigermanytarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Cum", Default = false })

Toggle:OnChanged(function(cum)
    if cum == true then
        cumloop = true
        while cumloop do
            function cumloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        cumtarget = players:FindFirstChild(v.Name)
                        cumfunc()
                        task.wait()
                    end
                else
                    cumtarget = players:FindFirstChild(fetargetname)
                    cumfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(cumloopfix)
        end
    end
    if cum == false then
        cumloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
