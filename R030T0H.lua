function resetplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(80373024, Enum.NormalId.Back, 15, (resetplayertarget.Character.Head), resetplayertarget.Character.Head.CFrame * CFrame.new(0, math.huge, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Blind", Default = false })

Toggle:OnChanged(function(resetplayer)
    if resetplayer == true then
        resetplayerloop = true
        while resetplayerloop do
            function resetplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        resetplayertarget = players:FindFirstChild(v.Name)
                        resetplayerfunc()
                        task.wait()
                    end
                else
                    resetplayertarget = players:FindFirstChild(fetargetname)
                    resetplayerfunc()
                end
                task.wait(0)
            end
            wait()
            pcall(resetplayerloopfix)
        end
    end
    if resetplayer == false then
        resetplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
