local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
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
