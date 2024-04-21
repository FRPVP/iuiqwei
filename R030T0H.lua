local Stipid = 13850207336
local Sbaseid = 12976059241

local function sprayPaint()
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local posOfPlayer = player.Character.HumanoidRootPart.CFrame

            if game.Players.LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
                local sprayPaintObject = game.Players.LocalPlayer.Backpack.SprayPaint

                sprayPaintObject.Parent = game.Players.LocalPlayer.Character

                local remote = game.Players.LocalPlayer.Character.SprayPaint.Remote

                remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, posOfPlayer * CFrame.new(0, -1, -0.7))
                remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, posOfPlayer * CFrame.new(0, -1, -1))
                remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, posOfPlayer * CFrame.new(0, -1, -1.5))
                remote:FireServer(Sbaseid, Enum.NormalId.Top, 0.5, posOfPlayer * CFrame.new(0, -1, -2))
                remote:FireServer(Stipid, Enum.NormalId.Top, 0.5, posOfPlayer * CFrame.new(0, -1, -2.5))

                -- Add more fire server calls for different directions if needed
            end
        end
    end
end

-- Call the sprayPaint function directly
sprayPaint()
