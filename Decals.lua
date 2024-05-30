-- Create a ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "MyGUI"
gui.ResetOnSpawn = false
gui.Parent = game.Players.LocalPlayer.PlayerGui

-- Check if the device is a mobile device
local isMobileDevice = game:GetService("UserInputService").TouchEnabled

-- Define the initial size of the GUI for desktop devices
local initialSize = isMobileDevice and UDim2.new(0.9, 0, 0.9, 0) or UDim2.new(0.457, 0, 0.6, 0)

-- Create the main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = initialSize -- Adjust size for mobile devices
mainFrame.Position = UDim2.new(0.5, -mainFrame.Size.X.Offset / 2, 0.5, -mainFrame.Size.Y.Offset / 2) -- Center the frame
mainFrame.BackgroundColor3 = Color3.fromRGB(10,23,39,255) -- Dark blue background
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Enable dragging
mainFrame.Parent = gui

-- Add UICorner to the main frame
local mainFrameCorner = Instance.new("UICorner")
mainFrameCorner.CornerRadius = UDim.new(0, 10)
mainFrameCorner.Parent = mainFrame

-- Create a close button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30) -- Adjust size as needed
closeButton.Position = UDim2.new(1, -40, 0, 10) -- Adjust position as needed
closeButton.BackgroundColor3 = Color3.fromRGB(28,156,148) -- Red color
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamSemibold -- Change font
closeButton.TextSize = 18 -- Adjust text size
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White color
closeButton.Parent = mainFrame

-- Add UICorner to the close button
local closeButtonCorner = Instance.new("UICorner")
closeButtonCorner.CornerRadius = UDim.new(0.2, 0) -- Make it a square button
closeButtonCorner.Parent = closeButton

-- Function to close the GUI when the close button is clicked
closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Adjust GUI size and position for mobile devices
if isMobileDevice then
    mainFrame.Size = UDim2.new(0.9, 0, 0.9, 0)
    mainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
end

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 0, 30) -- Adjust size as needed
minimizeButton.Position = UDim2.new(1, -80, 0, 10) -- Adjust position as needed
minimizeButton.BackgroundColor3 = Color3.fromRGB(28,156,148) -- Green color
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "-"
minimizeButton.Font = Enum.Font.GothamSemibold -- Change font
minimizeButton.TextSize = 18 -- Adjust text size
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White color
minimizeButton.Parent = mainFrame

-- Add UICorner to the minimize button
local minimizeButtonCorner = Instance.new("UICorner")
minimizeButtonCorner.CornerRadius = UDim.new(0.2, 0) -- Make it a square button
minimizeButtonCorner.Parent = minimizeButton

-- Create a draggable button representing the minimized state
local minimizedButton = Instance.new("TextButton")
minimizedButton.Name = "MinimizedButton"
minimizedButton.Size = UDim2.new(0, 30, 0, 30) -- Adjust size as needed
minimizedButton.Position = UDim2.new(1, -1431, 0, -31) -- Adjust position as needed
minimizedButton.BackgroundColor3 = Color3.fromRGB(28,156,148) -- Green color
minimizedButton.BorderSizePixel = 0
minimizedButton.Text = "-"
minimizedButton.Font = Enum.Font.GothamSemibold -- Change font
minimizedButton.TextSize = 18 -- Adjust text size
minimizedButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- White color
minimizedButton.Visible = false -- Initially invisible
minimizedButton.Parent = gui

-- Add UICorner to the minimized button
local minimizedButtonCorner = Instance.new("UICorner")
minimizedButtonCorner.CornerRadius = UDim.new(0.2, 0) -- Round corners
minimizedButtonCorner.Parent = minimizedButton

-- Function to minimize the GUI when the minimize button is clicked
minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    minimizedButton.Visible = not minimizedButton.Visible
end)

-- Function to maximize the GUI when the minimized button is clicked
minimizedButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    minimizedButton.Visible = not minimizedButton.Visible
end)

