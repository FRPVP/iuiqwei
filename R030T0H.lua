local customID = 10180722469 -- Default ID

local Input = Tabs.Player:AddInput("Input", {
    Title = "Custom ID",
    Default = tostring(customID),
    Placeholder = "Enter custom ID",
    Numeric = true, -- Only allows numbers
    Finished = true, -- Calls callback when you press enter
    Callback = function(Value)
        customID = tonumber(Value)
    end
})

Input:OnChanged(function()
    customID = tonumber(Input.Value)
end)

function kljklkjasplayerfunc(id)
    local sprayRemote = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote
    local rootPart = kljklkjasplayertarget.Character.HumanoidRootPart
    sprayRemote:FireServer(id, Enum.NormalId.Top, 6, rootPart, rootPart.CFrame * CFrame.new(0, 3, 0))
    -- Repeat for other directions
end

local kljklkjasplayerloop = false

local Toggle = Tabs.Premium:AddToggle("", {Title = "Rickroll", Default = false })

Toggle:OnChanged(function(kljklkjasplayer)
    if kljklkjasplayer then
        kljklkjasplayerloop = true
        while kljklkjasplayerloop do
            EquipSpray()
            task.wait(0.4)
            local infinityGauntlet = Options.MyToggle:Value()
            local players = game:GetService("Players")
            if infinityGauntlet == "All" then
                for _, v in pairs(players:GetPlayers()) do
                    local kljklkjasplayertarget = players:FindFirstChild(v.Name)
                    if kljklkjasplayertarget then
                        kljklkjasplayerfunc(customID)
                        task.wait()
                    end
                end
            else
                local kljklkjasplayertarget = players:FindFirstChild(infinityGauntlet)
                if kljklkjasplayertarget then
                    kljklkjasplayerfunc(customID)
                end
            end
            task.wait(15)
        end
    else
        kljklkjasplayerloop = false
    end
end)

Options.MyToggle:SetValue(false)
