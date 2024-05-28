function djiwbdjksbbxkzplayerfunc(djiwbdjksbbxkzplayertarget)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14976845153, Enum.NormalId.Front, 1.5, (djiwbdjksbbxkzplayertarget.Character.HumanoidRootPart), djiwbdjksbbxkzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.15,-2.90))
end

local djiwbdjksbbxkzplayerloop = false

tab:toggle({
    Name = "Cum On Penis",
		StartingState = false,
		Description = "Spraypaint Toy Required",
		Callback = function(Value)
   if Value == true then
        djiwbdjksbbxkzplayerloop = true
        while djiwbdjksbbxkzplayerloop do
            EquipSpray()
            task.wait(0.4)
            if infinityGauntlet == "All" then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then -- Skip executing the function on yourself
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
            task.wait(15)
        end
    end
    if Value == false then
        djiwbdjksbbxkzplayerloop = false
    end
end,})
