local function CreateRainCubes(targetPosition)
    local cubeSize = Vector3.new(4, 4, 4) -- Adjust size as needed
    local sprayTextureId = 10180722469 -- ID of the spray paint texture

    -- Define positions for rain cubes relative to the target position
    local cubePositions = {
        Vector3.new(0, 0, 0),
        Vector3.new(5, 5, 5),
        Vector3.new(-5, 5, -5),
        Vector3.new(5, -5, -5),
        Vector3.new(-5, -5, 5)
        -- Add more positions as needed
    }

    for _, offset in ipairs(cubePositions) do
        local cube = Instance.new("Part")
        cube.Size = cubeSize
        cube.Position = targetPosition + offset
        cube.Anchored = true
        cube.CanCollide = false
        cube.Parent = game.Workspace

        -- Apply spray paint texture to each side of the cube
        for _, face in ipairs(Enum.NormalId:GetEnumItems()) do
            game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(
                sprayTextureId,
                face,
                6,
                cube,
                cube.CFrame
            )
        end
    end
end

function soadijplayerfunc()
    local soadijplayertarget = game.Players.LocalPlayer.Character
    CreateRainCubes(soadijplayertarget.HumanoidRootPart.Position)
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "testing", Default = false })

Toggle:OnChanged(function(soadijplayer)
    if soadijplayer == true then
        soadijplayerloop = true
        while soadijplayerloop do
            function soadijplayerloopfix()
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        soadijplayertarget = players:FindFirstChild(v.Name)
                        soadijplayerfunc()
                        task.wait()
                    end
                else
                    soadijplayertarget = players:FindFirstChild(infinityGauntlet)
                    soadijplayerfunc()
                end
                task.wait(15)
            end
            wait()
            pcall(soadijplayerloopfix)
        end
    end
    if soadijplayer == false then
        soadijplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
