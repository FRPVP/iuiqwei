local function toiuyotplayerfunc(paintID)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Top, 6, (toiuyotplayertarget.Character.HumanoidRootPart), toiuyotplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Bottom, 6, (toiuyotplayertarget.Character.HumanoidRootPart), toiuyotplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Bottom, 6, (toiuyotplayertarget.Character.HumanoidRootPart), toiuyotplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Top, 6, (toiuyotplayertarget.Character.HumanoidRootPart), toiuyotplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Front, 6, (toiuyotplayertarget.Character.HumanoidRootPart), toiuyotplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Back, 6, (toiuyotplayertarget.Character.HumanoidRootPart), toiuyotplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Front, 6, (toiuyotplayertarget.Character.HumanoidRootPart), toiuyotplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Back, 6, (toiuyotplayertarget.Character.HumanoidRootPart), toiuyotplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Right, 6, (toiuyotplayertarget.Character.HumanoidRootPart), toiuyotplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Left, 6, (toiuyotplayertarget.Character.HumanoidRootPart), toiuyotplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Right, 6, (toiuyotplayertarget.Character.HumanoidRootPart), toiuyotplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(paintID, Enum.NormalId.Left, 6, (toiuyotplayertarget.Character.HumanoidRootPart), toiuyotplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
end

local Input = Tabs.Player:AddInput("Input", {
    Title = "Spray ID",
    Default = "",
    Placeholder = "Enter Spray Paint ID",
    Numeric = true,
    Finished = false,
    Callback = function(Value)
        print("Input changed:", Value)
        paintID = tonumber(Value)
    end
})

Input:OnChanged(function()
    print("Input updated:", Input.Value)
end)

local paintID = tonumber(Input.Value)

local Toggle = Tabs.Premium:AddToggle("", {Title = "TESTING", Default = false })

Toggle:OnChanged(function(toiuyotplayer)
    if toiuyotplayer == true then
        toiuyotplayerloop = true
        while toiuyotplayerloop do
            function toiuyotplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        toiuyotplayertarget = players:FindFirstChild(v.Name)
                        toiuyotplayerfunc(paintID)
                        task.wait()
                    end
                else
                    toiuyotplayertarget = players:FindFirstChild(infinityGauntlet)
                    toiuyotplayerfunc(paintID)
                end
                task.wait(15)
            end
            wait()
            pcall(toiuyotplayerloopfix)
        end
    end
    if toiuyotplayer == false then
        toiuyotplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
