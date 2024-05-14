local Players = game:GetService("Players")
local sprayId = 12781220539  -- Default spray ID

function sprayGood(target)
    local localPlayer = Players.LocalPlayer
    local humanoidRootPart = target.Character.HumanoidRootPart
    local cFrameOffsets = {
        {Enum.NormalId.Top, CFrame.new(0, 3, 0)},
        {Enum.NormalId.Bottom, CFrame.new(0, 3.15, 0)},
        {Enum.NormalId.Bottom, CFrame.new(0, -2.8, 0)},
        {Enum.NormalId.Top, CFrame.new(0, -3, 0)},
        {Enum.NormalId.Front, CFrame.new(0, 0.1, 3.1)},
        {Enum.NormalId.Back, CFrame.new(0, 0.1, 2.86)},
        {Enum.NormalId.Front, CFrame.new(0, 0.1, -2.86)},
        {Enum.NormalId.Back, CFrame.new(0, 0.1, -3.1)},
        {Enum.NormalId.Right, CFrame.new(2.86, 0.1, 0)},
        {Enum.NormalId.Left, CFrame.new(3.1, 0.1, 0)},
        {Enum.NormalId.Right, CFrame.new(-3.1, 0.1, 0)},
        {Enum.NormalId.Left, CFrame.new(-2.86, 0.1, 0)}
    }
    for _, offset in pairs(cFrameOffsets) do
        localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, offset[1], 6, humanoidRootPart, humanoidRootPart.CFrame * offset[2])
    end
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Rickroll", Default = false})

Toggle:OnChanged(function(lkasdjplayer)
    if lkasdjplayer == true then
        lkasdjplayerloop = true
        while lkasdjplayerloop do
            function lkasdjplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(Players:GetPlayers()) do
                        local lkasdjplayertarget = Players:FindFirstChild(v.Name)
                        if lkasdjplayertarget then
                            sprayGood(lkasdjplayertarget)
                            task.wait()
                        end
                    end
                else
                    local lkasdjplayertarget = Players:FindFirstChild(infinityGauntlet)
                    if lkasdjplayertarget then
                        sprayGood(lkasdjplayertarget)
                    end
                end
                task.wait(15)
            end
            wait()
            pcall(lkasdjplayerloopfix)
        end
    else
        lkasdjplayerloop = false
    end
end)

local Input = Tabs.Player:AddInput("Input", {
    Title = "Input",
    Default = tostring(sprayId),
    Placeholder = "Enter Spray ID",
    Numeric = true, -- Only allows numbers
    Finished = true, -- Only calls callback when you press enter
    Callback = function(Value)
        sprayId = tonumber(Value) or sprayId
        print("Spray ID changed:", sprayId)
    end
})

Input:OnChanged(function()
    sprayId = tonumber(Input.Value) or sprayId
    print("Spray ID updated:", sprayId)
end)

Options.MyToggle:SetValue(false)
