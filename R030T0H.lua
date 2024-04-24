function collideplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Back, 6.331, (collideplayertarget.Character.HumanoidRootPart), collideplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 99999, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Remove Collide Sensors", Default = false })

Toggle:OnChanged(function(collideplayer)
    if collideplayer == true then
        collideplayerloop = true
        while collideplayerloop do
            function collideplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            collideplayertarget = players:FindFirstChild(v.Name)
                            collideplayerfunc()
                            task.wait()
                        end
                    end
                else
                    collideplayertarget = players:FindFirstChild(fetargetname)
                    collideplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(collideplayerloopfix)
        end
    end
    if collideplayer == false then
        collideplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
