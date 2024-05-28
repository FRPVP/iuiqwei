local Players = game:GetService("Players")
local tagId = 60484593

local function tagsprayOnPlayer(target)
    local localPlayer = Players.LocalPlayer
    if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local humanoidRootPart = target.Character.HumanoidRootPart

    localPlayer.Character.SprayPaint.Remote:FireServer(tagId, Enum.NormalId.Front, 5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 5, 0))
end

local tagsprayLoop = false

tab:toggle({
    Name = "Tag",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(Value)
        if Value then
            tagsprayLoop = true
            while tagsprayLoop do
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player ~= Players.LocalPlayer then -- Skip executing the function on yourself
                            tagsprayOnPlayer(player)
                            task.wait()
                        end
                    end
                else
                    local targetPlayer = findPlayerByName(infinityGauntlet)
                    if targetPlayer then
                        tagsprayOnPlayer(targetPlayer)
                    else
                        print("Player not found.")
                    end
                end
                task.wait(15)
            end
        else
            tagsprayLoop = false
        end
    end
})

tab:textbox({
    Name = "Custom Tag ID",
    Callback = function(Value)
        tagId = tonumber(Value) or tagId
    end
})
