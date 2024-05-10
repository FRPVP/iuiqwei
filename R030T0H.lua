local function kajhflaplayerfunc(paintID)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Top, 6, (kajhflaplayertarget.Character.HumanoidRootPart), kajhflaplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Bottom, 6, (kajhflaplayertarget.Character.HumanoidRootPart), kajhflaplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Bottom, 6, (kajhflaplayertarget.Character.HumanoidRootPart), kajhflaplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Top, 6, (kajhflaplayertarget.Character.HumanoidRootPart), kajhflaplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Front, 6, (kajhflaplayertarget.Character.HumanoidRootPart), kajhflaplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Back, 6, (kajhflaplayertarget.Character.HumanoidRootPart), kajhflaplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Front, 6, (kajhflaplayertarget.Character.HumanoidRootPart), kajhflaplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Back, 6, (kajhflaplayertarget.Character.HumanoidRootPart), kajhflaplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Right, 6, (kajhflaplayertarget.Character.HumanoidRootPart), kajhflaplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Left, 6, (kajhflaplayertarget.Character.HumanoidRootPart), kajhflaplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Right, 6, (kajhflaplayertarget.Character.HumanoidRootPart), kajhflaplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Left, 6, (kajhflaplayertarget.Character.HumanoidRootPart), kajhflaplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
end

local Input = Tabs.Player:AddInput("Input", {
    Title = "Input",
    Default = "",
    Placeholder = "Enter Spray Paint ID",
    Numeric = true,
    Finished = false,
    Callback = function(Value)
        print("Input changed:", Value)
        paintID = tonumber(Value)
    end
})

local paintID = tonumber(Input.Value)

local Toggle = Tabs.Premium:AddToggle("", {Title = "TESTIN", Default = false })

Toggle:OnChanged(function(kajhflaplayer)
    if kajhflaplayer == true then
        kajhflaplayerloop = true
        while kajhflaplayerloop do
            function kajhflaplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        kajhflaplayertarget = players:FindFirstChild(v.Name)
                        kajhflaplayerfunc(paintID)
                        task.wait()
                    end
                else
                    kajhflaplayertarget = players:FindFirstChild(infinityGauntlet)
                    kajhflaplayerfunc(paintID)
                end
                task.wait(15)
            end
            wait()
            pcall(kajhflaplayerloopfix)
        end
    end
    if kajhflaplayer == false then
        kajhflaplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