-- Create a search bar
local searchBar = Instance.new("TextBox")
searchBar.Name = "SearchBar"
searchBar.Size = UDim2.new(0.257, 0, 0, 30) -- Adjust size as needed
searchBar.Position = UDim2.new(0.02, 0, 0, 10) -- Adjust position as needed
searchBar.PlaceholderText = "Search by title..."
searchBar.Font = Enum.Font.Gotham
searchBar.TextSize = 14
searchBar.BackgroundTransparency = 0.5
searchBar.BackgroundColor3 = Color3.fromRGB(21,40,57,255) -- Dark background color
searchBar.BorderSizePixel = 0
searchBar.TextColor3 = Color3.fromRGB(255, 255, 255) -- Text color
searchBar.PlaceholderColor3 = Color3.fromRGB(150, 150, 150) -- Placeholder text color
searchBar.ClearTextOnFocus = false
searchBar.Text = ""  -- Remove default "textbox" text
searchBar.Parent = mainFrame

-- Add UICorner to the search bar
local searchBarCorner = Instance.new("UICorner")
searchBarCorner.CornerRadius = UDim.new(0, 5)
searchBarCorner.Parent = searchBar

-- Create a text box next to the search bar
local initialInfoText = "https://create.roblox.com/store/images" -- Initial text content
local infoBox = Instance.new("TextBox")
infoBox.Name = "InfoBox"
infoBox.Size = UDim2.new(0.357, 0, 0, 30) -- Adjust size as needed
infoBox.Position = UDim2.new(0.29, 0, 0, 10) -- Adjust position as needed
infoBox.Text = initialInfoText -- Set the initial text content
infoBox.Font = Enum.Font.Gotham
infoBox.TextSize = 14
infoBox.BackgroundTransparency = 0.5
infoBox.BackgroundColor3 = Color3.fromRGB(21,40,57,255) -- Dark background color
infoBox.BorderSizePixel = 0
infoBox.TextColor3 = Color3.fromRGB(255, 255, 255) -- Text color
infoBox.ClearTextOnFocus = false -- Allow editing without clearing text
infoBox.Parent = mainFrame

-- Add UICorner to the info box
local infoBoxCorner = Instance.new("UICorner")
infoBoxCorner.CornerRadius = UDim.new(0, 5)
infoBoxCorner.Parent = infoBox

-- Store the initial text
local currentInfoText = initialInfoText

-- Reset the text if no new text was entered
infoBox.FocusLost:Connect(function(enterPressed)
    if not enterPressed then
        if infoBox.Text == "" or infoBox.Text:len() < currentInfoText:len() then
            infoBox.Text = initialInfoText -- Restore initial text
        else
            currentInfoText = infoBox.Text -- Update current text
        end
    end
end)

-- Create a scrolling frame to contain the decal previews
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, 0, 1, -90) -- Adjust size as needed
scrollFrame.Position = UDim2.new(0, 0, 0, 50) -- Adjust position as needed
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 10
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Initialize CanvasSize
scrollFrame.Parent = mainFrame

-- Add UICorner to the scrolling frame
local scrollFrameCorner = Instance.new("UICorner")
scrollFrameCorner.CornerRadius = UDim.new(0, 10)
scrollFrameCorner.Parent = scrollFrame

