local mxcnvsodiooowoloop = false

function mxcnvsodiooowofunc(mxcnvsodiooowotarget)
    if mxcnvsodiooowotarget.Character and mxcnvsodiooowotarget.Character:FindFirstChild("Knife") and mxcnvsodiooowotarget.Character:FindFirstChildOfClass("Tool") == mxcnvsodiooowotarget.Character.Knife then
        if LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
            Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
            LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
            LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 5, mxcnvsodiooowotarget.Character.Knife.Handle, mxcnvsodiooowotarget.Character.Knife.Handle.CFrame * CFrame.new(0, 0, 0))
            LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        elseif LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
            LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
            LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 5, mxcnvsodiooowotarget.Character.Knife.Handle, mxcnvsodiooowotarget.Character.Knife.Handle.CFrame * CFrame.new(0, 0, 0))
            LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        elseif LocalPlayer.Character:FindFirstChild("SprayPaint") then
            LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 5, mxcnvsodiooowotarget.Character.Knife.Handle, mxcnvsodiooowotarget.Character.Knife.Handle.CFrame * CFrame.new(0, 0, 0))
        end
    end
end

local function startLoop()
    while mxcnvsodiooowoloop do
        task.wait(0.4)
        if fetargetname == "All" then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= LocalPlayer then -- Skip executing the function on yourself
                    local mxcnvsodiooowotarget = v
                    mxcnvsodiooowofunc(mxcnvsodiooowotarget)
                    task.wait(0.1) -- Added a small delay to handle multiple players properly
                end
            end
        else
            local mxcnvsodiooowotarget = findPlayerByName(fetargetname)
            if mxcnvsodiooowotarget then
                mxcnvsodiooowofunc(mxcnvsodiooowotarget)
            else
                print("Player not found.")
            end
        end
        task.wait(0)
    end
end

local function onCharacterAdded(character)
    if mxcnvsodiooowoloop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "test",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(mxcnvsodiooowo)
        mxcnvsodiooowoloop = mxcnvsodiooowo
        if mxcnvsodiooowo then
            task.spawn(startLoop)
        end
    end,
})



local qwiueyiuioppppwloop = false

function qwiueyiuioppppwfunc(qwiueyiuioppppwtarget)
    if qwiueyiuioppppwtarget.Character and qwiueyiuioppppwtarget.Character:FindFirstChild("Gun") and qwiueyiuioppppwtarget.Character:FindFirstChildOfClass("Tool") == qwiueyiuioppppwtarget.Character.Gun then
        if LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
            Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
            LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
            LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 5, qwiueyiuioppppwtarget.Character.Gun.Handle, qwiueyiuioppppwtarget.Character.Gun.Handle.CFrame * CFrame.new(0, 0, 0))
            LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        elseif LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
            LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
            LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 5, qwiueyiuioppppwtarget.Character.Gun.Handle, qwiueyiuioppppwtarget.Character.Gun.Handle.CFrame * CFrame.new(0, 0, 0))
            LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
        elseif LocalPlayer.Character:FindFirstChild("SprayPaint") then
            LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 5, qwiueyiuioppppwtarget.Character.Gun.Handle, qwiueyiuioppppwtarget.Character.Gun.Handle.CFrame * CFrame.new(0, 0, 0))
        end
    end
end

local function startLoop()
    while qwiueyiuioppppwloop do
        task.wait(0.4)
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= LocalPlayer then -- Skip executing the function on yourself
                if v.Character and v.Character:FindFirstChild("Gun") then
                    qwiueyiuioppppwfunc(v)
                    task.wait(0.1) -- Added a small delay to handle multiple players properly
                end
            end
        end
        task.wait(0)
    end
end

local function onCharacterAdded(character)
    if qwiueyiuioppppwloop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "Block Gun",
    StartingState = false,
    Description = "Similar to Break Gun, but you have the ability to un-break it",
    Callback = function(qwiueyiuioppppw)
        qwiueyiuioppppwloop = qwiueyiuioppppw
        if qwiueyiuioppppw then
            task.spawn(startLoop)
        end
    end,
})
