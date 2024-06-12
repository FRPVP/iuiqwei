local ncnzksnkaslplayerloop = false

function ncnzksnkaslplayerfunc(ncnzksnkaslplayertarget)
LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 2048, ncnzksnkaslplayertarget.Character.RightHand, ncnzksnkaslplayertarget.Character.RightHand.CFrame * CFrame.new(0, 0, 0))
end

local function startLoop()
    while ncnzksnkaslplayerloop do
        EquipSpray()
        task.wait(0.4)
        if fetargetname == "All" then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer then -- Skip executing the function on yourself
                    local ncnzksnkaslplayertarget = v
                    ncnzksnkaslplayerfunc(ncnzksnkaslplayertarget)
                    task.wait()
                end
            end
        else
            local ncnzksnkaslplayertarget = findPlayerByName(fetargetname)
            if ncnzksnkaslplayertarget then
                ncnzksnkaslplayerfunc(ncnzksnkaslplayertarget)
            else
                print("Player not found.")
            end
        end
        task.wait(0)
    end
end

local function onCharacterAdded(character)
    if ncnzksnkaslplayerloop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Test",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(ncnzksnkaslplayer)
        ncnzksnkaslplayerloop = ncnzksnkaslplayer
        if ncnzksnkaslplayer then
            task.spawn(startLoop)
        end
    end,
})
