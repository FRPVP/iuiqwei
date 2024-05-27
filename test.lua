function jadoiwanplayerfunc(jadoiwanplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Back, 2048, jadoiwanplayertarget.Character.LeftHand, jadoiwanplayertarget.Character.LeftHand.CFrame * CFrame.new(0, 30, 0))
end

local jadoiwanplayerloop = false

tab:toggle({
    Name = "Freeze",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        jadoiwanplayerloop = true
        while jadoiwanplayerloop do
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local jadoiwanplayertarget = v
                        jadoiwanplayerfunc(jadoiwanplayertarget)
                        task.wait()
                    end
                end
            else
                local jadoiwanplayertarget = findPlayerByName(fetargetname)
                if jadoiwanplayertarget then
                    jadoiwanplayerfunc(jadoiwanplayertarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(15)
        end
    end
    if Value == false then
        jadoiwanplayerloop = false
    end
end,})
