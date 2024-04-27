local function CreateGUI()
    local gui = Instance.new("ScreenGui")
    local mainFrame = Instance.new("Frame")
    local dragFrame = Instance.new("Frame")
    local titleLabel = Instance.new("TextLabel")
    local closeButton = Instance.new("TextButton")
    local playerTextBox = Instance.new("TextBox")
    local tradeButton = Instance.new("TextButton")
    local looptradeButton = Instance.new("TextButton")

    gui.Parent = game.CoreGui

    mainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    mainFrame.BackgroundTransparency = 0.5
    mainFrame.Position = UDim2.new(0, 670, 0, 100)
    mainFrame.Size = UDim2.new(0, 200, 0, 30)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = gui

    -- Create an outline frame
    local outlineFrame = Instance.new("Frame")
    outlineFrame.Size = UDim2.new(1, 0, 1, 1)
    outlineFrame.Position = UDim2.new(-0.00, 0, -0.04, 0)
    outlineFrame.Parent = mainFrame

    local function rainbowColor()
        local frequency = 0.7
        local time = tick()
        local r = math.sin(frequency * time + 0) * 127 + 128
        local g = math.sin(frequency * time + 2) * 127 + 128
        local b = math.sin(frequency * time + 4) * 127 + 128
        return Color3.new(r / 255, g / 255, b / 255)
    end

    local function updateOutlineColor()
        outlineFrame.BackgroundColor3 = rainbowColor()
    end

    game:GetService("RunService").RenderStepped:Connect(updateOutlineColor)

    dragFrame.Name = "DragFrame"
    dragFrame.Parent = mainFrame
    dragFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    dragFrame.BackgroundTransparency = 0.8
    dragFrame.Size = UDim2.new(1, 0, 0, 30)

    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.Font = Enum.Font.Roboto
    titleLabel.Text = "MM2 Spam Trade GUI"
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.TextSize = 20
    titleLabel.TextStrokeTransparency = 0.2
    titleLabel.Parent = mainFrame

    local dragging = false
    local dragStart
    local startPos

    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    playerTextBox.Name = "PlayerTextBox"
    playerTextBox.Parent = mainFrame
    playerTextBox.BackgroundColor3 = Color3.new(0, 0, 0)
    playerTextBox.BackgroundTransparency = 0
    playerTextBox.Position = UDim2.new(0.5, -100, 0.5, 15)
    playerTextBox.Size = UDim2.new(0, 200, 0, 30)
    playerTextBox.Font = Enum.Font.Roboto
    playerTextBox.PlaceholderText = "User here! (can be short)"
    playerTextBox.Text = ""
    playerTextBox.TextColor3 = Color3.new(1, 1, 1)
    playerTextBox.TextSize = 16
    playerTextBox.TextStrokeTransparency = 0

local function autoCompletePlayerName()
    local partialName = playerTextBox.Text:lower() -- Convert to lowercase for case-insensitive comparison
    local players = game:GetService("Players"):GetPlayers()

    for _, player in pairs(players) do
        local playerName = player.Name:lower()
        if playerName:sub(1, #partialName) == partialName then
            playerTextBox.Text = player.Name
            break
        end
    end
end

playerTextBox.Focused:Connect(function()
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Return then
            autoCompletePlayerName()
        end
    end)
end)

    tradeButton.Name = "TradeButton"
    tradeButton.Parent = mainFrame
    tradeButton.BackgroundColor3 = Color3.new(0, 0.0, 0)
    tradeButton.Position = UDim2.new(0.5, -100, 0.5, 46)
    tradeButton.Size = UDim2.new(0, 100, 0, 30)
    tradeButton.Font = Enum.Font.Roboto
    tradeButton.Text = "Trade"
    tradeButton.TextColor3 = Color3.new(1, 1, 1)
    tradeButton.TextSize = 16
    tradeButton.TextStrokeTransparency = 0.2

    looptradeButton.Name = "LoopTradeButton"
    looptradeButton.Parent = mainFrame
    looptradeButton.BackgroundColor3 = Color3.new(0, 0.0, 0)
    looptradeButton.Position = UDim2.new(0.5, 0, 0.5, 46)
    looptradeButton.Size = UDim2.new(0, 100, 0, 30)
    looptradeButton.Font = Enum.Font.Roboto
    looptradeButton.Text = "Loop"
    looptradeButton.TextColor3 = Color3.new(1, 1, 1)
    looptradeButton.TextSize = 16
    looptradeButton.TextStrokeTransparency = 0.2

    tradeButton.MouseButton1Click:Connect(function()
        local targetPlayerName = playerTextBox.Text
        local targetPlayer = game:GetService("Players"):FindFirstChild(targetPlayerName)

        if targetPlayer then
            local args = {
                [1] = targetPlayer
            }

            game:GetService("ReplicatedStorage"):WaitForChild("Trade"):WaitForChild("SendRequest"):InvokeServer(unpack(args))

            game:GetService("ReplicatedStorage"):WaitForChild("Trade"):WaitForChild("AcceptRequest"):FireServer()
        else
            warn("Player not found:", targetPlayerName)
        end
    end)

    local isLooping = false
    local loopTradeConnection

    local function startLoop()
        isLooping = true

        loopTradeConnection = spawn(function()
            while isLooping do
                local targetPlayerName = playerTextBox.Text
                local targetPlayer = game:GetService("Players"):FindFirstChild(targetPlayerName)

                if targetPlayer then
                    local args = {
                        [1] = targetPlayer
                    }

                    game:GetService("ReplicatedStorage"):WaitForChild("Trade"):WaitForChild("SendRequest"):InvokeServer(unpack(args))

                    game:GetService("ReplicatedStorage"):WaitForChild("Trade"):WaitForChild("AcceptRequest"):FireServer()

                    wait(0) -- Adjust the delay as needed
                else
                    warn("Player not found:", targetPlayerName)
                end
            end
        end)
    end

    local function stopLoop()
        isLooping = false
        if loopTradeConnection then
            loopTradeConnection:Destroy()
        end
    end

looptradeButton.MouseButton1Click:Connect(function()
    local targetPlayerName = playerTextBox.Text
    if targetPlayerName ~= "" then
        if isLooping then
            stopLoop()
            looptradeButton.Text = "Loop"
            looptradeButton.TextColor3 = Color3.new(1, 1, 1) -- Change text color to white
        else
            startLoop()
            looptradeButton.Text = "Stop"
            looptradeButton.TextColor3 = Color3.new(1, 0, 0) -- Change text color to red
        end
    else
        warn("Please enter a player name before starting the loop.")
    end
end)
end

CreateGUI()
	else
        local gui = game.CoreGui:FindFirstChild("ScreenGui") -- Assuming "ScreenGui" is the name of the ScreenGui
        if gui then
            gui:Destroy()
        end
    end
end)
