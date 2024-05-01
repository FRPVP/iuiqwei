function cumplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14976845153, Enum.NormalId.Front, 1.5, (cumplayertarget.Character.HumanoidRootPart), cumplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.15,-2.90))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Cum On Penis", Default = false })

Toggle:OnChanged(function(cumplayer)
    if cumplayer == true then
        cumplayerloop = true
        while cumplayerloop do
            function cumplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            cumplayertarget = players:FindFirstChild(v.Name)
                            cumplayerfunc()
                            task.wait()
                        end
                    end
                else
                    cumplayertarget = players:FindFirstChild(infinityGauntlet)
                    cumplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(cumplayerloopfix)
        end
    end
    if cumplayer == false then
        cumplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
