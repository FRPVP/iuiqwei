function jadoiwanplayerfunc(jadoiwanplayertarget)
    if LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
    LocalPlayer.Character.SprayPaint.Remote:FireServer(80373024, Enum.NormalId.Back, 15, (jadoiwanplayertarget.Character.RightLowerLeg), jadoiwanplayertarget.Character.RightLowerLeg.CFrame * CFrame.new(0, 0, 0))
        LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
         LocalPlayer.Character.SprayPaint.Remote:FireServer(80373024, Enum.NormalId.Back, 15, (jadoiwanplayertarget.Character.RightLowerLeg), jadoiwanplayertarget.Character.RightLowerLeg.CFrame * CFrame.new(0, 0, 0))
        LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif LocalPlayer.Character:FindFirstChild("SprayPaint") then
         LocalPlayer.Character.SprayPaint.Remote:FireServer(80373024, Enum.NormalId.Back, 15, (jadoiwanplayertarget.Character.RightLowerLeg), jadoiwanplayertarget.Character.RightLowerLeg.CFrame * CFrame.new(0, 0, 0))
end
end

tab:button({
    Name = "test",
    Description = "Spraypaint Toy Required",
    Callback = function()
        if fetargetname == "All" then
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                jadoiwanplayerfunc(player)
            end
        end
    elseif fetargetname ~= "" then
        local jadoiwanplayertarget = findPlayerByName(fetargetname)
        if jadoiwanplayertarget then
            jadoiwanplayerfunc(jadoiwanplayertarget) -- Execute jadoiwanplayerfunc on the player
        else
            print("Player not found.")
        end
    else
        print("Please select a name from the dropdown.")
    end
    end,
})
