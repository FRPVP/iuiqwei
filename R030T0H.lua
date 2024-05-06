function aiwudnplayerfunc(aiwudnplayertarget)
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Back, 6.331, (aiwudnplayertarget.Character.HumanoidRootPart), aiwudnplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 99999, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Back, 6.331, (aiwudnplayertarget.Character.RightHand), aiwudnplayertarget.Character.RightHand.CFrame * CFrame.new(0, 99999, 0))
end

Tabs.Premium:AddButton({
    Title = "testing",
    Description = "",
    Icon = "", -- Replace "icon.png" with the path to your icon file
    Callback = function()
        -- Check if a name is selected
        if fetargetname == "All" then
            EquipSpray() -- Equip the spray first
            -- Iterate over all players and execute aiwudnplayerfunc on each player except yourself
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player ~= game:GetService("Players").LocalPlayer then
                    aiwudnplayerfunc(player)
                end
            end
        elseif fetargetname ~= "" then
            EquipSpray() -- Equip the spray first
            -- Find the player with the selected name
            local aiwudnplayertarget = game:GetService("Players"):FindFirstChild(fetargetname)
            if aiwudnplayertarget then
                aiwudnplayerfunc(aiwudnplayertarget) -- Execute aiwudnplayerfunc on the player
            else
                print("Player not found.")
            end
        else
            print("Please select a name from the dropdown.")
        end
    end
})
