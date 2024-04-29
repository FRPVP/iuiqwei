local outlineColor = Color3.new(1, 0, 0) -- Outline color (red)
local outlineThickness = 0.05 -- Thickness of the outline
local outlinesEnabled = false -- Variable to track whether outlines are enabled

-- Function to create an outline for a given part, mesh, or decal
local function createOutline(object)
    local outline = Instance.new("SelectionBox")
    outline.Adornee = object
    outline.Color3 = outlineColor
    outline.LineThickness = outlineThickness
    outline.Parent = object
    return outline
end

-- Function to check if an object is a part, mesh, or decal
local function isPartMeshOrDecal(object)
    return object:IsA("BasePart") or object:IsA("MeshPart") or object:IsA("Decal")
end

-- Function to create outlines for all parts, meshes, and decals in the game
local function createOutlines()
    for _, object in ipairs(game:GetDescendants()) do
        if isPartMeshOrDecal(object) then
            createOutline(object)
        end
    end
end

-- Function to toggle outlines on or off
local function toggleOutlines()
    outlinesEnabled = not outlinesEnabled
    for _, object in ipairs(game:GetDescendants()) do
        if object:IsA("SelectionBox") then
            object.Visible = outlinesEnabled
        end
    end
end

-- Call the function to create outlines when the game starts
createOutlines()

-- Listen for new objects being added to the game
game.DescendantAdded:Connect(function(object)
    if outlinesEnabled and isPartMeshOrDecal(object) then
        createOutline(object)
    end
end)

-- Create a ScreenGui for the toggle button
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create a TextButton for the toggle button
local toggleButton = Instance.new("TextButton")
toggleButton.Text = "Toggle Outlines"
toggleButton.Size = UDim2.new(0, 150, 0, 50)
toggleButton.Position = UDim2.new(0.5, -75, 0.5, -25)
toggleButton.Parent = gui

-- Variable to track whether the button is being dragged
local isDragging = false

-- Function to handle dragging the button
toggleButton.MouseButton1Down:Connect(function()
    isDragging = true
end)

toggleButton.MouseButton1Up:Connect(function()
    isDragging = false
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePosition = input.Position
        toggleButton.Position = UDim2.new(0, mousePosition.X - toggleButton.AbsoluteSize.X / 2, 0, mousePosition.Y - toggleButton.AbsoluteSize.Y / 2)
    end
end)

-- Listen for button click to toggle outlines
toggleButton.MouseButton1Click:Connect(function()
    toggleOutlines()
end)
