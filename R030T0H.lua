function filedownplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(15093138669, Enum.NormalId.Right, 3, (filedownplayertarget.Character.RightHand), filedownplayertarget.Character.RightHand.CFrame * CFrame.new(0, 0, -0.7))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(15096522641, Enum.NormalId.Left, 3, (filedownplayertarget.Character.RightHand), filedownplayertarget.Character.RightHand.CFrame * CFrame.new(0, 0, -0.7))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Fake Knife", Default = false })

Toggle:OnChanged(function(filedownplayer)
    if filedownplayer == true then
        filedownplayerloop = true
        while filedownplayerloop do
            function filedownplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        filedownplayertarget = players:FindFirstChild(v.Name)
                        filedownplayerfunc()
                        task.wait()
                    end
                else
                    filedownplayertarget = players:FindFirstChild(infinityGauntlet)
                    filedownplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(filedownplayerloopfix)
        end
    end
    if filedownplayer == false then
        filedownplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
