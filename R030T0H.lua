function cumfunc()
game.Players.LocalPlayer:DistanceFromCharacter(v.Character.HumanoidRootPart.Position) < 5 then cumtarget = players:FindFirstChild(v.Name)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 3, (cumtarget.Character.RightHand), cumtarget.Character.RightHand.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Top, 3, (cumtarget.Character.LeftLowerArm), cumtarget.Character.LeftLowerArm.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Top, 3, (cumtarget.Character.RightLowerArm), cumtarget.Character.RightLowerArm.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 3, (cumtarget.Character.LeftUpperArm), cumtarget.Character.LeftUpperArm.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Right, 3, (cumtarget.Character.LowerTorso), cumtarget.Character.LowerTorso.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Left, 3, (cumtarget.Character.LeftLowerLeg), cumtarget.Character.LeftLowerLeg.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Top, 3, (cumtarget.Character.LeftUpperLeg), cumtarget.Character.LeftUpperLeg.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Back, 3, (cumtarget.Character.LeftFoot), cumtarget.Character.LeftFoot.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 3, (cumtarget.Character.RightFoot), cumtarget.Character.RightFoot.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Left, 3, (cumtarget.Character.RightLowerLeg), cumtarget.Character.RightLowerLeg.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Right, 3, (cumtarget.Character.RightUpperLeg), cumtarget.Character.RightUpperLeg.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Left, 3, (cumtarget.Character.UpperTorso), cumtarget.Character.UpperTorso.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Right, 3, (cumtarget.Character.Head), cumtarget.Character.Head.CFrame)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 3, (cumtarget.Character.Head), cumtarget.Character.Head.CFrame)
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Cum", Default = false })

Toggle:OnChanged(function(cum)
    if cum == true then
        cumloop = true
        while cumloop do
            function cumloopfix()
                EquipSpray()
                task.wait(0.4)
                if fetargetname == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        cumtarget = players:FindFirstChild(v.Name)
                        cumfunc()
                        task.wait()
                    end
                else
                    cumtarget = players:FindFirstChild(fetargetname)
                    cumfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(cumloopfix)
        end
    end
    if cum == false then
        cumloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
