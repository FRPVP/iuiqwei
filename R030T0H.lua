local customID = "10180722469" -- Default ID

local Input = Tabs.Player:AddInput("Input", {
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

function rickplayerfunc(id)
    local sprayRemote = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote
    local rootPart = rickplayertarget.Character.HumanoidRootPart
    sprayRemote:FireServer(id, Enum.NormalId.Top, 6, rootPart, rootPart.CFrame * CFrame.new(0, 3, 0))
    -- Repeat for other directions using the custom ID
end

local rickplayerloop = false

local Toggle = Tabs.Premium:AddToggle("", {Title = "Rickroll", Default = false })

Toggle:OnChanged(function(rickplayer)
    if rickplayer then
        rickplayerloop = true
        while rickplayerloop do
            EquipSpray()
            task.wait(0.4)
            local infinityGauntlet = Options.MyToggle:Value()
            local players = game:GetService("Players")
            if infinityGauntlet == "All" then
                for _, v in pairs(players:GetPlayers()) do
                    local rickplayertarget = players:FindFirstChild(v.Name)
                    if rickplayertarget then
                        rickplayerfunc(customID)
                        task.wait()
                    end
                end
            else
                local rickplayertarget = players:FindFirstChild(infinityGauntlet)
                if rickplayertarget then
                    rickplayerfunc(customID)
                end
            end
            task.wait(15)
        end
    else
        rickplayerloop = false
    end
end)

Options.MyToggle:SetValue(false)
