function reerplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Bottom, 6.331, (reerplayertarget.Character.HumanoidRootPart), reerplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 99999, 0)
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Remove Collides", Default = false })

Toggle:OnChanged(function(reerplayer)
    if reerplayer == true then
        reerplayerloop = true
        while reerplayerloop do
            function reerplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            reerplayertarget = players:FindFirstChild(v.Name)
                            reerplayerfunc()
                            task.wait()
                        end
                    end
                else
                    reerplayertarget = players:FindFirstChild(fetargetname)
                    reerplayerfunc()
                end
                task.wait(0)
            end
            wait()
            pcall(reerplayerloopfix)
        end
    end
    if reerplayer == false then
        reerplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
