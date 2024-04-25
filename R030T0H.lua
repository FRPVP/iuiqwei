function faceplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12579922286, Enum.NormalId.Bottom, 2048, (faceplayertarget.Character.HumanoidRootPart), faceplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Creep Above Player", Default = false })

Toggle:OnChanged(function(faceplayer)
    if faceplayer == true then
        faceplayerloop = true
        while faceplayerloop do
            function faceplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            faceplayertarget = players:FindFirstChild(v.Name)
                            faceplayerfunc()
                            task.wait()
                        end
                    end
                else
                    faceplayertarget = players:FindFirstChild(fetargetname)
                    faceplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(faceplayerloopfix)
        end
    end
    if faceplayer == false then
        faceplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
