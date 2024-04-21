if game.Players.LocalPlayer.Character ~= nil then
    for i, v in pairs(game.Players:GetPlayers()) do
        if v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") then
            if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
                local posOfPenis = workspace[v.Name].HumanoidRootPart.CFrame

                -- Spray painting the penis on all sides
                for _, normalId in ipairs(Enum.NormalId:GetEnumItems()) do
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("ReplicateToy"):InvokeServer("SprayPaint")
                    game.Players.LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character

                    -- Top Penis
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0,-1,-0.7))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0,-1,-1)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0,-1,-1.5)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0,-1,-2)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0,-1,-2.5)) 
                        
                    -- Bottom Penis
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0,-1.3,-0.5)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0,-1.3,-1))
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0,-1.3,-1.5)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0,-1.3,-2)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0,-1.3,-2.5)) 

                    -- Left Penis
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(-0.15,-1.15,-0.5)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(-0.15,-1.15,-1)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(-0.15,-1.15,-1.5)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(-0.15,-1.15,-2)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(-0.15,-1.15,-2.5)) 

                    -- Right Penis
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0.15,-1.15,-0.5)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0.15,-1.15,-1)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0.15,-1.15,-1.5)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0.15,-1.15,-2)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0.15,-1.15,-2.5)) 
                        
                    -- Front Penis
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Front, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0,-1.15,-2.65)) 
                        
                    -- Left Sack
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0.5,-1,-0.7)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Front, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0.5,-1.15,-0.85)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0.5,-1.3,-0.7)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(0.65,-1.15,-0.7)) 
                        
                    -- Right side
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(-0.5,-1,-0.7)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Front, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(-0.5,-1.15,-0.85)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(-0.5,-1.3,-0.7)) 
                    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, workspace[v.Name].HumanoidRootPart, posOfPenis * CFrame.new(-0.65,-1.15,-0.7)) 
                end
            end
        end
    end
end
