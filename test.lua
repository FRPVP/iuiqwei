local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local resetplayerloop = false

function resetplayerfunc(resetplayertarget)
    LocalPlayer.Character.SprayPaint.Remote:FireServer(80373024, Enum.NormalId.Back, 15, resetplayertarget.Character.Head, resetplayertarget.Character.Head.CFrame * CFrame.new(0, math.huge, 0))
end

local function startLoop()
    while resetplayerloop do
        EquipSpray()
        task.wait(0.4)
        if fetargetname == "All" then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer then -- Skip executing the function on yourself
                    local resetplayertarget = v
                    resetplayerfunc(resetplayertarget)
                    task.wait()
                end
            end
        else
            local resetplayertarget = findPlayerByName(fetargetname)
            if resetplayertarget then
                resetplayerfunc(resetplayertarget)
            else
                print("Player not found.")
            end
        end
        task.wait(0)
    end
end

local function onCharacterAdded(character)
    if resetplayerloop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Loop Reset",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(resetplayer)
        resetplayerloop = resetplayer
        if resetplayer then
            task.spawn(startLoop)
        end
    end,
})



local collideplayerloop = false

function collideplayerfunc(collideplayertarget)
    LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Back, 6.331, collideplayertarget.Character.HumanoidRootPart, collideplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 99999, 0))
end

local function startLoop()
    while collideplayerloop do
        EquipSpray()
        task.wait(0.4)
        if fetargetname == "All" then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer then -- Skip executing the function on yourself
                    local collideplayertarget = v
                    collideplayerfunc(collideplayertarget)
                    task.wait()
                end
            end
        else
            local collideplayertarget = findPlayerByName(fetargetname)
            if collideplayertarget then
                collideplayerfunc(collideplayertarget)
            else
                print("Player not found.")
            end
        end
        task.wait(15)
    end
end

local function onCharacterAdded(character)
    if collideplayerloop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Remove Collisions",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(collideplayer)
        collideplayerloop = collideplayer
        if collideplayer then
            task.spawn(startLoop)
        end
    end,
})



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



local fesliploop = false

function feslipfunc(fesliptarget)
    LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, fesliptarget.Character.LeftUpperLeg, fesliptarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -2, 0))
    LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, fesliptarget.Character.LeftUpperLeg, fesliptarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -2, 0))
end

local function startLoop()
    while fesliploop do
        EquipSpray()
        task.wait(0.4)
        if fetargetname == "All" then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer then -- Skip executing the function on yourself
                    local fesliptarget = v
                    feslipfunc(fesliptarget)
                    task.wait()
                end
            end
        else
            local fesliptarget = findPlayerByName(fetargetname)
            if fesliptarget then
                feslipfunc(fesliptarget)
            else
                print("Player not found.")
            end
        end
        task.wait(15)
    end
end

local function onCharacterAdded(character)
    if fesliploop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Slip Up",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(feslip)
        fesliploop = feslip
        if feslip then
            task.spawn(startLoop)
        end
    end,
})



local opiwhdaplayerloop = false

function opiwhdaplayerfunc(opiwhdaplayertarget)
   LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Back, 6.331, opiwhdaplayertarget.Character.HumanoidRootPart, opiwhdaplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 99999, 0))
    LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, opiwhdaplayertarget.Character.LeftUpperLeg, opiwhdaplayertarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -100, 0))
    LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, opiwhdaplayertarget.Character.LeftUpperLeg, opiwhdaplayertarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -100, 0))
end

local function startLoop()
    while opiwhdaplayerloop do
        EquipSpray()
        task.wait(0.4)
        if fetargetname == "All" then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer then -- Skip executing the function on yourself
                    local opiwhdaplayertarget = v
                    opiwhdaplayerfunc(opiwhdaplayertarget)
                    task.wait()
                end
            end
        else
            local opiwhdaplayertarget = findPlayerByName(fetargetname)
            if opiwhdaplayertarget then
                opiwhdaplayerfunc(opiwhdaplayertarget)
            else
                print("Player not found.")
            end
        end
        task.wait(0)
    end
