local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
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
