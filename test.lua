local Players = game:GetService("Players")
local boxId = 60484593

local function boxsprayOnPlayer(target)
    local localPlayer = Players.LocalPlayer
    if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local humanoidRootPart = target.Character.HumanoidRootPart

    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Front, 5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 5, 0))
end

local boxsprayLoop = false

tab:toggle({
    Name = "Box",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(Value)
        if Value then
            boxsprayLoop = true
            while boxsprayLoop do
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player ~= Players.LocalPlayer then -- Skip executing the function on yourself
                            boxsprayOnPlayer(player)
                            task.wait()
                        end
                    end
                else
                    local targetPlayer = findPlayerByName(infinityGauntlet)
                    if targetPlayer then
                        boxsprayOnPlayer(targetPlayer)
                    else
                        print("Player not found.")
                    end
                end
                task.wait(15)
            end
        else
            boxsprayLoop = false
        end
    end
})

tab:textbox({
    Name = "Custom Box ID",
    Callback = function(Value)
        boxId = tonumber(Value) or boxId
    end
})
