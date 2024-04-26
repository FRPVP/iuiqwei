function trollplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(6978648716, Enum.NormalId.Front, 1.5, (trollplayertarget.Character.HumanoidRootPart), trollplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,5,0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Troll Face", Default = false })

Toggle:OnChanged(function(trollplayer)
    if trollplayer == true then
        trollplayerloop = true
        while trollplayerloop do
            function trollplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            trollplayertarget = players:FindFirstChild(v.Name)
                            trollplayerfunc()
                            task.wait()
                        end
                    end
                else
                    trollplayertarget = players:FindFirstChild(fetargetname)
                    trollplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(trollplayerloopfix)
        end
    end
    if trollplayer == false then
        trollplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
