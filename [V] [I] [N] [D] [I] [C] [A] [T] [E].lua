local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/FRPVP/iuiqwei/main/library.lua"))()

local gui = Library:create{
    Theme = Library.Themes.Vindicate
}

local tab = gui:tab{
    Icon = "rbxassetid://18519217818",
    Name = "Murder Mystery 2"
}

tab:button({
    Name = "Activate Script",
    Description = "",
    Callback = function()
        print("Button clicked")
    end,
})



local tab = gui:tab{
    Icon = "rbxassetid://18519224545",
    Name = "Loomian Legacy"
}

tab:button({
    Name = "Activate Script",
    Description = "",
    Callback = function()
        print("Button clicked")
    end,
})




local tab = gui:tab{
    Icon = "rbxassetid://18519214713",
    Name = "Lucky Block Battlegrounds"
}

tab:button({
    Name = "Activate Script",
    Description = "",
    Callback = function()
        print("Button clicked")
    end,
})



local tab = gui:tab{
    Icon = "rbxassetid://18519221386",
    Name = "Flee The Facility"
}



tab:button({
    Name = "Activate Script",
    Description = "",
    Callback = function()
        print("Button clicked")
    end,
})
