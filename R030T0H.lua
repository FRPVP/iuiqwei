local function highlightNewDecals()
    local workspace = game:GetService("Workspace")
    
    -- Keep track of decals we've already highlighted
    local highlightedDecals = {}
    
    -- Function to check if a part contains a new decal
    local function checkPart(part)
        if part:IsA("Decal") and not highlightedDecals[part] then
            -- Highlight the part
            local highlight = Instance.new("SelectionBox")
            highlight.Color3 = Color3.new(1, 1, 0) -- Yellow color
            highlight.LineThickness = 0.05
            highlight.Adornee = part
            highlight.Parent = part
            
            -- Add to highlighted decals table
            highlightedDecals[part] = true
        end
    end
    
    -- Check all existing decals
    for _, decal in ipairs(workspace:GetDescendants()) do
        checkPart(decal)
    end
    
    -- Connect to new decal creation events
    workspace.DescendantAdded:Connect(function(descendant)
        checkPart(descendant)
    end)
end

-- Call the function to start highlighting new decals
highlightNewDecals()
