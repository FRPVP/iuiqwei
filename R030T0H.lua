-- Function to update the dropdown with the current player list
local function UpdateplayerListPaint(Dropdown)
    local playerListPaint = {"All"}
    for _, player in pairs(game.Players:GetPlayers()) do
        table.insert(playerListPaint, player.Name)
    end
    Dropdown:SetValues(playerListPaint)
end

-- Create the dropdown with player names
local Dropdown = Tabs.Visual:AddDropdown("Dropdown", {
    Title = "Spectate Player",
    Values = {},  -- Start with an empty list
    Multi = false,
    Default = 0,
})

-- Update the dropdown with the current player list
UpdateplayerListPaint(Dropdown)

-- Callback function when dropdown value changes
Dropdown:OnChanged(function(fetarget)
    fetargetname = fetarget
end)

-- Connect to player added/removed events to update the dropdown
game.Players.PlayerAdded:Connect(function(player)
    UpdateplayerListPaint(Dropdown)
end)

game.Players.PlayerRemoving:Connect(function(player)
    UpdateplayerListPaint(Dropdown)
end)




function EquipSpray()
    game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
    wait()
    for _,obj in next, game.Players.LocalPlayer.Backpack:GetChildren() do
        if obj.Name == "SprayPaint" then
            local equip = game.Players.LocalPlayer.Backpack.SprayPaint
            equip.Parent = game.Players.LocalPlayer.Character
        end
    end
end




function fepenisfunc()
    -- Top Penis
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,-0.7))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,-1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,-1.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,-2))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Top, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,-2.5))
    
    ----Bottom Penis
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.3,-0.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.3,-1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.3,-1.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.3,-2))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Bottom, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.3,-2.5))

    -- Left Penis
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.15,-1.15,-0.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.15,-1.15,-1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.15,-1.15,-1.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.15,-1.15,-2))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Left, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.15,-1.15,-2.5))

    -- Right Penis
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.15,-1.15,-0.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.15,-1.15,-1))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.15,-1.15,-1.5))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.15,-1.15,-2))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Right, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.15,-1.15,-2.5))
    
    -- Front Penis
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(13850207336, Enum.NormalId.Front, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1.15,-2.65))

    -- Left Sack
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.5,-1,-0.7))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Front, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.5,-1.15,-0.85))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.5,-1.3,-0.7))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Right, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(0.65,-1.15,-0.7))
    
    -- Right side
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Top, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.5,-1,-0.7))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Front, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.5,-1.15,-0.85))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Bottom, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.5,-1.3,-0.7))
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(12976059241, Enum.NormalId.Left, 0.5, (fepenistarget.Character.HumanoidRootPart), fepenistarget.Character.HumanoidRootPart.CFrame * CFrame.new(-0.65,-1.15,-0.7))
end






    local Toggle = Tabs.Player:AddToggle("", {Title = "FE PP", Default = false })

    Toggle:OnChanged(function(fepenis)
        if fepenis == true then
        SprayPaintNotif()
        fepenistarget = players:FindFirstChild(LocalPlayer.Name)
        fepenisloop = true
        while fepenisloop do
            function fepenisloopfix()
            EquipSpray()
            task.wait(0.4)
            if fetargetname == "All" then
                for i,v in pairs(game.Players:GetPlayers()) do
                    fepenistarget = players:FindFirstChild(v.Name)
                    fepenisfunc()
                    task.wait()
                end
            else
                fepenistarget = players:FindFirstChild(fetargetname)
                fepenisfunc()
            end
            task.wait(15)
        end
        wait()
        pcall(fepenisloopfix)
        end
    end
    if fepenis == false then
        fepenisloop = false
        wait()
    end
    end)

    Options.MyToggle:SetValue(false)
