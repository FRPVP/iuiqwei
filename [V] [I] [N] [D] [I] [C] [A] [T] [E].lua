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
        loadstring(game:HttpGet('https://raw.githubusercontent.com/FRPVP/iuiqwei/main/%5BM%5D%20%5BM%5D%20%5B2%5D.lua'))()
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
        loadstring(game:HttpGet('https://raw.githubusercontent.com/FRPVP/iuiqwei/main/%5BL%5D%20%5BO%5D%20%5BO%5D%20%5BM%5D%20%5BI%5D%20%5BA%5D%20%5BN%5D.lua'))()
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
        loadstring(game:HttpGet('https://raw.githubusercontent.com/FRPVP/iuiqwei/main/%5BL%5D%20%5BB%5D%20%5BB%5D.lua'))()
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
        loadstring(game:HttpGet('https://raw.githubusercontent.com/FRPVP/iuiqwei/main/%5BF%5D%20%5BT%5D%20%5BF%5D.lua'))()
    end,
})
