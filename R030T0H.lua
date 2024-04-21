for _, player in ipairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local posOfPenis = player.Character.HumanoidRootPart.CFrame

        -- Spray painting the penis on all sides
        for _, normalId in ipairs(Enum.NormalId:GetEnumItems()) do
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
            game.Players.LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character

            -- Top Penis
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1,-0.7))
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1,-1)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1,-1.5)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1,-2)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Top, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1,-2.5)) 
                
            -- Bottom Penis
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1.3,-0.5)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1.3,-1))
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1.3,-1.5)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1.3,-2)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Bottom, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1.3,-2.5)) 

            -- Left Penis
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.15,-1.15,-0.5)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.15,-1.15,-1)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.15,-1.15,-1.5)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.15,-1.15,-2)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Left, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.15,-1.15,-2.5)) 

            -- Right Penis
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.15,-1.15,-0.5)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.15,-1.15,-1)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.15,-1.15,-1.5)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.15,-1.15,-2)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Right, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.15,-1.15,-2.5)) 
                
            -- Front Penis
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Front, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1.15,-2.65)) 
                
            -- Left Sack
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.5,-1,-0.7)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Front, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.5,-1.15,-0.85)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.5,-1.3,-0.7)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.65,-1.15,-0.7)) 
                
            -- Right side
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.5,-1,-0.7)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Front, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.5,-1.15,-0.85)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.5,-1.3,-0.7)) 
            game.Players.LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.65,-1.15,-0.7)) 
        end
    end
end

-- Unequip the Spraypaint tool
game.Players.LocalPlayer.Character.SprayPaint.Parent = game.Players.LocalPlayer.Backpack
