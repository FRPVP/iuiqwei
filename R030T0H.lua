-- Get the local player
local player = game.Players.LocalPlayer

-- Define the decal highlight color
local highlightColor = Color3.fromRGB(255, 0, 0) -- Red color

-- Function to check if a part is created by the SprayPaint tool
local function isSprayPainted(part)
    return part and part:IsA("Decal") and part.Parent and part.Parent:IsA("Model") and part.Parent:FindFirstChild("creator") and part.Parent.creator.Value == player
end

-- Function to highlight the given decal
local function highlightDecal(decal)
    local highlight = Instance.new("SelectionBox")
    highlight.Adornee = decal
    highlight.Color3 = highlightColor
    highlight.Parent = decal
end

-- Listen for new parts being added to the workspace
game.Workspace.DescendantAdded:Connect(function(part)
    if isSprayPainted(part) then
        highlightDecal(part)
    end
end)

-- Check existing parts in the workspace
for _, part in ipairs(game.Workspace:GetDescendants()) do
    if isSprayPainted(part) then
        highlightDecal(part)
    end
end