end

local function onCharacterAdded(character)
    if opiwhdaplayerloop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Void",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(opiwhdaplayer)
        opiwhdaplayerloop = opiwhdaplayer
        if opiwhdaplayer then
            task.spawn(startLoop)
        end
    end,
})



local jadoiwanplayerloop = false

function jadoiwanplayerfunc(jadoiwanplayertarget)
  LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 2048, jadoiwanplayertarget.Character.LeftHand, jadoiwanplayertarget.Character.LeftHand.CFrame * CFrame.new(0, 0, 0))
end

local function startLoop()
    while jadoiwanplayerloop do
        EquipSpray()
        task.wait(0.4)
        if fetargetname == "All" then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer then -- Skip executing the function on yourself
                    local jadoiwanplayertarget = v
                    jadoiwanplayerfunc(jadoiwanplayertarget)
                    task.wait()
                end
            end
        else
            local jadoiwanplayertarget = findPlayerByName(fetargetname)
            if jadoiwanplayertarget then
                jadoiwanplayerfunc(jadoiwanplayertarget)
            else
                print("Player not found.")
            end
        end
        task.wait(0)
    end
end

local function onCharacterAdded(character)
    if jadoiwanplayerloop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Freeze",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(jadoiwanplayer)
        jadoiwanplayerloop = jadoiwanplayer
        if jadoiwanplayer then
            task.spawn(startLoop)
        end
    end,
})



local andlxcaosplayerloop = false

function andlxcaosplayerfunc(andlxcaosplayertarget)
  LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Right, 2048, andlxcaosplayertarget.Character.HumanoidRootPart, andlxcaosplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 250, 0))
end

local function startLoop()
    while andlxcaosplayerloop do
        EquipSpray()
        task.wait(0.4)
        if fetargetname == "All" then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer then -- Skip executing the function on yourself
                    local andlxcaosplayertarget = v
                    andlxcaosplayerfunc(andlxcaosplayertarget)
                    task.wait()
                end
            end
        else
            local andlxcaosplayertarget = findPlayerByName(fetargetname)
            if andlxcaosplayertarget then
                andlxcaosplayerfunc(andlxcaosplayertarget)
            else
                print("Player not found.")
            end
        end
        task.wait(0)
    end
end

local function onCharacterAdded(character)
    if andlxcaosplayerloop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Lag",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(andlxcaosplayer)
        andlxcaosplayerloop = andlxcaosplayer
        if andlxcaosplayer then
            task.spawn(startLoop)
        end
    end,
})



local iopiipiopolllplayerloop = false

function iopiipiopolllplayerfunc(iopiipiopolllplayertarget)
  LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Front, 2500, iopiipiopolllplayertarget.Character.RightHand, iopiipiopolllplayertarget.Character.RightHand.CFrame * CFrame.new(0, -50, 0))
    LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Front, 2500, iopiipiopolllplayertarget.Character.RightHand, iopiipiopolllplayertarget.Character.RightHand.CFrame * CFrame.new(0, 50, 0))
end

local function startLoop()
    while iopiipiopolllplayerloop do
        EquipSpray()
        task.wait(0.4)
        if fetargetname == "All" then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer then -- Skip executing the function on yourself
                    local iopiipiopolllplayertarget = v
                    iopiipiopolllplayerfunc(iopiipiopolllplayertarget)
                    task.wait()
                end
            end
        else
            local iopiipiopolllplayertarget = findPlayerByName(fetargetname)
            if iopiipiopolllplayertarget then
                iopiipiopolllplayerfunc(iopiipiopolllplayertarget)
            else
                print("Player not found.")
            end
        end
        task.wait(15)
    end
end

local function onCharacterAdded(character)
    if iopiipiopolllplayerloop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Launch Up",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(iopiipiopolllplayer)
        iopiipiopolllplayerloop = iopiipiopolllplayer
        if iopiipiopolllplayer then
            task.spawn(startLoop)
        end
    end,
})



