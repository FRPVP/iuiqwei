local function rickplayerfunc(sprayID, target)
    local sprayRemote = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote
    local rootPart = target.Character.HumanoidRootPart
    sprayRemote:FireServer(sprayID, Enum.NormalId.Top, 6, rootPart, rootPart.CFrame * CFrame.new(0, 3, 0))
    -- Repeat for other directions
end

local rickplayerloop = false
local sprayID = 10180722469 -- Default spray ID

local Input = Tabs.Player:AddInput("Input", {
    Title = "Spray ID",
    Default = sprayID,
    Placeholder = "Enter custom spray ID",
    Numeric = true, -- Allows only numbers
    Finished = true, -- Calls callback when you press enter
    Callback = function(Value)
        sprayID = tonumber(Value) or sprayID -- Convert input to number, or keep default if invalid
        print("Spray ID changed:", sprayID)
    end
})

Input:OnChanged(function()
    sprayID = tonumber(Input.Value) or sprayID -- Convert input to number, or keep default if invalid
    print("Spray ID updated:", sprayID)
end)

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
                        rickplayerfunc(sprayID, rickplayertarget)
                        task.wait()
                    end
                end
            else
                local rickplayertarget = players:FindFirstChild(infinityGauntlet)
                if rickplayertarget then
                    rickplayerfunc(sprayID, rickplayertarget)
                end
            end
            task.wait(15)
        end
    else
        rickplayerloop = false
    end
end)

Options.MyToggle:SetValue(false)
