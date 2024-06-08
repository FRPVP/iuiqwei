local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local djiwbdjksbbxkzplayerloop = false

function djiwbdjksbbxkzplayerfunc(djiwbdjksbbxkzplayertarget)
LocalPlayer.Character.SprayPaint.Remote:FireServer(14976845153, Enum.NormalId.Front, 1.5, (djiwbdjksbbxkzplayertarget.Character.HumanoidRootPart), djiwbdjksbbxkzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.15,-2.90))
end

local function startLoop()
    while djiwbdjksbbxkzplayerloop do
        EquipSpray()
        task.wait(0.4)
        if fetargetname == "All" then
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
