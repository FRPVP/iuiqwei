local tagId = 60484593
local tagsprayLoop = false

local function sprayOnPlayer(target)
    local localPlayer = Players.LocalPlayer
    if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local humanoidRootPart = target.Character.HumanoidRootPart

	if LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
    localPlayer.Character.SprayPaint.Remote:FireServer(tagId, Enum.NormalId.Front, 5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 5, 0))
LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
    localPlayer.Character.SprayPaint.Remote:FireServer(tagId, Enum.NormalId.Front, 5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 5, 0))
LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif LocalPlayer.Character:FindFirstChild("SprayPaint") then
    localPlayer.Character.SprayPaint.Remote:FireServer(tagId, Enum.NormalId.Front, 5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 5, 0))
	
end
end

local function starttagsprayLoop()
    while tagsprayLoop do
        task.wait(0.4)
        if infinityGauntlet == "All" then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer then -- Skip executing the function on yourself
                    sprayOnPlayer(player)
                    task.wait()
                end
            end
        else
            local targetPlayer = findPlayerByName(infinityGauntlet)
            if targetPlayer then
                sprayOnPlayer(targetPlayer)
            else
                print("Player not found.")
            end
        end
        task.wait(15)
    end
end

local function onCharacterAdded(character)
    if tagsprayLoop then
        task.spawn(starttagsprayLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Tag",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(Value)
        tagsprayLoop = Value
        if Value then
            task.spawn(starttagsprayLoop)
        end
    end,
})
