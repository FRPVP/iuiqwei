local Players = game:GetService("Players")
local bigpenisId = 9418596904  -- Default spray ID

function allowbigpenisfunc()
    local localPlayer = Players.LocalPlayer
    local target = allowbigpenistarget
    local humanoidRootPart = target.Character.HumanoidRootPart
    
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Bottom, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -2.9, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Bottom, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(2.5, -2.9, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Bottom, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-2.5, -2.9, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Top, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(2.5, -0.6, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Top, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -0.6, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Top, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-2.5, -0.6, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Left, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-3.65, -1.75, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Right, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(3.65, -1.75, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Front, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(2.5, -1.75, -3.15))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Front, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-2.5, -1.75, -3.15))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Back, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(2.5, -1.75, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Back, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.75, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Back, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-2.5, -1.75, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Left, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-1.15, -1.75, -4.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Right, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(1.15, -1.75, -4.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Left, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-1.15, -1.75, -6.75))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Right, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(1.15, -1.75, -6.75))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Top, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -0.6, -4.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Top, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -0.6, -6.75))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Bottom, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -2.9, -4.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(bigpenisId, Enum.NormalId.Bottom, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -2.9, -6.75))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Left, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-1.15, -1.75, -9))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Right, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(1.15, -1.75, -9))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Top, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -0.6, -9))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Bottom, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -2.9, -9))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Front, 2.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.75, -10.15))
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "Big Penis", Default = false })

Toggle:OnChanged(function(allowbigpenis)
    if allowbigpenis then
        allowbigpenisloop = true
        while allowbigpenisloop do
            local function allowbigpenisloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, player in pairs(Players:GetPlayers()) do
                        allowbigpenistarget = Players:FindFirstChild(player.Name)
                        if allowbigpenistarget then
                            allowbigpenisfunc()
                            task.wait()
                        end
                    end
                else
                    allowbigpenistarget = Players:FindFirstChild(infinityGauntlet)
                    if allowbigpenistarget then
                        allowbigpenisfunc()
                    end
                end
                task.wait(15)
            end
            wait()
            pcall(allowbigpenisloopfix)
        end
    else
        allowbigpenisloop = false
    end
end)

local Input = Tabs.Premium:AddInput("Input", {
    Title = "ID",
    Default = tostring(bigpenisId),
    Placeholder = "Enter Spray ID",
    Numeric = true, -- Only allows numbers
    Finished = false, -- Only calls callback when you press enter
    Callback = function(Value)
        bigpenisId = tonumber(Value) or bigpenisId
        print("Spray ID changed:", bigpenisId)
    end
})

Input:OnChanged(function()
    bigpenisId = tonumber(Input.Value) or bigpenisId
    print("Spray ID updated:", bigpenisId)
end)

Options.MyToggle:SetValue(false)
