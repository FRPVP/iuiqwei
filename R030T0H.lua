function funnyplayerfunc(funnyplayertarget)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(10193511157, Enum.NormalId.Front, 1.5, (funnyplayertarget.Character.HumanoidRootPart), funnyplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,1.2,-1))
end

Tabs.Premium:AddButton({
    Title = "Troll Face (15sec)",
    Description = "",
    Icon = "", -- Replace "icon.png" with the path to your icon file
    Callback = function()
        -- Check if a name is selected
        if fetargetname == "All" then
            EquipSpray() -- Equip the spray first
            -- Iterate over all players and execute funnyplayerfunc on each player except yourself
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player ~= game:GetService("Players").LocalPlayer then
                    funnyplayerfunc(player)
                end
            end
        elseif fetargetname ~= "" then
            EquipSpray() -- Equip the spray first
            -- Find the player with the selected name
            local funnyplayertarget = game:GetService("Players"):FindFirstChild(fetargetname)
            if funnyplayertarget then
                funnyplayerfunc(funnyplayertarget) -- Execute funnyplayerfunc on the player
            else
                print("Player not found.")
            end
        else
            print("Please select a name from the dropdown.")
        end
    end
})
