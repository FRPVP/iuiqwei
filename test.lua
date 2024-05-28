function qweqqwwplayerfunc(qweqqwwplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Front, 8, qweqqwwplayertarget.Character.Head, qweqqwwplayertarget.Character.Head.CFrame * CFrame.new(0, 1.5, 0))
end

local qweqqwwplayerloop = false

tab:toggle({
    Name = "Shake Camera",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        qweqqwwplayerloop = true
        while qweqqwwplayerloop do
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local qweqqwwplayertarget = v
                        qweqqwwplayerfunc(qweqqwwplayertarget)
                        task.wait()
                    end
                end
            else
                local qweqqwwplayertarget = findPlayerByName(fetargetname)
                if qweqqwwplayertarget then
                    qweqqwwplayerfunc(qweqqwwplayertarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(15)
        end
    end
    if Value == false then
        qweqqwwplayerloop = false
    end
end,})
