if game.Players.LocalPlayer.Character ~= nil then
local mouse = game.Players.LocalPlayer:GetMouse()
tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Gun "
tool.Activated:connect(function()
    if game:GetService("Players").LocalPlayer.Backpack.Toys:FindFirstChild("SprayPaint") then
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("ReplicatedStorage").Remotes.Extras.ReplicateToy:InvokeServer("SprayPaint")
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14926229050, Enum.NormalId.Back, 2.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14926229050, Enum.NormalId.Front, 2.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14926229050, Enum.NormalId.Right, 2.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14926229050, Enum.NormalId.Left, 2.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 6, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("SprayPaint") then
        game:GetService("Players").LocalPlayer.Backpack.SprayPaint.Parent = game.Players.LocalPlayer.Character
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14926229050, Enum.NormalId.Back, 2.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14926229050, Enum.NormalId.Front, 2.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14926229050, Enum.NormalId.Right, 2.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14926229050, Enum.NormalId.Left, 2.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 6, 0))
        game.Players.LocalPlayer.Character.SprayPaint.Parent = game:GetService("Players").LocalPlayer.Backpack
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("SprayPaint") then
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14926229050, Enum.NormalId.Back, 2.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14926229050, Enum.NormalId.Front, 2.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14926229050, Enum.NormalId.Right, 2.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 6, 0))
game:GetService("Players").LocalPlayer.Character.SprayPaint.Remote:FireServer(14926229050, Enum.NormalId.Left, 2.5, workspace.Lobby.VoteIcons.VotePad2, CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position) * CFrame.new(0, 6, 0))
    end
end)
tool.Parent = game.Players.LocalPlayer.Backpack
end