local qweqqwwplayerloop = false

function qweqqwwplayerfunc(qweqqwwplayertarget)
  LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Front, 8, qweqqwwplayertarget.Character.Head, qweqqwwplayertarget.Character.Head.CFrame * CFrame.new(0, 50.5, 0))
end

local function startLoop()
    while qweqqwwplayerloop do
        EquipSpray()
        task.wait(0.4)
        if fetargetname == "All" then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer then -- Skip executing the function on yourself
                    local qweqqwwplayertarget = v
                    qweqqwwplayerfunc(qweqqwwplayertarget)
                    task.wait()
                end
            end
        else
            local qweqqwwplayertarget = findPlayerByName(fetargetname)
            if qweqqwwplayertarget then
                qweqqwwplayerfunc(qweqqwwplayertarget)
            else
                print("Player not found.")
            end
        end
        task.wait(15)
    end
end

local function onCharacterAdded(character)
    if qweqqwwplayerloop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Shake",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(qweqqwwplayer)
        qweqqwwplayerloop = qweqqwwplayer
        if qweqqwwplayer then
            task.spawn(startLoop)
        end
    end,
})



local bnmbnbbplayerloop = false

function bnmbnbbplayerfunc(bnmbnbbplayertarget)
  LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Front, 10000, bnmbnbbplayertarget.Character.LeftLowerArm, bnmbnbbplayertarget.Character.LeftLowerArm.CFrame * CFrame.new(0, 0, -1))
    LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Front, 10000, bnmbnbbplayertarget.Character.RightLowerArm, bnmbnbbplayertarget.Character.RightLowerArm.CFrame * CFrame.new(0, 0, -1))
end

local function startLoop()
    while bnmbnbbplayerloop do
        EquipSpray()
        task.wait(0.4)
        if fetargetname == "All" then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer then -- Skip executing the function on yourself
                    local bnmbnbbplayertarget = v
                    bnmbnbbplayerfunc(bnmbnbbplayertarget)
                    task.wait()
                end
            end
        else
            local bnmbnbbplayertarget = findPlayerByName(fetargetname)
            if bnmbnbbplayertarget then
                bnmbnbbplayerfunc(bnmbnbbplayertarget)
            else
                print("Player not found.")
            end
        end
        task.wait(15)
    end
end

local function onCharacterAdded(character)
    if bnmbnbbplayerloop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Slick Movement",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(bnmbnbbplayer)
        bnmbnbbplayerloop = bnmbnbbplayer
        if bnmbnbbplayer then
            task.spawn(startLoop)
        end
    end,
})










local tab = gui:tab{
    Icon = "rbxassetid://17771510478",
    Name = "Art"
}

local infinityGauntlet = ""

tab:textbox({
Name = "Target User",
Description = "Type All to select all players",
    Callback = function(Value)
        infinityGauntlet = Value
    end
})



local asndzxnchajsplayerloop = false