-- Function to create decal previews in five columns
local function createDecalPreview(title, decalID, position, textboxPosition)
    local decalPreview = Instance.new("ImageLabel")
    decalPreview.Name = "DecalPreview"
    decalPreview.Size = UDim2.new(0, 120, 0, 120) -- Adjust size as needed
    decalPreview.Position = position
    decalPreview.BackgroundTransparency = 1
    decalPreview.Image = "rbxthumb://type=Asset&id=" .. decalID .. "&w=150&h=150"
    decalPreview.Parent = scrollFrame
    
    -- Create title for decal preview
    local titleTextBox = Instance.new("TextBox")
    titleTextBox.Name = "TitleTextBox"
    titleTextBox.Size = UDim2.new(0, 120, 0, 20) -- Adjust size as needed
    titleTextBox.Position = position + UDim2.new(0, 0, 0, 130) -- Position below decal preview
    titleTextBox.BackgroundColor3 = Color3.fromRGB(21,40,57,255) -- Darker blue background
    titleTextBox.BorderSizePixel = 0
    titleTextBox.Text = title
    titleTextBox.Font = Enum.Font.Gotham
    titleTextBox.TextSize = 12
    titleTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleTextBox.ClearTextOnFocus = false
    titleTextBox.TextEditable = false
    titleTextBox.Parent = scrollFrame
    
    -- Create textbox for decal ID
    local decalIDTextBox = Instance.new("TextBox")
    decalIDTextBox.Name = "DecalIDTextBox"
    decalIDTextBox.Size = UDim2.new(0, 120, 0, 20) -- Adjust size as needed
    decalIDTextBox.Position = textboxPosition
    decalIDTextBox.BackgroundColor3 = Color3.fromRGB(21,40,57,255) -- Darker blue background
    decalIDTextBox.BorderSizePixel = 0
    decalIDTextBox.Text = decalID
    decalIDTextBox.Font = Enum.Font.Gotham
    decalIDTextBox.TextSize = 12
    decalIDTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    decalIDTextBox.ClearTextOnFocus = false
    decalIDTextBox.TextEditable = true
    decalIDTextBox.Parent = scrollFrame
    
    -- Reset the text when the user clicks off
    decalIDTextBox.FocusLost:Connect(function(enterPressed)
        if not enterPressed then
            decalIDTextBox.Text = decalID
        end
    end)
    
    return decalPreview, titleTextBox, decalIDTextBox
end

