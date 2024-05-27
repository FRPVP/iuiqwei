function opiwhdaplayerfunc(opiwhdaplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Back, 6.331, opiwhdaplayertarget.Character.HumanoidRootPart, opiwhdaplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 99999, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, opiwhdaplayertarget.Character.LeftUpperLeg, opiwhdaplayertarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -100, 0))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, opiwhdaplayertarget.Character.LeftUpperLeg, opiwhdaplayertarget.Character.LeftUpperLeg.CFrame * CFrame.new(0, -100, 0))
end

local opiwhdaplayerloop = false

tab:toggle({
    Name = "Void",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        opiwhdaplayerloop = true
        while opiwhdaplayerloop do
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
                        local opiwhdaplayertarget = v
                        opiwhdaplayerfunc(opiwhdaplayertarget)
                        task.wait()
                    end
                end
            else
                local opiwhdaplayertarget = findPlayerByName(fetargetname)
                if opiwhdaplayertarget then
                    opiwhdaplayerfunc(opiwhdaplayertarget)
                else
                    print("Player not found.")
                end
            end
            task.wait(0)
        end
    end
    if Value == false then
        opiwhdaplayerloop = false
    end
end,})
