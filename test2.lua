function zxnjckskooplayerfunc(zxnjckskooplayertarget)
    if LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 2048, zxnjckskooplayertarget.Character.LeftHand, zxnjckskooplayertarget.Character.LeftHand.CFrame * CFrame.new(0, 0, 0))
        LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
         LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 2048, zxnjckskooplayertarget.Character.LeftHand, zxnjckskooplayertarget.Character.LeftHand.CFrame * CFrame.new(0, 0, 0))
        LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif LocalPlayer.Character:FindFirstChild("SprayPaint") then
         LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 2048, zxnjckskooplayertarget.Character.LeftHand, zxnjckskooplayertarget.Character.LeftHand.CFrame * CFrame.new(0, 0, 0))
end
end

tab:button({
    Name = "Freeze",
    Description = "Spraypaint Toy Required",
    Callback = function()
        if fetargetname == "All" then
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                zxnjckskooplayerfunc(player)
            end
        end
    elseif fetargetname ~= "" then
        local zxnjckskooplayertarget = findPlayerByName(fetargetname)
        if zxnjckskooplayertarget then
            zxnjckskooplayerfunc(zxnjckskooplayertarget) -- Execute zxnjckskooplayerfunc on the player
        else
            print("Player not found.")
        end
    else
        print("Please select a name from the dropdown.")
    end
    end,
})
