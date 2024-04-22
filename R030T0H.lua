-- Function to update the dropdown with the current player list
local function UpdateplayerListPaint(Dropdown)
    local playerListPaint = {}
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
Dropdown:OnChanged(function(Value)
    print("Dropdown changed:", Value)
end)

-- Connect to player added/removed events to update the dropdown
game.Players.PlayerAdded:Connect(function(player)
    UpdateplayerListPaint(Dropdown)
end)

game.Players.PlayerRemoving:Connect(function(player)
    UpdateplayerListPaint(Dropdown)
end)
