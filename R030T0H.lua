function cantreadfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (cantreadtarget.Character.RightUpperLeg), cantreadtarget.Character.RightUpperLeg.CFrame * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (cantreadtarget.Character.LeftUpperLeg), cantreadtarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (cantreadtarget.Character.HumanoidRootPart), cantreadtarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Bottom, 6.331, (cantreadtarget.Character.LeftHand), cantreadtarget.Character.LeftHand.CFrame * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (cantreadtarget.Character.RightLowerLeg), cantreadtarget.Character.RightLowerLeg.CFrame * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (cantreadtarget.Character.LeftLowerLeg), cantreadtarget.Character.LeftLowerLeg.CFrame * CFrame.new(0, 0, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (cantreadtarget.Character.Head), cantreadtarget.Character.Head.CFrame * CFrame.new(0, 0, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "test", Default = false })

Toggle:OnChanged(function(cantread)
    if cantread == true then
        cantreadloop = true
        while cantreadloop do
            function cantreadloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            cantreadtarget = players:FindFirstChild(v.Name)
                            cantreadfunc()
                            task.wait()
                        end
                    end
                else
                    cantreadtarget = players:FindFirstChild(fetargetname)
                    cantreadfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(cantreadloopfix)
        end
    end
    if cantread == false then
        cantreadloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
