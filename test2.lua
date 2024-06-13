local boxId = 60484593
local boxsprayLoop = false

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
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Top, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 3, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Bottom, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Bottom, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Top, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -3, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Front, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Back, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Front, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Back, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Right, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Left, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Right, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Left, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Top, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 3, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Bottom, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Bottom, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Top, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -3, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Front, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Back, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Front, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Back, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Right, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Left, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Right, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Left, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif LocalPlayer.Character:FindFirstChild("SprayPaint") then
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Top, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 3, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Bottom, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 3.15, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Bottom, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -2.8, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Top, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -3, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Front, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 0.1, 3.1))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Back, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 0.1, 2.86))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Front, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 0.1, -2.86))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Back, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, 0.1, -3.1))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Right, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(2.86, 0.1, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Left, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(3.1, 0.1, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Right, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-3.1, 0.1, 0))
    localPlayer.Character.SprayPaint.Remote:FireServer(boxId, Enum.NormalId.Left, 6, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-2.86, 0.1, 0))
	
end
end

local function startboxsprayLoop()
    while boxsprayLoop do
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
    if boxsprayLoop then
        task.spawn(startboxsprayLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Box",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(Value)
        boxsprayLoop = Value
        if Value then
            task.spawn(startboxsprayLoop)
        end
    end,
})