-- Define custom titles and decal IDs (replace these with your own)
local decalPreviews = {
    {title = "Vindicate Logo", id = 17646580928},
    {title = "White Glue", id = 14976845153},
    {title = "Communism", id = 6978648716},
    {title = "Face 1", id = 12579922286},
    {title = "Troll Face", id = 10193511157},
    {title = "Spongebob 1", id = 16989882575},
    {title = "Spongebob 2", id = 17282019822},
    {title = "Spongebob 3", id = 17373315144},
    {title = "Spongebob 4", id = 17373265789},
    {title = "Rickroll", id = 10180722469},
    {title = "LOL Emoji", id = 12877195347},
    {title = "Spongebob 5", id = 17438371258},
    {title = "Crimson Chin", id = 17438415353},
    {title = "Let It Rip", id = 17438452253},
    {title = "Read The Sign!", id = 17438524420},
    {title = "Painful BJ", id = 17438554754},
    {title = "Behind", id = 17438582165},
    {title = "The Limit", id = 17438725283},
    {title = "Face Cream", id = 17438743086},
    {title = "Lets See", id = 17438762668},
    {title = "Tom's Third Leg", id = 17438844825},
    {title = "The D", id = 17438798519},
    {title = "Banana", id = 17438867266},
    {title = "Pussy Cat", id = 17438909157},
    {title = "Oh Boobies", id = 17438927790},
    {title = "Jerk It Off", id = 17438949273},
    {title = "One Piece", id = 10299570904},
    {title = "Just Right", id = 10205747078},
    {title = "Handsome Squid", id = 10193687436},
    {title = "Relief", id = 10193531276},
    {title = "Face 2", id = 12579900291},
    {title = "Face 3", id = 15219559821},
    {title = "c:", id = 7465254044},
    {title = "Tubers Logo", id = 9907765074},
    {title = "Join Team c00lkidd", id = 10459746711},
    {title = "c00lkidd", id = 178993746},
    {title = "Tubers93", id = 8874768843},
    {title = "John Doe", id = 699424744},
    {title = "1x1x1x1x1x1x", id = 692393285},
    {title = "Mario.EXE", id = 12851404506},
    {title = "Face 4", id = 12736544405},
    {title = "Face 5", id = 7454933287},
    {title = "Ayo Mario?", id = 16619718377},
    {title = "Evil Luigi", id = 15332431542},
    {title = "No Bitches?", id = 13876396989},
    {title = "Megamind Poster", id = 11798557844},
    {title = "Ro-Germany", id = 16226442933},
    {title = "Red", id = 14033250886},
    {title = "Blue", id = 8154063596},
    {title = "Yellow", id = 10528731267},
    {title = "Green", id = 11774113785},
    {title = "Purple", id = 11301128092},
    {title = "Orange", id = 15207891724},
    {title = "Black", id = 12781220539},
    {title = "White", id = 1343642734},
    {title = "Pink", id = 16496874190},
    {title = "MC Grass", id = 8676495068},
    {title = "MC Books", id = 10300825416},
    {title = "MC Furnace", id = 13711805173},
    {title = "MC Trap Door", id = 15420292685},
    {title = "MC Slab", id = 15351020063},
    {title = "MC Acacia Trap Door", id = 15420298036},
    {title = "MC Sand", id = 12624140912},
    {title = "MC Leaves", id = 14645147330},
    {title = "MC Coal", id = 8677286071},
    {title = "MC Water", id = 11462074138},
    {title = "MC Rail", id = 11462107403},
    {title = "MC Iron Bars", id = 11969908493},
    {title = "MC Wood Plank", id = 12470614353},
    {title = "MC Dirt", id = 8275209676},
    {title = "MC Wood", id = 12470609302},
    {title = "MC Red Sand", id = 9228568618},
    {title = "MC Luck Block", id = 8277401598},
    {title = "MC Blue Coral", id = 9246085914},
    {title = "MC Berch Plank", id = 8678670358},
    {title = "MC Emerald", id = 11425725303},
    {title = "MC Iron Ore", id = 11425626932},
    {title = "MC Stone Brick", id = 8139086786},
    {title = "MC Glass", id = 11384458786},
    {title = "MC No Texture", id = 6718522761},
    {title = "MC Magma", id = 9065431121},
    {title = "MC Smooth Stone", id = 16772274014},
    {title = "MC Red Stone", id = 8677288287},
    {title = "MC Gold", id = 14934313210},
    {title = "MC Netherite", id = 7696392991},
    {title = "MC Cactus", id = 12624066636},
    {title = "MC Brick", id = 13017216630},
    {title = "MC Diamond", id = 8677289930},
    {title = "MC Dark Oak Planks", id = 9359133333},
    {title = "MC Stone", id = 8676746456},
    {title = "MC Ancient Debris", id = 8677283985},
    {title = "MC Soul Fire", id = 14792109788},
    {title = "MC Gold Ore", id = 7700990575},
    {title = "MC Crimson Planks", id = 8678673036},
    {title = "MC Oak Leaves", id = 12193465277},
    {title = "MC Powered Rails", id = 14934357535},
    {title = "MC Jungle Planks", id = 8678671179},
    {title = "MC Portal Frame", id = 11547423217},
    {title = "MC Obsidian", id = 11547302037},
    {title = "MC Cobblestone", id = 16772476247},
    {title = "MC Sculk", id = 15060374471},
    {title = "MC Note", id = 4743573805},
    {title = "MC Wheat", id = 13991128555},
    {title = "MC Ladder", id = 5386752779},
    {title = "MC Command", id = 129804021},
    {title = "MC Sugar Cane", id = 16236855983},
    {title = "MC Lapis", id = 7701274352},
    {title = "MC Iron", id = 8677286764},
    {title = "MC Spruce Plank", id = 8187648618},
    {title = "Ducktator", id = 17451271391},
    {title = "Ducktator 2", id = 17451375987},
    {title = "911", id = 17451619370},
    {title = "Children", id = 17463173102},
    {title = "Cummed and Hard", id = 17463212151},
    {title = "Sex Xray", id = 17497414733},
    {title = "Sex Xray 2", id = 17502366819},
    {title = "Stare 1", id = 17502530604},
    {title = "Stare 2", id = 17502535333},
    {title = "Stare 3", id = 17502563934},
    {title = "Child Monster", id = 17502568283},
    {title = "Stare 4", id = 17502572368},
    {title = "Stare 5", id = 17502555059},
    {title = "Stare 6", id = 17502580513},
    {title = "Chad 1", id = 17502583906},
    {title = "Chad 2", id = 17502589015},
    {title = "Pull IP 1", id = 17513611697},
    {title = "Pull IP 2", id = 17513632877},
    {title = "Pull IP 3", id = 17513630647},
    {title = "Pull IP 4", id = 17513627851},
    {title = "Pull IP 5", id = 17513625936},
    {title = "Pull IP 6", id = 17513623126},
    {title = "Pull IP 7", id = 17513620257},
    {title = "Sexy Plane", id = 17513719124},
    {title = "Child Kidnap", id = 17513731834},
    {title = "Boobies", id = 17513764092},
    {title = "Boobies 2", id = 17513801336},
    {title = "Boobies 3", id = 17513815332},
    {title = "Boobies 4", id = 17513821294},
    {title = "Funny", id = 16091268969},
    {title = "Down Bad?", id = 15767539260},
    {title = "Rickroll 2", id = 6403436082},
    {title = "Lie Detector", id = 15729969509},
    {title = "Buy a Divorce", id = 11523857626},
    {title = "Man Face", id = 13567539328},
    {title = "Laughing Cat", id = 16541142630},
    {title = "Caution", id = 12249128463},
    {title = "Troll Face 2", id = 14916455451},
    {title = "Bugs Under Skin", id = 10143789369},
    {title = "Glitched", id = 3128134660},
    {title = "Microsoft", id = 4551501098},
    {title = "Glizzy Time", id = 14453899460},
    {title = "One Piece 2", id = 10511856020},
    {title = "Sheesh!", id = 6685768782},
    {title = "Reverse", id = 13878717225},
    {title = "Skip", id = 14729518032},
    {title = "Plus 4", id = 11138597404},
    {title = "Plus 99", id = 12898314499},
    {title = "Plus Infinity", id = 3295477138},
    {title = "Mario Brick", id = 14220229900},
    {title = "Mario Block", id = 459786689},
    {title = "Mario ? Block", id = 1296074947},
    {title = "Mario ? Block 2", id = 16048693087},
    {title = "Mario ? Block 3", id = 237446655},
    {title = "Mario Ground Block", id = 14220047500},
    {title = "Mario Twitch Block", id = 7626103667},
    {title = "Mario Youtube Block", id = 7626107872},
    {title = "Roblox Logo", id = 2175089032},
    {title = "Roblox Logo 2", id = 14446847395},
    {title = "Roblox Logo 3", id = 845359308},
    {title = "Dab", id = 1104294760},
    {title = "Oh My GYATT", id = 15724216964},
    {title = "Certified Rizz", id = 17156009318},
    {title = "Mid", id = 15147793496},
    {title = "Sexy Xray", id = 17559259734},
    {title = "Ro-Hub", id = 15296065378},
    {title = "Push It Down", id = 17663329419},
    {title = "The Rock", id = 8425069728},
    {title = "Gun", id = 5205790826},
    {title = "Gun 2", id = 12297563214},
    {title = "Nuh Uh", id = 14061517613},
    {title = "Amazon Box", id = 4700049612},
    {title = "Sigma", id = 11600511955},
    {title = "Rage", id = 11804319656},
    {title = "Lampert", id = 16719073284},
    {title = "Purple", id = 11746969607},
    {title = "Freddy", id = 7084794707},
    {title = "Orange", id = 11746739201},
    {title = "Dragon", id = 8810641616},
    {title = "Little Girl", id = 7231767729},
    {title = "Floof", id = 13394672409},
    {title = "Hand Gun", id = 5381454313},
    {title = "Titan Camera", id = 17395358631},
    {title = "Curved Arrow", id = 13892563763},
    {title = "IM COMING", id = 16704541540},
    {title = "Thumbs Up", id = 9112078981},
    {title = "Eyes-Doors", id = 10865377911},
    {title = "Robux", id = 8639316613},
    {title = "Stroll", id = 16851134497},
    {title = "Mm2 Gun", id = 14926229050},
    {title = "Mm2 Gun 2", id = 12892799831},
    {title = "Quagmire", id = 15541789509},
    {title = "XHamster Logo", id = 17669210419},
    {title = "Pornhub Logo 2", id = 17669228848},
    {title = "Rule 34 Logo", id = 17669330247},
    {title = "Rule 34 Logo 2", id = 17669346071},
    {title = "Rule 34 Logo 3", id = 17669354648},
    {title = "Multporn Logo", id = 17669508593},

}

