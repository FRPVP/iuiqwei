local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
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
