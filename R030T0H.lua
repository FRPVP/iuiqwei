function poolplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Top, 2048, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Pool", Default = false })

Toggle:OnChanged(function(poolplayer)
    if poolplayer == true then
        poolplayerloop = true
        while poolplayerloop do
            function poolplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        poolplayertarget = players:FindFirstChild(v.Name)
                        poolplayerfunc()
                        task.wait()
                    end
                else
                    poolplayertarget = players:FindFirstChild(fetargetname)
                    poolplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(poolplayerloopfix)
        end
    end
    if poolplayer == false then
        poolplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
