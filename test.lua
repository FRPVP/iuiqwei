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
        task.wait(0)
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
