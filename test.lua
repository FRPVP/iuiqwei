function iopiipiopolllplayerfunc(iopiipiopolllplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Front, 2500, iopiipiopolllplayertarget.Character.RightHand, iopiipiopolllplayertarget.Character.RightHand.CFrame * CFrame.new(0, -25000, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Front, 2500, iopiipiopolllplayertarget.Character.RightHand, iopiipiopolllplayertarget.Character.RightHand.CFrame * CFrame.new(0, 25000, 0))
end

local iopiipiopolllplayerloop = false

tab:toggle({
    Name = "Floor Clip",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        iopiipiopolllplayerloop = true
        while iopiipiopolllplayerloop do
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local iopiipiopolllplayertarget = v
                        iopiipiopolllplayerfunc(iopiipiopolllplayertarget)
                        task.wait()
                    end
                end
            else
                local iopiipiopolllplayertarget = findPlayerByName(fetargetname)
                if iopiipiopolllplayertarget then
                    iopiipiopolllplayerfunc(iopiipiopolllplayertarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(15)
        end
    end
    if Value == false then
        iopiipiopolllplayerloop = false
    end
end,})
