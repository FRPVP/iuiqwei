function fepenisfunc()
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,-0.7))

end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Penis", Default = false })

Toggle:OnChanged(function(fepenis)
    if fepenis == true then
        fepenisloop = true
        while fepenisloop do
            function fepenisloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        fepenistarget = players:FindFirstChild(v.Name)
                        fepenisfunc()
                        task.wait()
                    end
                else
                    fepenistarget = players:FindFirstChild(fetargetname)
                    fepenisfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(fepenisloopfix)
        end
    end
    if fepenis == false then
        fepenisloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
