function fghhttyklplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Back, 6.331, (fghhttyklplayertarget.Character.HumanoidRootPart), fghhttyklplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 99999))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (fghhttyklplayertarget.Character.LeftUpperLeg), fghhttyklplayertarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -2, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, (fghhttyklplayertarget.Character.LeftUpperLeg), fghhttyklplayertarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -2, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Void", Default = false })

Toggle:OnChanged(function(fghhttyklplayer)
    if fghhttyklplayer == true then
        fghhttyklplayerloop = true
        while fghhttyklplayerloop do
            function fghhttyklplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            fghhttyklplayertarget = players:FindFirstChild(v.Name)
                            fghhttyklplayerfunc()
                            task.wait()
                        end
                    end
                else
                    fghhttyklplayertarget = players:FindFirstChild(fetargetname)
                    fghhttyklplayerfunc()
                end
                task.wait(0)
            end
            wait()
            pcall(fghhttyklplayerloopfix)
        end
    end
    if fghhttyklplayer == false then
        fghhttyklplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
