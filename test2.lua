local bnmbnbbplayerloop = false

function bnmbnbbplayerfunc(bnmbnbbplayertarget)
	    if LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
    LocalPlayer.Character.SprayPaint.Remote:FireServer(80373024, Enum.NormalId.Back, 15, bnmbnbbplayertarget.Character.RightHand, bnmbnbbplayertarget.Character.RightHand.CFrame * CFrame.new(0, 50, 0))
		LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
		LocalPlayer.Character.SprayPaint.Remote:FireServer(80373024, Enum.NormalId.Back, 15, bnmbnbbplayertarget.Character.RightHand, bnmbnbbplayertarget.Character.RightHand.CFrame * CFrame.new(0, 50, 0))
		LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif LocalPlayer.Character:FindFirstChild("SprayPaint") then
		LocalPlayer.Character.SprayPaint.Remote:FireServer(80373024, Enum.NormalId.Back, 15, bnmbnbbplayertarget.Character.RightHand, bnmbnbbplayertarget.Character.RightHand.CFrame * CFrame.new(0, 50, 0))
end
end

local function startLoop()
    while bnmbnbbplayerloop do
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
        task.wait(0)
    end
end

local function onCharacterAdded(character)
    if bnmbnbbplayerloop then
        task.spawn(startLoop)
    end
end

tab:toggle({
    Name = "Speed Glitch Player",
    StartingState = false,
    Description = "",
    Callback = function(bnmbnbbplayer)
        bnmbnbbplayerloop = bnmbnbbplayer
        if bnmbnbbplayer then
            task.spawn(startLoop)
        end
    end,
})
