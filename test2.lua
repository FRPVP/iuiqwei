local djiwbdjksbbxkzplayerloop = false

function djiwbdjksbbxkzplayerfunc(djiwbdjksbbxkzplayertarget)
	    if LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
    LocalPlayer.Character.SprayPaint.Remote:FireServer(14976845153, Enum.NormalId.Front, 1.5, (djiwbdjksbbxkzplayertarget.Character.HumanoidRootPart), djiwbdjksbbxkzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.15,-2.90))
		LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
		LocalPlayer.Character.SprayPaint.Remote:FireServer(14976845153, Enum.NormalId.Front, 1.5, (djiwbdjksbbxkzplayertarget.Character.HumanoidRootPart), djiwbdjksbbxkzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.15,-2.90))
		LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif LocalPlayer.Character:FindFirstChild("SprayPaint") then
		LocalPlayer.Character.SprayPaint.Remote:FireServer(14976845153, Enum.NormalId.Front, 1.5, (djiwbdjksbbxkzplayertarget.Character.HumanoidRootPart), djiwbdjksbbxkzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.15,-2.90))
end
end

local function startLoop()
    while djiwbdjksbbxkzplayerloop do
        task.wait(0.4)
        if infinityGauntlet == "All" then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer then -- Skip executing the function on yourself
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
        task.wait(0)
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
