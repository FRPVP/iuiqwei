function andlxcaosplayerfunc(andlxcaosplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Right, 2048, andlxcaosplayertarget.Character.HumanoidRootPart, andlxcaosplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 250, 0))
end

local andlxcaosplayerloop = false

tab:toggle({
    Name = "Lag",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        andlxcaosplayerloop = true
        while andlxcaosplayerloop do
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local andlxcaosplayertarget = v
                        andlxcaosplayerfunc(andlxcaosplayertarget)
                        task.wait()
                    end
                end
            else
                local andlxcaosplayertarget = findPlayerByName(fetargetname)
                if andlxcaosplayertarget then
                    andlxcaosplayerfunc(andlxcaosplayertarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(0)
        end
    end
    if Value == false then
        andlxcaosplayerloop = false
    end
end,})
