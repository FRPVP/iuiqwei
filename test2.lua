local ancoawpqjwejejjloop = false

function ancoawpqjwejejjfunc(ancoawpqjwejejjtarget)
	if LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, ancoawpqjwejejjtarget.Character.RightHand, ancoawpqjwejejjtarget.Character.RightHand.CFrame * CFrame.new(0, -2, 0))
LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
	LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, ancoawpqjwejejjtarget.Character.RightHand, ancoawpqjwejejjtarget.Character.RightHand.CFrame * CFrame.new(0, -2, 0))
LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif LocalPlayer.Character:FindFirstChild("SprayPaint") then
	LocalPlayer.Character.SprayPaint.Remote:FireServer(0, Enum.NormalId.Top, 6.331, ancoawpqjwejejjtarget.Character.RightHand, ancoawpqjwejejjtarget.Character.RightHand.CFrame * CFrame.new(0, -2, 0))
end
end

local function startLoop()
    while ancoawpqjwejejjloop do
        task.wait(0.4)
        if fetargetname == "All" then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer then -- Skip executing the function on yourself
                    local ancoawpqjwejejjtarget = v
                    ancoawpqjwejejjfunc(ancoawpqjwejejjtarget)
                    task.wait()
                end
            end
        else
            local ancoawpqjwejejjtarget = findPlayerByName(fetargetname)
            if ancoawpqjwejejjtarget then
                ancoawpqjwejejjfunc(ancoawpqjwejejjtarget)
            else
                print("Player not found.")
            end
        end
        task.wait(0)
    end
end

local function onCharacterAdded(character)
    if ancoawpqjwejejjloop then
        task.spawn(startLoop)
    end
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

tab:toggle({
    Name = "test",
    StartingState = false,
    Description = "Spraypaint Toy Required",
    Callback = function(ancoawpqjwejejj)
        ancoawpqjwejejjloop = ancoawpqjwejejj
        if ancoawpqjwejejj then
            task.spawn(startLoop)
        end
    end,
})
