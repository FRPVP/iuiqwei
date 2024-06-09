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
        task.wait(0)
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
