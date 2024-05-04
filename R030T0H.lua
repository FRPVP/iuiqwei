function phubplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(17189770364, Enum.NormalId.Front, 5, (phubplayertarget.Character.HumanoidRootPart), phubplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,5,0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "PHub Logo", Default = false })

Toggle:OnChanged(function(phubplayer)
    if phubplayer == true then
        phubplayerloop = true
        while phubplayerloop do
            function phubplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        phubplayertarget = players:FindFirstChild(v.Name)
                        phubplayerfunc()
                        task.wait()
                    end
                else
                    phubplayertarget = players:FindFirstChild(infinityGauntlet)
                    phubplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(phubplayerloopfix)
        end
    end
    if phubplayer == false then
        phubplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
