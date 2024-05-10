local SprayID = 10180722469 -- Default spray ID

local Input = Tabs.Premium:AddInput("Input", {
    Title = "Input",
    Default = tostring(SprayID), -- Default value set to the default spray ID
    Placeholder = "Placeholder",
    Numeric = true, -- Allowing only numbers for the spray ID
    Finished = false, -- Only calls callback when you press enter
    Callback = function(Value)
        print("Input changed:", Value)
        SprayID = tonumber(Value) -- Update the SprayID variable when the input changes
    end
})

Input:OnChanged(function()
    print("Input updated:", Input.Value)
    SprayID = tonumber(Input.Value) -- Update the SprayID variable when the input changes
end)

function ,mzxnclzplayerfunc(SprayID)
    game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(SprayID, Enum.NormalId.Top, 6, (,mzxnclzplayertarget.Character.HumanoidRootPart), ,mzxnclzplayertarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
    -- Add similar lines for other directions
end

local Toggle = Tabs.Premium:AddToggle("", {Title = "TESTING", Default = false })

Toggle:OnChanged(function(,mzxnclzplayer)
    if ,mzxnclzplayer == true then
        ,mzxnclzplayerloop = true
        while ,mzxnclzplayerloop do
            function ,mzxnclzplayerloopfix()
                EquipSpray()
                task.wait(0.4)
                if infinityGauntlet == "All" then
                    for _, v in pairs(players:GetPlayers()) do
                        ,mzxnclzplayertarget = players:FindFirstChild(v.Name)
                        ,mzxnclzplayerfunc(SprayID) -- Pass SprayID to the function
                        task.wait()
                    end
                else
                    ,mzxnclzplayertarget = players:FindFirstChild(infinityGauntlet)
                    ,mzxnclzplayerfunc(SprayID) -- Pass SprayID to the function
                end
                task.wait(15)
            end
            wait()
            pcall(,mzxnclzplayerloopfix)
        end
    end
    if ,mzxnclzplayer == false then
        ,mzxnclzplayerloop = false
        wait()
    end
end)

Options.MyToggle:SetValue(false)
