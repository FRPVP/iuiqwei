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
