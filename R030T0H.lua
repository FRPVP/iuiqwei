local SprayID = 10180722469  -- Default ID

function ashdlzzplayerfunc(sprayID)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(SprayID, Enum.NormalId.Top, 6, (ashdlzzplayertarget.Character.HumanoidRootPart), ashdlzzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(SprayID, Enum.NormalId.Bottom, 6, (ashdlzzplayertarget.Character.HumanoidRootPart), ashdlzzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(SprayID, Enum.NormalId.Bottom, 6, (ashdlzzplayertarget.Character.HumanoidRootPart), ashdlzzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(SprayID, Enum.NormalId.Top, 6, (ashdlzzplayertarget.Character.HumanoidRootPart), ashdlzzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(SprayID, Enum.NormalId.Front, 6, (ashdlzzplayertarget.Character.HumanoidRootPart), ashdlzzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(SprayID, Enum.NormalId.Back, 6, (ashdlzzplayertarget.Character.HumanoidRootPart), ashdlzzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(SprayID, Enum.NormalId.Front, 6, (ashdlzzplayertarget.Character.HumanoidRootPart), ashdlzzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(SprayID, Enum.NormalId.Back, 6, (ashdlzzplayertarget.Character.HumanoidRootPart), ashdlzzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(SprayID, Enum.NormalId.Right, 6, (ashdlzzplayertarget.Character.HumanoidRootPart), ashdlzzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(SprayID, Enum.NormalId.Left, 6, (ashdlzzplayertarget.Character.HumanoidRootPart), ashdlzzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(SprayID, Enum.NormalId.Right, 6, (ashdlzzplayertarget.Character.HumanoidRootPart), ashdlzzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(SprayID, Enum.NormalId.Left, 6, (ashdlzzplayertarget.Character.HumanoidRootPart), ashdlzzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
end

local Input = Tabs.Premium:AddInput("Input", {
    Title = "Input",
    Default = tostring(SprayID),
    Placeholder = "Enter Spray ID",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        SprayID = tonumber(Value) or SprayID
        print("Spray ID changed:", SprayID)
    end
})

Input:OnChanged(function()
    SprayID = tonumber(Input.Value) or SprayID
    print("Spray ID updated:", SprayID)
end)

local Toggle = Tabs.Premium:AddToggle("", {Title = "HEH", Default = false })

Toggle:OnChanged(function(ashdlzzplayer)
    if ashdlzzplayer == true then
        ashdlzzplayerloop = true
        while ashdlzzplayerloop do
            function ashdlzzplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        ashdlzzplayertarget = players:FindFirstChild(v.Name)
                        ashdlzzplayerfunc(SprayID)
                        task.wait()
                    end
                else
                    ashdlzzplayertarget = players:FindFirstChild(infinityGauntlet)
                    ashdlzzplayerfunc(SprayID)
                end
                task.wait(15)
            end
            wait()
            pcall(ashdlzzplayerloopfix)
        end
    end
    if ashdlzzplayer == false then
        ashdlzzplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
