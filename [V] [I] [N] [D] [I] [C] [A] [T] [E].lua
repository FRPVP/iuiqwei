local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/FRPVP/iuiqwei/main/library.lua"))()

local gui = Library:create{
    Theme = Library.Themes.Vindicate
}

local tab = gui:tab{
    Icon = "rbxassetid://17771512972",
    Name = "Murder Mystery 2"
    Callback = function()
        print("Button clicked")
    end,
})


local tab = gui:tab{
    Icon = "rbxassetid://17771512972",
    Name = "Lucky Block Battlegrounds"
    Callback = function()
        print("Button clicked")
    end,
})
