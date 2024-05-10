local customID = "10180722469" -- Default ID

local Input = Tabs.Premium:AddInput("Input", {
    Title = "Custom ID",
    Default = customID,
    Placeholder = "Enter custom ID",
    Numeric = true, -- Only allows numbers
    Finished = true, -- Calls callback when you press enter
    Callback = function(Value)
        print("Custom ID changed:", Value)
        customID = Value
    end
})

Input:OnChanged(function()
    print("Custom ID updated:", Input.Value)
    customID = Input.Value
end)

function asdasxzcplayerfunc(id)
    local sprayRemote = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote
    local rootPart = asdasxzcplayertarget.Character.HumanoidRootPart
    sprayRemote:FireServer(id, Enum.NormalId.Top, 6, rootPart, rootPart.CFrame * CFrame.new(0, 3, 0))
    sprayRemote:FireServer(id, Enum.NormalId.Bottom, 6, rootPart, rootPart.CFrame * CFrame.new(0, 3.15, 0))
sprayRemote:FireServer(id, Enum.NormalId.Bottom, 6, rootPart, rootPart.CFrame * CFrame.new(0, -2.8, 0))
sprayRemote:FireServer(id, Enum.NormalId.Top, 6, rootPart, rootPart.CFrame * CFrame.new(0, -3, 0))
gsprayRemote:FireServer(id, Enum.NormalId.Front, 6, rootPart, rootPart.CFrame * CFrame.new(0, 0.1, 3.1))
sprayRemote:FireServer(id, Enum.NormalId.Back, 6, rootPart, rootPart.CFrame * CFrame.new(0, 0.1, 2.86))
sprayRemote:FireServer(id, Enum.NormalId.Front, 6, rootPart, rootPart.CFrame * CFrame.new(0, 0.1, -2.86))
sprayRemote:FireServer(id, Enum.NormalId.Back, 6, rootPart, rootPart.CFrame * CFrame.new(0, 0.1, -3.1))
sprayRemote:FireServer(id, Enum.NormalId.Right, 6, rootPart, rootPart.CFrame * CFrame.new(2.86, 0.1, 0))
sprayRemote:FireServer(id, Enum.NormalId.Left, 6, rootPart, rootPart.CFrame * CFrame.new(3.1, 0.1, 0))
sprayRemote:FireServer(id, Enum.NormalId.Right, 6, rootPart, rootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
sprayRemote:FireServer(id, Enum.NormalId.Left, 6, rootPart, rootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
end

local asdasxzcplayerloop = false

local Toggle = Tabs.Premium:AddToggle("", {Title = "Box", Default = false })

Toggle:OnChanged(function(asdasxzcplayer)
    if asdasxzcplayer then
        asdasxzcplayerloop = true
        while asdasxzcplayerloop do
            EquipSpray()
            task.wait(0.4)
            local infinityGauntlet = Options.MyToggle:Value()
            local players = game:GetService("Players")
            if infinityGauntlet == "All" then
                for _, v in pairs(players:GetPlayers()) do
                    local asdasxzcplayertarget = players:FindFirstChild(v.Name)
                    if asdasxzcplayertarget then
                        asdasxzcplayerfunc(customID)
                        task.wait()
                    end
                end
            else
                local asdasxzcplayertarget = players:FindFirstChild(infinityGauntlet)
                if asdasxzcplayertarget then
                    asdasxzcplayerfunc(customID)
                end
            end
            task.wait(15)
        end
    else
        asdasxzcplayerloop = false
    end
end)

Options.MyToggle:SetValue(false)
