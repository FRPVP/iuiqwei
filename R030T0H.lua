function laughplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12877195347, Enum.NormalId.Front, 1.5, (laughplayertarget.Character.HumanoidRootPart), laughplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,1.2,-1))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "LOL", Default = false })

Toggle:OnChanged(function(laughplayer)
    if laughplayer == true then
        laughplayerloop = true
        while laughplayerloop do
            function laughplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            laughplayertarget = players:FindFirstChild(v.Name)
                            laughplayerfunc()
                            task.wait()
                        end
                    end
                else
                    laughplayertarget = players:FindFirstChild(infinityGauntlet)
                    laughplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(laughplayerloopfix)
        end
    end
    if laughplayer == false then
        laughplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
