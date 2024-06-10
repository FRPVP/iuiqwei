local poolplayerloop = false

function poolplayerfunc(poolplayertarget)
    LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Top, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
    LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Bottom, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
    LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Bottom, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
    LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Top, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0))
    LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Front, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
    LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Back, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
    LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Front, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
    LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Back, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
    LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Right, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
    LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Left, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
    LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Right, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
    LocalPlayer.Character.SprayPaint.Remote:FireServer(60484593, Enum.NormalId.Left, 32, poolplayertarget.Character.HumanoidRootPart, poolplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
end

local function startLoop()
    while poolplayerloop do
        EquipSpray()
        task.wait(0.4)
        if fetargetname == "All" then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer then -- Skip executing the function on yourself
                    local poolplayertarget = v
                    poolplayerfunc(poolplayertarget)
                    task.wait()
                end
            end
        else
            local poolplayertarget = findPlayerByName(fetargetname)
            if poolplayertarget then
                poolplayerfunc(poolplayertarget)
            else
                print("Player not found.")
            end
        end
        task.wait(15)
    end
end

local function onCharacterAdded(character)
    if poolplayerloop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Blind",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(poolplayer)
        poolplayerloop = poolplayer
        if poolplayer then
            task.spawn(startLoop)
        end
    end,
})
