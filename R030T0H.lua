for _, player in ipairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local posOfPenis = player.Character.HumanoidRootPart.CFrame

        -- Spray painting the penis on all sides
        for _, normalId in ipairs(Enum.NormalId:GetEnumItems()) do
            local sprayPaintTool = game.Players.LocalPlayer.Backpack:FindFirstChild("SprayPaint")
            if sprayPaintTool then
                -- Top Penis
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Top, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1,-0.7))
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Top, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1,-1)) 
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Top, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1,-1.5)) 
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Top, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1,-2)) 
                sprayPaintTool.Remote:FireServer(13850207336, Enum.NormalId.Top, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1,-2.5)) 
                
                -- Bottom Penis
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Bottom, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1.3,-0.5)) 
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Bottom, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1.3,-1))
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Bottom, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1.3,-1.5)) 
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Bottom, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1.3,-2)) 
                sprayPaintTool.Remote:FireServer(13850207336, Enum.NormalId.Bottom, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1.3,-2.5)) 

                -- Left Penis
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Left, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.15,-1.15,-0.5)) 
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Left, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.15,-1.15,-1)) 
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Left, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.15,-1.15,-1.5)) 
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Left, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.15,-1.15,-2)) 
                sprayPaintTool.Remote:FireServer(13850207336, Enum.NormalId.Left, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.15,-1.15,-2.5)) 

                -- Right Penis
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Right, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.15,-1.15,-0.5)) 
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Right, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.15,-1.15,-1)) 
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Right, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.15,-1.15,-1.5)) 
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Right, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.15,-1.15,-2)) 
                sprayPaintTool.Remote:FireServer(13850207336, Enum.NormalId.Right, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.15,-1.15,-2.5)) 
                
                -- Front Penis
                sprayPaintTool.Remote:FireServer(13850207336, Enum.NormalId.Front, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0,-1.15,-2.65)) 
                
                -- Left Sack
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Top, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.5,-1,-0.7)) 
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Front, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.5,-1.15,-0.85)) 
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Bottom, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.5,-1.3,-0.7)) 
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Right, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(0.65,-1.15,-0.7)) 
                
                -- Right side
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Top, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.5,-1,-0.7)) 
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Front, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.5,-1.15,-0.85)) 
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Bottom, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.5,-1.3,-0.7)) 
                sprayPaintTool.Remote:FireServer(60484593, Enum.NormalId.Left, 0.5, player.Character.HumanoidRootPart, posOfPenis * CFrame.new(-0.65,-1.15,-0.7)) 
            end
        end
    end
end
