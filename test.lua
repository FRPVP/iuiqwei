function bnmbnbbplayerfunc(bnmbnbbplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Front, 10000, bnmbnbbplayertarget.Character.LeftLowerArm, bnmbnbbplayertarget.Character.LeftLowerArm.CFrame * CFrame.new(0, 0, -1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Front, 10000, bnmbnbbplayertarget.Character.RightLowerArm, bnmbnbbplayertarget.Character.RightLowerArm.CFrame * CFrame.new(0, 0, -1))
end

local bnmbnbbplayerloop = false

tab:toggle({
    Name = "Slick Back",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        bnmbnbbplayerloop = true
        while bnmbnbbplayerloop do
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
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
            task.wait(15)
        end
    end
    if Value == false then
        bnmbnbbplayerloop = false
    end
end,})
