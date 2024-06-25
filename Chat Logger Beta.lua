-- Create the GUI
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SayMessageRequest = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ChatSystemGui"
screenGui.Parent = CoreGui
screenGui.DisplayOrder = 10 -- Ensure it layers over other GUIs

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 460, 0, 210)
mainFrame.Position = UDim2.new(0.0001, 0, 0.002, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
mainFrame.BackgroundTransparency = 0.3
mainFrame.BorderSizePixel = 0
mainFrame.Active = true -- Make the frame interactable for dragging

local dragHandle = Instance.new("TextLabel", mainFrame)
dragHandle.Size = UDim2.new(1, 0, 0, 30)
dragHandle.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
dragHandle.BackgroundTransparency = 0.3
dragHandle.BorderSizePixel = 0
dragHandle.Text = "Chat"
dragHandle.TextColor3 = Color3.new(1, 1, 1)
dragHandle.Font = Enum.Font.SourceSansBold
dragHandle.TextSize = 18
dragHandle.Active = true -- Make the drag handle interactable for dragging

local closeButton = Instance.new("ImageButton", dragHandle)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
closeButton.BackgroundTransparency = 1
closeButton.BorderSizePixel = 0
closeButton.Image = "rbxassetid://18206372442"

local colorButton = Instance.new("ImageButton", dragHandle)
colorButton.Size = UDim2.new(0, 30, 0, 30)
colorButton.Position = UDim2.new(1, -60, 0, 0)
colorButton.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
colorButton.BackgroundTransparency = 1
colorButton.BorderSizePixel = 0
colorButton.Image = "rbxassetid://18206558897"

local messageFrame = Instance.new("ScrollingFrame", mainFrame)
messageFrame.Position = UDim2.new(0, 0, 0, 30)
messageFrame.Size = UDim2.new(1, 0, 1, -60)
messageFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
messageFrame.ScrollBarThickness = 6
messageFrame.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
messageFrame.BackgroundTransparency = 0.3
messageFrame.BorderSizePixel = 0
messageFrame.ClipsDescendants = true
messageFrame.ScrollingDirection = Enum.ScrollingDirection.Y

local layout = Instance.new("UIListLayout", messageFrame)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 2)

local inputBox = Instance.new("TextBox", mainFrame)
inputBox.Position = UDim2.new(0, 0, 1, -30)
inputBox.Size = UDim2.new(1, 0, 0, 30)
inputBox.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
inputBox.BackgroundTransparency = 0.3
inputBox.BorderSizePixel = 0
inputBox.Text = ""
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.Font = Enum.Font.SourceSans
inputBox.TextSize = 18
inputBox.PlaceholderText = "Type your message here..."

local playerColors = {}
local isColoredNamesEnabled = false

local brightColors = {
    Color3.fromRGB(255, 85, 85),   -- Red
    Color3.fromRGB(85, 255, 85),   -- Green
    Color3.fromRGB(85, 85, 255),   -- Blue
    Color3.fromRGB(255, 255, 85),  -- Yellow
    Color3.fromRGB(85, 255, 255),  -- Cyan
    Color3.fromRGB(255, 85, 255),  -- Magenta
    Color3.fromRGB(255, 170, 0),   -- Orange
    Color3.fromRGB(170, 0, 255),   -- Purple
    Color3.fromRGB(255, 255, 255)  -- White
}

local rainbowColors = {
    Color3.fromRGB(255, 0, 0),     -- Red
    Color3.fromRGB(255, 127, 0),   -- Orange
    Color3.fromRGB(255, 255, 0),   -- Yellow
    Color3.fromRGB(0, 255, 0),     -- Green
    Color3.fromRGB(0, 0, 255),     -- Blue
    Color3.fromRGB(75, 0, 130),    -- Indigo
    Color3.fromRGB(148, 0, 211)    -- Violet
}

local function assignPlayerColor(player)
    if not playerColors[player] then
        playerColors[player] = brightColors[math.random(1, #brightColors)]
    end
    return playerColors[player]
end

-- Function to convert chat messages to system messages and add to GUI
local function convertChatToSystemMessage(player, message)
    local newMessage = Instance.new("TextLabel")
    newMessage.Size = UDim2.new(1, -10, 0, 0) -- Automatically resize the height
    newMessage.AutomaticSize = Enum.AutomaticSize.Y
    if isColoredNamesEnabled then
        newMessage.TextColor3 = assignPlayerColor(player)
    else
        newMessage.TextColor3 = Color3.new(1, 1, 1)
    end
    newMessage.Text = "[" .. player.Name .. "]: " .. message
    newMessage.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
    newMessage.BackgroundTransparency = 1
    newMessage.BorderSizePixel = 0
    newMessage.TextXAlignment = Enum.TextXAlignment.Left
    newMessage.TextWrapped = true
    newMessage.Font = Enum.Font.SourceSans
    newMessage.TextSize = 18
    newMessage.Parent = messageFrame

    -- Adjust the CanvasSize to fit all messages
    messageFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
    -- Scroll to the bottom
    messageFrame.CanvasPosition = Vector2.new(0, messageFrame.AbsoluteCanvasSize.Y)
end

-- Dictionary to keep track of connected players
local connectedPlayers = {}

-- Ensure that each player's Chatted event is connected only once
local function setupPlayerChatListener(player)
    if not connectedPlayers[player] then
        connectedPlayers[player] = true
        player.Chatted:Connect(function(message)
            convertChatToSystemMessage(player, message)
        end)
    end
end

-- Connect the function to the PlayerChatted event for existing players
for _, player in pairs(Players:GetPlayers()) do
    setupPlayerChatListener(player)
end

-- Connect the function to the PlayerChatted event for newly added players
Players.PlayerAdded:Connect(function(player)
    setupPlayerChatListener(player)
end)

-- Draggable GUI logic
local dragging
local dragInput
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

dragHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

dragHandle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        updateInput(input)
    end
end)

-- Handle sending messages
inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local message = inputBox.Text
        if message ~= "" then
            SayMessageRequest:FireServer(message, "All")
            inputBox.Text = ""
        end
    end
end)

-- Handle close button
closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- Handle color button
colorButton.MouseButton1Click:Connect(function()
    isColoredNamesEnabled = not isColoredNamesEnabled
    if not isColoredNamesEnabled then
        for _, child in ipairs(messageFrame:GetChildren()) do
            if child:IsA("TextLabel") then
                child.TextColor3 = Color3.new(1, 1, 1)
            end
        end
        -- Stop rainbow effect
        colorButton.ImageColor3 = Color3.new(1, 1, 1)
    else
        for _, child in ipairs(messageFrame:GetChildren()) do
            if child:IsA("TextLabel") and child.Text ~= "" then
                local playerName = child.Text:match("%[(.-)%]")
                local player = Players:FindFirstChild(playerName)
                if player then
                    child.TextColor3 = assignPlayerColor(player)
                end
            end
        end
        -- Start rainbow effect
        spawn(function()
            local i = 1
            while isColoredNamesEnabled do
                colorButton.ImageColor3 = rainbowColors[i]
                i = i + 1
                if i > #rainbowColors then
                    i = 1
                end
                wait(0.5) -- Adjust the speed of the rainbow effect here
            end
        end)
    end
end)
