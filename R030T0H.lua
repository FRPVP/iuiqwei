local Input = Tabs.Premium:AddInput("Input", {
    Title = "Input",
    Default = "",
    Placeholder = "Placeholder",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        print("Input changed:", Value)
        -- Update the ID used in ahdkskwwplayerfunc
        ahdkskwwplayerfunc(Value)
    end
})

Input:OnChanged(function()
    print("Input updated:", Input.Value)
    -- Update the ID used in ahdkskwwplayerfunc
    ahdkskwwplayerfunc(Input.Value)
end)




function ahdkskwwplayerfunc()
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(ID, Enum.NormalId.Top, 6, (ahdkskwwplayertarget.Character.HumanoidRootPart), ahdkskwwplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(ID, Enum.NormalId.Bottom, 6, (ahdkskwwplayertarget.Character.HumanoidRootPart), ahdkskwwplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(ID, Enum.NormalId.Bottom, 6, (ahdkskwwplayertarget.Character.HumanoidRootPart), ahdkskwwplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(ID, Enum.NormalId.Top, 6, (ahdkskwwplayertarget.Character.HumanoidRootPart), ahdkskwwplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(ID, Enum.NormalId.Front, 6, (ahdkskwwplayertarget.Character.HumanoidRootPart), ahdkskwwplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(ID, Enum.NormalId.Back, 6, (ahdkskwwplayertarget.Character.HumanoidRootPart), ahdkskwwplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(ID, Enum.NormalId.Front, 6, (ahdkskwwplayertarget.Character.HumanoidRootPart), ahdkskwwplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(ID, Enum.NormalId.Back, 6, (ahdkskwwplayertarget.Character.HumanoidRootPart), ahdkskwwplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(ID, Enum.NormalId.Right, 6, (ahdkskwwplayertarget.Character.HumanoidRootPart), ahdkskwwplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(ID, Enum.NormalId.Left, 6, (ahdkskwwplayertarget.Character.HumanoidRootPart), ahdkskwwplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(ID, Enum.NormalId.Right, 6, (ahdkskwwplayertarget.Character.HumanoidRootPart), ahdkskwwplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(ID, Enum.NormalId.Left, 6, (ahdkskwwplayertarget.Character.HumanoidRootPart), ahdkskwwplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "this a test", Default = false })

Toggle:OnChanged(function(ahdkskwwplayer)
    if ahdkskwwplayer == true then
        ahdkskwwplayerloop = true
        while ahdkskwwplayerloop do
            function ahdkskwwplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        ahdkskwwplayertarget = players:FindFirstChild(v.Name)
                        ahdkskwwplayerfunc()
                        task.wait()
                    end
                else
                    ahdkskwwplayertarget = players:FindFirstChild(infinityGauntlet)
                    ahdkskwwplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(ahdkskwwplayerloopfix)
        end
    end
    if ahdkskwwplayer == false then
        ahdkskwwplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
