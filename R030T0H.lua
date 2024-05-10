local function mxcvasdlplayerfunc(sprayID, target)
    local sprayRemote = game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote
    local rootPart = target.Character.HumanoidRootPart
    sprayRemote:FireServer(sprayID, Enum.NormalId.Top, 6, rootPart, rootPart.CFrame * CFrame.new(0, 3, 0))
sprayRemote:FireServer(sprayID, Enum.NormalId.Bottom, 6, rootPart, rootPart.CFrame * CFrame.new(0, 3.15, 0))
sprayRemote:FireServer(sprayID, Enum.NormalId.Bottom, 6, rootPart, rootPart.CFrame * CFrame.new(0, -2.8, 0))
sprayRemote:FireServer(sprayID, Enum.NormalId.Top, 6, rootPart, rootPart.CFrame * CFrame.new(0, -3, 0))
gsprayRemote:FireServer(sprayID, Enum.NormalId.Front, 6, rootPart, rootPart.CFrame * CFrame.new(0, 0.1, 3.1))
sprayRemote:FireServer(sprayID, Enum.NormalId.Back, 6, rootPart, rootPart.CFrame * CFrame.new(0, 0.1, 2.86))
sprayRemote:FireServer(sprayID, Enum.NormalId.Front, 6, rootPart, rootPart.CFrame * CFrame.new(0, 0.1, -2.86))
sprayRemote:FireServer(sprayID, Enum.NormalId.Back, 6, rootPart, rootPart.CFrame * CFrame.new(0, 0.1, -3.1))
sprayRemote:FireServer(sprayID, Enum.NormalId.Right, 6, rootPart, rootPart.CFrame * CFrame.new(2.86, 0.1, 0))
sprayRemote:FireServer(sprayID, Enum.NormalId.Left, 6, rootPart, rootPart.CFrame * CFrame.new(3.1, 0.1, 0))
sprayRemote:FireServer(sprayID, Enum.NormalId.Right, 6, rootPart, rootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
sprayRemote:FireServer(sprayID, Enum.NormalId.Left, 6, rootPart, rootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
end

local mxcvasdlplayerloop = false
local sprayID = 0 -- Default spray ID

local Input = Tabs.Player:AddInput("Input", {
    Title = "Spray ID",
    Default = sprayID,
    Placeholder = "Enter custom spray ID",
    Numeric = true, -- Allows only numbers
    Finished = true, -- Calls callback when you press enter
    Callback = function(Value)
        sprayID = tonumber(Value) or sprayID -- Convert input to number, or keep default if invalid
    end
})

Input:OnChanged(function()
    sprayID = tonumber(Input.Value) or sprayID -- Convert input to number, or keep default if invalid
end)

local Toggle = Tabs.Premium:AddToggle("", {Title = "Box Player", Default = false })

Toggle:OnChanged(function(mxcvasdlplayer)
    if mxcvasdlplayer then
        mxcvasdlplayerloop = true
        while mxcvasdlplayerloop do
            EquipSpray()
            task.wait(0.4)
            local infinityGauntlet = Options.MyToggle:Value()
            local players = game:GetService("Players")
            if infinityGauntlet == "All" then
                for _, v in pairs(players:GetPlayers()) do
                    local mxcvasdlplayertarget = players:FindFirstChild(v.Name)
                    if mxcvasdlplayertarget then
                        mxcvasdlplayerfunc(sprayID, mxcvasdlplayertarget)
                        task.wait()
                    end
                end
            else
                local mxcvasdlplayertarget = players:FindFirstChild(infinityGauntlet)
                if mxcvasdlplayertarget then
                    mxcvasdlplayerfunc(sprayID, mxcvasdlplayertarget)
                end
            end
            task.wait(15)
        end
    else
        mxcvasdlplayerloop = false
    end
end)

Options.MyToggle:SetValue(false)
