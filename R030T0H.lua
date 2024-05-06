function iawudauyyplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Back, 6.331, (iawudauyyplayertarget.Character.HumanoidRootPart), iawudauyyplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 99999, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Back, 6.331, (iawudauyyplayertarget.Character.RightHand), iawudauyyplayertarget.Character.RightHand.CFrame * CFrame.new(0, 99999, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Testing", Default = false })

Toggle:OnChanged(function(iawudauyyplayer)
    if iawudauyyplayer == true then
        iawudauyyplayerloop = true
        while iawudauyyplayerloop do
            function iawudauyyplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        if v ~= players.LocalPlayer then -- Skip executing the function on yourself
                            iawudauyyplayertarget = players:FindFirstChild(v.Name)
                            iawudauyyplayerfunc()
                            task.wait()
                        end
                    end
                else
                    iawudauyyplayertarget = players:FindFirstChild(fetargetname)
                    iawudauyyplayerfunc()
                end
                task.wait(0)
            end
            wait()
            pcall(iawudauyyplayerloopfix)
        end
    end
    if iawudauyyplayer == false then
        iawudauyyplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
