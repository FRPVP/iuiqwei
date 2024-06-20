local isLuckyBlockToggled = false
local isSuperBlockToggled = false
local isDiamondBlockToggled = false
local isRainbowBlockToggled = false
local isGalaxyBlockToggled = false
local spawnLuckyBlockConnection
local spawnSuperBlockConnection
local spawnDiamondBlockConnection
local spawnRainbowBlockConnection
local spawnGalaxyBlockConnection
local numberOfExecutions = 1  -- Default value for the number of executions

local slider = tab:slider({
    Name = "Number of Blocks",
    Description = "",
    Default = 1,
    Min = 1,
    Max = 200,
    Rounding = 1,
    Callback = function(value)
        numberOfExecutions = value
        print("Number of Executions set to:", value)
    end
})

local function executeLuckyBlockScript()
    for i = 1, numberOfExecutions do
        if not isLuckyBlockToggled then break end
        game:GetService("ReplicatedStorage").SpawnLuckyBlock:FireServer()
        wait(0.2)  -- Add a small delay to avoid overwhelming the server
    end
end

local function executeSuperBlockScript()
    for i = 1, numberOfExecutions do
        if not isSuperBlockToggled then break end
        game:GetService("ReplicatedStorage").SpawnSuperBlock:FireServer()
        wait(0.2)  -- Add a small delay to avoid overwhelming the server
    end
end

local function executeDiamondBlockScript()
    for i = 1, numberOfExecutions do
        if not isDiamondBlockToggled then break end
        game:GetService("ReplicatedStorage").SpawnDiamondBlock:FireServer()
        wait(0.2)  -- Add a small delay to avoid overwhelming the server
    end
end

local function executeRainbowBlockScript()
    for i = 1, numberOfExecutions do
        if not isRainbowBlockToggled then break end
        game:GetService("ReplicatedStorage").SpawnRainbowBlock:FireServer()
        wait(0.2)  -- Add a small delay to avoid overwhelming the server
    end
end

local function executeGalaxyBlockScript()
    for i = 1, numberOfExecutions do
        if not isGalaxyBlockToggled then break end
        game:GetService("ReplicatedStorage").SpawnGalaxyBlock:FireServer()
        wait(0.2)  -- Add a small delay to avoid overwhelming the server
    end
end

local function onLuckyBlockCharacterAdded(character)
    if isLuckyBlockToggled then
        executeLuckyBlockScript()
    end
end

local function onSuperBlockCharacterAdded(character)
    if isSuperBlockToggled then
        executeSuperBlockScript()
    end
end

local function onDiamondBlockCharacterAdded(character)
    if isDiamondBlockToggled then
        executeDiamondBlockScript()
    end
end

local function onRainbowBlockCharacterAdded(character)
    if isRainbowBlockToggled then
        executeRainbowBlockScript()
    end
end

local function onGalaxyBlockCharacterAdded(character)
    if isGalaxyBlockToggled then
        executeGalaxyBlockScript()
    end
end

tab:toggle({
    Name = "Auto Load Lucky Block",
    StartingState = false,
    Description = "",
    Callback = function(state)
        isLuckyBlockToggled = state
        if isLuckyBlockToggled then
            -- Start executing the script and connect the character added event
            executeLuckyBlockScript()
            spawnLuckyBlockConnection = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(onLuckyBlockCharacterAdded)
        else
            -- Disconnect the character added event to stop execution
            if spawnLuckyBlockConnection then
                spawnLuckyBlockConnection:Disconnect()
                spawnLuckyBlockConnection = nil
            end
        end
    end,
})

tab:toggle({
    Name = "Auto Load Super Block",
    StartingState = false,
    Description = "",
    Callback = function(state)
        isSuperBlockToggled = state
        if isSuperBlockToggled then
            -- Start executing the script and connect the character added event
            executeSuperBlockScript()
            spawnSuperBlockConnection = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(onSuperBlockCharacterAdded)
        else
            -- Disconnect the character added event to stop execution
            if spawnSuperBlockConnection then
                spawnSuperBlockConnection:Disconnect()
                spawnSuperBlockConnection = nil
            end
        end
    end,
})

tab:toggle({
    Name = "Auto Load Diamond Block",
    StartingState = false,
    Description = "",
    Callback = function(state)
        isDiamondBlockToggled = state
        if isDiamondBlockToggled then
            -- Start executing the script and connect the character added event
            executeDiamondBlockScript()
            spawnDiamondBlockConnection = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(onDiamondBlockCharacterAdded)
        else
            -- Disconnect the character added event to stop execution
            if spawnDiamondBlockConnection then
                spawnDiamondBlockConnection:Disconnect()
                spawnDiamondBlockConnection = nil
            end
        end
    end,
})

tab:toggle({
    Name = "Auto Load Rainbow Block",
    StartingState = false,
    Description = "",
    Callback = function(state)
        isRainbowBlockToggled = state
        if isRainbowBlockToggled then
            -- Start executing the script and connect the character added event
            executeRainbowBlockScript()
            spawnRainbowBlockConnection = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(onRainbowBlockCharacterAdded)
        else
            -- Disconnect the character added event to stop execution
            if spawnRainbowBlockConnection then
                spawnRainbowBlockConnection:Disconnect()
                spawnRainbowBlockConnection = nil
            end
        end
    end,
})

tab:toggle({
    Name = "Auto Load Galaxy Block",
    StartingState = false,
    Description = "",
    Callback = function(state)
        isGalaxyBlockToggled = state
        if isGalaxyBlockToggled then
            -- Start executing the script and connect the character added event
            executeGalaxyBlockScript()
            spawnGalaxyBlockConnection = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(onGalaxyBlockCharacterAdded)
        else
            -- Disconnect the character added event to stop execution
            if spawnGalaxyBlockConnection then
                spawnGalaxyBlockConnection:Disconnect()
                spawnGalaxyBlockConnection = nil
            end
        end
    end,
})