function asndzxnchajsplayerfunc(asndzxnchajsplayertarget)
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 6, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 6, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 6, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 10, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 10, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 12, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 14, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 14, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 14, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 14, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 10, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 10, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 8, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(12781220539, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 6, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 8, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 8, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 8, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 6, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 12, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 12, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 12, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 14, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 4, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 4, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 4, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 4, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 4, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 4, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 4, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 6, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 8, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 10, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 12, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 14, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 16, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 6, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 8, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 10, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 12, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 14, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 16, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-6, 16, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 16, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 16, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 16, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 16, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(1302869037, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 16, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(6, 16, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 18, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 18, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 18, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 18, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 18, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-4, 2, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 2, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(2, 2, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(4, 2, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(8, 6, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(8, 8, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(8, 10, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(8, 12, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(8, 14, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-8, 6, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-8, 8, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-8, 10, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-8, 12, 0))
LocalPlayer.Character.SprayPaint.Remote:FireServer(14033250886, Enum.NormalId.Front, 2, (asndzxnchajsplayertarget.Character.HumanoidRootPart), asndzxnchajsplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(-8, 14, 0))
end

local function startLoop()
    while asndzxnchajsplayerloop do
        EquipSpray()
        task.wait(0.4)
        if infinityGauntlet == "All" then
            for _, v in pairs(Players:GetPlayers()) do
                    local asndzxnchajsplayertarget = v
                    asndzxnchajsplayerfunc(asndzxnchajsplayertarget)
                    task.wait()
                end
            end
        else
            local asndzxnchajsplayertarget = findPlayerByName(infinityGauntlet)
            if asndzxnchajsplayertarget then
                asndzxnchajsplayerfunc(asndzxnchajsplayertarget)
            else
                print("Player not found.")
            end
        end
        task.wait(15)
    end
end

local function onCharacterAdded(character)
    if asndzxnchajsplayerloop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Nazi",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(asndzxnchajsplayer)
        asndzxnchajsplayerloop = asndzxnchajsplayer
        if asndzxnchajsplayer then
            task.spawn(startLoop)
        end
    end,
})



local djiwbdjksbbxkzplayerloop = false

function djiwbdjksbbxkzplayerfunc(djiwbdjksbbxkzplayertarget)
LocalPlayer.Character.SprayPaint.Remote:FireServer(14976845153, Enum.NormalId.Front, 1.5, (djiwbdjksbbxkzplayertarget.Character.HumanoidRootPart), djiwbdjksbbxkzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.15,-2.90))
end

local function startLoop()
    while djiwbdjksbbxkzplayerloop do
        EquipSpray()
        task.wait(0.4)
        if infinityGauntlet == "All" then
            for _, v in pairs(Players:GetPlayers()) do
                    local djiwbdjksbbxkzplayertarget = v
                    djiwbdjksbbxkzplayerfunc(djiwbdjksbbxkzplayertarget)
                    task.wait()
                end
            end
        else
            local djiwbdjksbbxkzplayertarget = findPlayerByName(infinityGauntlet)
            if djiwbdjksbbxkzplayertarget then
                djiwbdjksbbxkzplayerfunc(djiwbdjksbbxkzplayertarget)
            else
                print("Player not found.")
            end
        end
        task.wait(15)
    end
end

local function onCharacterAdded(character)
    if djiwbdjksbbxkzplayerloop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Cum On Penis",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(djiwbdjksbbxkzplayer)
        djiwbdjksbbxkzplayerloop = djiwbdjksbbxkzplayer
        if djiwbdjksbbxkzplayer then
            task.spawn(startLoop)
        end
    end,
})


local sprayId = 60484593
local sprayLoop = false

local function sprayOnPlayer(target)
    
    if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local humanoidRootPart = target.Character.HumanoidRootPart

    -- Top Spray
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -2.5))

    -- Bottom Spray
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -2.5))

    -- Left Spray
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -2.5))

    -- Right Spray
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -2.5))

    -- Front Spray
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.15, -2.65))

    -- Left Sack
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1.15, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1.3, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.65, -1.15, -0.7))

    -- Right Sack
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1.15, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1.3, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.65, -1.15, -0.7))
end

local function startSprayLoop()
    while sprayLoop do
        EquipSpray()
        task.wait(0.4)
        if infinityGauntlet == "All" then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer then -- Skip executing the function on yourself
                    sprayOnPlayer(player)
                    task.wait()
                end
            end
        else
            local targetPlayer = findPlayerByName(infinityGauntlet)
            if targetPlayer then
                sprayOnPlayer(targetPlayer)
            else
                print("Player not found.")
            end
        end
        task.wait(15)
    end
end

local function onCharacterAdded(character)
    if sprayLoop then
        task.spawn(startSprayLoop)
    end
end

Players.LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Penis",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(Value)
        sprayLoop = Value
        if Value then
            task.spawn(startSprayLoop)
        end
    end,
})
