function holdplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Bottom, 6.331, (holdplayertarget.Character.HumanoidRootPart), holdplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 99999, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Test", Default = false })

Toggle:OnChanged(function(holdplayer)
    if holdplayer == true then
        holdplayerloop = true
        while holdplayerloop do
            function holdplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        holdplayertarget = players:FindFirstChild(v.Name)
                        holdplayerfunc()
                        task.wait()
                    end
                else
                    holdplayertarget = players:FindFirstChild(fetargetname)
                    holdplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(holdplayerloopfix)
        end
    end
    if holdplayer == false then
        holdplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
