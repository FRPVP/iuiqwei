local qweqqwwplayerloop = false

function qweqqwwplayerfunc(qweqqwwplayertarget)
    if qweqqwwplayertarget.Character and qweqqwwplayertarget.Character:FindFirstChild("Gun") and qweqqwwplayertarget.Character:FindFirstChildOfClass("Tool") == qweqqwwplayertarget.Character.Gun then
        if LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
            Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
            LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
            LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 15, qweqqwwplayertarget.Character.Gun.Handle, qweqqwwplayertarget.Character.Gun.Handle.CFrame * CFrame.new(0, 0, 0))
            LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        elseif LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
            LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
            LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 15, qweqqwwplayertarget.Character.Gun.Handle, qweqqwwplayertarget.Character.Gun.Handle.CFrame * CFrame.new(0, 0, 0))
            LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        elseif LocalPlayer.Character:FindFirstChild("SprayPaint") then
            LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 15, qweqqwwplayertarget.Character.Gun.Handle, qweqqwwplayertarget.Character.Gun.Handle.CFrame * CFrame.new(0, 0, 0))
        end
    end
end

local function startLoop()
    while qweqqwwplayerloop do
        task.wait(0.4)
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= LocalPlayer then -- Skip executing the function on yourself
                if v.Character and v.Character:FindFirstChild("Gun") then
                    qweqqwwplayerfunc(v)
                    task.wait(0.1) -- Added a small delay to handle multiple players properly
                end
            end
        end
        task.wait(0)
    end
end

local function onCharacterAdded(character)
    if qweqqwwplayerloop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "test",
    StartingState = false,
    Description = "",
    Callback = function(qweqqwwplayer)
        qweqqwwplayerloop = qweqqwwplayer
        if qweqqwwplayer then
            task.spawn(startLoop)
        end
    end,
})
