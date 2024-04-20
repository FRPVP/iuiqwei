-- Constants
local SprayId = 60484593
local SprayInterval = 15.5

-- Function to spray paint other players
local function SprayPaintPlayers()
    while true do
        if game.Players.LocalPlayer.Character then
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        local posOfPlayer = humanoidRootPart.CFrame
                        local backpack = game.Players.LocalPlayer.Backpack
                        if backpack then
                            local sprayPaintItem = backpack:FindFirstChild("SprayPaint")
                            if sprayPaintItem then
                                -- Move SprayPaint from backpack to character
                                sprayPaintItem.Parent = game.Players.LocalPlayer.Character

                                -- Fire spray paint effects
                                local Remote = game.Players.LocalPlayer.Character.SprayPaint.Remote
                                Remote:FireServer(SprayId, Enum.NormalId.Top, 32, humanoidRootPart, posOfPlayer * CFrame.new(0, 3, 0))
                                Remote:FireServer(SprayId, Enum.NormalId.Bottom, 32, humanoidRootPart, posOfPlayer * CFrame.new(0, 3.15, 0))
                                Remote:FireServer(SprayId, Enum.NormalId.Bottom, 32, humanoidRootPart, posOfPlayer * CFrame.new(0, -2.8, 0))
                                Remote:FireServer(SprayId, Enum.NormalId.Top, 32, humanoidRootPart, posOfPlayer * CFrame.new(0, -3, 0))
                                Remote:FireServer(SprayId, Enum.NormalId.Front, 32, humanoidRootPart, posOfPlayer * CFrame.new(0, 0.1, 3.1))
                                Remote:FireServer(SprayId, Enum.NormalId.Back, 32, humanoidRootPart, posOfPlayer * CFrame.new(0, 0.1, 2.86))
                                Remote:FireServer(SprayId, Enum.NormalId.Front, 32, humanoidRootPart, posOfPlayer * CFrame.new(0, 0.1, -2.86))
                                Remote:FireServer(SprayId, Enum.NormalId.Back, 32, humanoidRootPart, posOfPlayer * CFrame.new(0, 0.1, -3.1))
                                Remote:FireServer(SprayId, Enum.NormalId.Right, 32, humanoidRootPart, posOfPlayer * CFrame.new(2.86, 0.1, 0))
                                Remote:FireServer(SprayId, Enum.NormalId.Left, 32, humanoidRootPart, posOfPlayer * CFrame.new(3.1, 0.1, 0))
                                Remote:FireServer(SprayId, Enum.NormalId.Right, 32, humanoidRootPart, posOfPlayer * CFrame.new(-3.1, 0.1, 0))
                                Remote:FireServer(SprayId, Enum.NormalId.Left, 32, humanoidRootPart, posOfPlayer * CFrame.new(-2.86, 0.1, 0))

                                -- Move SprayPaint from character back to backpack
                                sprayPaintItem.Parent = backpack
                            end
                        end
                    end
                end
            end
        end
        wait(SprayInterval)
    end
end

-- Function to create GUI
local function CreateGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SprayPaintGUI"
    ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui

    local Frame = Instance.new("Frame")
    Frame.Name = "Main"
    Frame.Size = UDim2.new(0, 200, 0, 50)
    Frame.Position = UDim2.new(0, 10, 0, 10)
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BorderSizePixel = 2
    Frame.Parent = ScreenGui

    local Toggle = Instance.new("TextButton")
    Toggle.Name = "Toggle"
    Toggle.Size = UDim2.new(0, 100, 0, 30)
    Toggle.Position = UDim2.new(0, 50, 0, 10)
    Toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    Toggle.BorderSizePixel = 2
    Toggle.Text = "Turn On"
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.Parent = Frame

    local isScriptRunning = false

    -- Function to toggle script execution
    local function ToggleScript()
        isScriptRunning = not isScriptRunning
        if isScriptRunning then
            Toggle.Text = "Turn Off"
            coroutine.wrap(SprayPaintPlayers)() -- Start the SprayPaintPlayers function as a coroutine
        else
            Toggle.Text = "Turn On"
        end
    end

    -- Connect toggle button click event
    Toggle.MouseButton1Click:Connect(ToggleScript)
end

-- Create the GUI
CreateGUI()
