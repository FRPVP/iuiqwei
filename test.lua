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
