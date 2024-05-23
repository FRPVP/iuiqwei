local ModerkaLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/ttwizz/Roblox/master/ModerkaLibrary.lua", true))()


-- Creating a Window

local Window = ModerkaLibrary:AddWindow("Vindicate")


-- Creating a Page

local Page = Window:AddPage("Player")
local Page = Window:AddPage("Visual")
local Page = Window:AddPage("Combat")
local Page = Window:AddPage("Teleport")
local Page = Window:AddPage("Trolling")
local Page = Window:AddPage("Autofarm")
local Page = Window:AddPage("Emotes")
local Page = Window:AddPage("SprayPaint")
local Page = Window:AddPage("Settings")


-- Creating a Button

local Button = Page:AddButton("Button 1", function()
    print("Button 1 pressed!")
end)


-- Creating a Label

local Label = Page:AddLabel("Label 1")


-- Creating a Dropdown

local Dropdown = Page:AddDropdown("Dropdown 1", {"Value 1", "Value 2", "Value 3"}, function(Value)
    print(Value)
end)


-- Creating a Colour Picker

local ColourPicker = Page:AddColourPicker("Colour Picker 1", "white", function(Value)
    print(Value)
end)


-- Creating a Slider

local Slider = Page:AddSlider("Slider 1", {Minimum = 0, Maximum = 255, Default = 50}, function(Value)
    print(Value)
end)


-- Creating a Toggle

local Toggle = Page:AddToggle("Toggle 1", false, function(Value)
    print(Value)
end)


-- Creating a TextBox

local TextBox = Page:AddTextBox("TextBox 1", function(Value)
    print(Value)
end)
