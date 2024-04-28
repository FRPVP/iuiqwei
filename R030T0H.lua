-- Get the LocalPlayer
local player = game.Players.LocalPlayer

-- Function to check if a part is a decal created by the "SprayPaint" tool
local function isSprayPaintDecal(part)
    return part:IsA("Decal") and part.Parent and part.Parent:IsA("Model") and part.Parent:FindFirstChild("SprayPaint") and part.Parent.SprayPaint:IsA("Tool") and part.Parent.SprayPaint.Parent == player.Backpack
end

-- Function to highlight a part
local function highlightPart(part)
    local highlight = Instance.new("SelectionBox")
    highlight.Adornee = part
    highlight.Color3 = Color3.new(1, 1, 0) -- Yellow color
    highlight.LineThickness = 0.05
    highlight.Parent = part
end

-- Function to remove the highlight from a part
local function removeHighlight(part)
    for _, child in ipairs(part:GetChildren()) do
        if child:IsA("SelectionBox") then
            child:Destroy()
        end
    end
end

-- Connect to the descendant added event of the backpack
player.Backpack.DescendantAdded:Connect(function(descendant)
    -- Check if the descendant is a decal and was created by the "SprayPaint" tool
    if isSprayPaintDecal(descendant) then
        highlightPart(descendant) -- Highlight the decal
        descendant.AncestryChanged:Connect(function()
            removeHighlight(descendant) -- Remove highlight if the decal is removed
        end)
    end
end)
