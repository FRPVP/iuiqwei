-- Function to highlight a part
local function highlightPart(part)
    local highlight = Instance.new("SelectionBox")
    highlight.Name = "Highlight"
    highlight.Parent = part
    highlight.Adornee = part
    highlight.Color3 = Color3.new(0, 1, 0) -- Green color for highlighting
    highlight.LineThickness = 0.05
    highlight.Transparency = 0.5
end

-- Function to check if a part is a newly created decal
local function checkNewDecal(part)
    return part:IsA("Decal") and not part:FindFirstChild("Highlight")
end

-- Function to handle part added to the workspace
local function onPartAdded(part)
    if checkNewDecal(part) then
        highlightPart(part)
    end
end

-- Loop through existing decals in the workspace and highlight them
for _, part in ipairs(workspace:GetDescendants()) do
    if checkNewDecal(part) then
        highlightPart(part)
    end
end

-- Connect the part added event
workspace.DescendantAdded:Connect(onPartAdded)
