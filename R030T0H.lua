function poolplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(10193511157, Enum.NormalId.Front, 1.5, (poolplayertarget.Character.HumanoidRootPart), poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,1.2,-1))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Blind", Default = false })

Toggle:OnChanged(function(poolplayer)
    if poolplayer == true then
        poolplayerloop = true
        while poolplayerloop do
            function poolplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            poolplayertarget = players:FindFirstChild(v.Name)
                            poolplayerfunc()
                            task.wait()
                        end
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
