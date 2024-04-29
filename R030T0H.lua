-- Function to highlight a part
local function highlightDecal(decal)
    local highlightColor = Color3.fromRGB(255, 255, 0) -- Yellow color
    local originalColor = decal.Color3
    decal.Color3 = highlightColor
    wait(0.5) -- Highlight duration
    decal.Color3 = originalColor
end

-- Function to check for new decals in the Workspace
local function checkForNewDecals()
    local workspaceChildren = game.Workspace:GetChildren()
    for _, child in ipairs(workspaceChildren) do
        if child:IsA("Decal") then
            highlightDecal(child)
        end
    end
end

-- Connect the function to run whenever a new decal is added to the Workspace
game.Workspace.ChildAdded:Connect(function(child)
    if child:IsA("Decal") then
        highlightDecal(child)
    end
end)

-- Check for any existing decals when the script starts
checkForNewDecals()
