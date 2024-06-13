local sprayId = 60484593
local sprayLoop = false

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
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -2.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -2.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -2.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -2.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.15, -2.65))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1.15, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1.3, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.65, -1.15, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1.15, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1.3, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.65, -1.15, -0.7))
LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
	localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -2.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -2.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -2.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -2.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.15, -2.65))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1.15, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1.3, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.65, -1.15, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1.15, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1.3, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.65, -1.15, -0.7))
LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif LocalPlayer.Character:FindFirstChild("SprayPaint") then
	localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1, -2.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.3, -2.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.15, -1.15, -2.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -0.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -1))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -1.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -2))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.15, -1.15, -2.5))
    localPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0, -1.15, -2.65))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1.15, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.5, -1.3, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Right, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(0.65, -1.15, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Top, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Front, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1.15, -0.85))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Bottom, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.5, -1.3, -0.7))
    localPlayer.Character.SprayPaint.Remote:FireServer(sprayId, Enum.NormalId.Left, 0.5, humanoidRootPart, humanoidRootPart.CFrame * CFrame.new(-0.65, -1.15, -0.7))
	
end
end

local function startSprayLoop()
    while sprayLoop do
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
    if sprayLoop then
        task.spawn(startSprayLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Penis",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(Value)
        sprayLoop = Value
        if Value then
            task.spawn(startSprayLoop)
        end
    end,
})
