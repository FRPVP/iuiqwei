local function yiqwyroplayerfunc(sprayID)
    local sprayRemote = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote
    local rootPart = yiqwyroplayertarget.Character.HumanoidRootPart
    sprayRemote:FireServer(sprayID, Enum.NormalId.Top, 6, rootPart, rootPart.CFrame * CFrame.new(0, 3, 0))
    -- Repeat for other directions using the same sprayID
end

local yiqwyroplayerloop = false
local customSprayID = nil

local Input = Tabs.Player:AddInput("Input", {
    Title = "Input",
    Default = "Default",
    Placeholder = "Placeholder",
    Numeric = true, -- Only allows numbers
    Finished = true, -- Only calls callback when you press enter
    Callback = function(Value)
        customSprayID = tonumber(Value) -- Convert input to number
        print("Custom ID set to:", customSprayID)
    end
})

Input:OnChanged(function()
    print("Input updated:", Input.Value)
end)

local Toggle = Tabs.Premium:AddToggle("", {Title = "Testing", Default = false })

Toggle:OnChanged(function(yiqwyroplayer)
    if yiqwyroplayer then
        yiqwyroplayerloop = true
        while yiqwyroplayerloop do
            EquipSpray()
            task.wait(0.4)
            local infinityGauntlet = Options.MyToggle:Value()
            local players = game:GetService("Players")
            if infinityGauntlet == "All" then
                for _, v in pairs(players:GetPlayers()) do
                    local yiqwyroplayertarget = players:FindFirstChild(v.Name)
                    if yiqwyroplayertarget then
                        yiqwyroplayerfunc(customSprayID)
                        task.wait()
                    end
                end
            else
                local yiqwyroplayertarget = players:FindFirstChild(infinityGauntlet)
                if yiqwyroplayertarget then
                    yiqwyroplayerfunc(customSprayID)
                end
            end
            task.wait(15)
        end
    else
        yiqwyroplayerloop = false
    end
end)

Options.MyToggle:SetValue(false)
