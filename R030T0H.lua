function laughplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12877195347, Enum.NormalId.Front, 1.5, (laughplayertarget.Character.HumanoidRootPart), laughplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,1.2,-1))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Cum on Penis", Default = false })

Toggle:OnChanged(function(laughplayer)
    if laughplayer == true then
        laughplayerloop = true
        while laughplayerloop do
            function laughplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        laughplayertarget = players:FindFirstChild(v.Name)
                        laughplayerfunc()
                        task.wait()
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