-- Create decal previews with custom titles
local posX = 10
local posY = 10
local columnCount = 0
local decalPreviewElements = {} -- Store decal preview elements for manipulation
for _, preview in ipairs(decalPreviews) do
    local decalPreview, titleTextBox, decalIDTextBox = createDecalPreview(preview.title, preview.id, UDim2.new(0, posX, 0, posY), UDim2.new(0, posX, 0, posY + 150))
    table.insert(decalPreviewElements, {DecalPreview = decalPreview, TitleTextBox = titleTextBox, DecalIDTextBox = decalIDTextBox})
    columnCount = columnCount + 1
    if columnCount == 5 then
        columnCount = 0
        posX = 10
        posY = posY + 170
    else
        posX = posX + 130
    end
end

-- Update the CanvasSize of the scrollFrame
local totalRows = math.ceil(#decalPreviews / 5)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalRows * 190)

-- Function to filter and reorder decal previews based on search query
local function filterDecalPreviews(query)
    local foundPreviews = {} -- Store the found previews
    for _, element in ipairs(decalPreviewElements) do
        local title = string.lower(element.TitleTextBox.Text)
        if string.find(title, query) then
            element.DecalPreview.Visible = true
            element.TitleTextBox.Visible = true
            element.DecalIDTextBox.Visible = true
            table.insert(foundPreviews, element)
        else
            element.DecalPreview.Visible = false
            element.TitleTextBox.Visible = false
            element.DecalIDTextBox.Visible = false
        end
    end
    
    -- Reorder previews to bring the found ones to the front
    for i, foundPreview in ipairs(foundPreviews) do
        local index = table.find(decalPreviewElements, foundPreview)
        if index then
            table.remove(decalPreviewElements, index)
            table.insert(decalPreviewElements, i, foundPreview)
        end
    end
    
    -- Reposition previews to maintain column arrangement
    local posX = 10
    local posY = 10
    for i, element in ipairs(decalPreviewElements) do
        element.DecalPreview.Position = UDim2.new(0, posX, 0, posY)
        element.TitleTextBox.Position = UDim2.new(0, posX, 0, posY + 130)
        element.DecalIDTextBox.Position = UDim2.new(0, posX, 0, posY + 160) -- Adjust vertical spacing
        if i % 5 == 0 then
            posX = 10
            posY = posY + 190
        else
            posX = posX + 138
        end
    end
end

-- Connect search functionality to the search bar
searchBar.Changed:Connect(function()
    local query = string.lower(searchBar.Text)
    filterDecalPreviews(query)
end)

local dragging
local dragStartOffset

-- Function to handle manual dragging
local function startDrag(input)
    local initialPosition = input.Position
    local initialGuiPosition = gui.Position
    dragStartOffset = initialPosition - initialGuiPosition
    dragging = true
end

local function updateDrag(input)
    if dragging then
        local newPosition = input.Position - dragStartOffset
        gui.Position = UDim2.new(0, newPosition.X, 0, newPosition.Y)
    end
end

local function endDrag()
    dragging = false
end

-- Connect manual drag functions to mouse input events
gui.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        startDrag(input)
    end
end)

gui.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        updateDrag(input)
    end
end)

gui.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        endDrag()
    end
end)
