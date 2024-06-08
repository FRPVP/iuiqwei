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
