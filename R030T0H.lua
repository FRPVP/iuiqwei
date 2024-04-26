function communistplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(6978648716, Enum.NormalId.Front, 5, (communistplayertarget.Character.HumanoidRootPart), communistplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,5,0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Communist", Default = false })

Toggle:OnChanged(function(communistplayer)
    if communistplayer == true then
        communistplayerloop = true
        while communistplayerloop do
            function communistplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        communistplayertarget = players:FindFirstChild(v.Name)
                        communistplayerfunc()
                        task.wait()
                    end
                else
                    communistplayertarget = players:FindFirstChild(fetargetname)
                    communistplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(communistplayerloopfix)
        end
    end
    if communistplayer == false then
        communistplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
