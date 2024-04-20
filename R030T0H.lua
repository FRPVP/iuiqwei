Ssprayid = 60484593

-- Function to execute the spray paint effects
local function sprayPaintAll()
    while true do
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local posofpl = v.Character.HumanoidRootPart.CFrame
                
                -- Apply spray paint effects to different parts of the player's character
                for _, normalId in pairs(Enum.NormalId:GetEnumItems()) do
                    game.Players.LocalPlayer.Character.SprayPaint.Parent = game.Players.LocalPlayer.Backpack
                    game.Players.LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
                    game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, normalId, 32, v.Character.HumanoidRootPart, posofpl * CFrame.new(math.random(-3, 3), math.random(-3, 3), math.random(-3, 3)))
                end
            end
        end
        wait(15.5) -- Wait for 15.5 seconds before repeating
    end
end

-- Call the function to start spraying paint
sprayPaintAll()
