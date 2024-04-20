Ssprayid = 60484593
local isScriptSpruce = true -- Set the initial state to true

while isScriptSpruce do
    if game.Players.LocalPlayer.Character ~= nil then
        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") then
                local torso = v.Character:FindFirstChild("Torso") or v.Character:FindFirstChild("UpperTorso")
                if torso then
                    local posofpl = torso.CFrame
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Top, 32, torso, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Bottom, 32, torso, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Left, 32, torso, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Right, 32, torso, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Front, 32, torso, posofpl)
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(Ssprayid, Enum.NormalId.Back, 32, torso, posofpl)
                end
            end
        end
    end
    wait(15.5)
end
