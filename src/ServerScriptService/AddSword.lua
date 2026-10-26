local Players = game:GetService("Players")
local WeaponLoadout = require(game.ReplicatedStorage.PlayerModules.WeaponLoadout)
local tools = game.ReplicatedStorage:WaitForChild("Tools")
local sword = tools:WaitForChild("Sword")

Players.PlayerAdded:Connect(function(player)

	player.CharacterAdded:Connect(function(character)
		WeaponLoadout:CreateInventory(player)
		WeaponLoadout:AddItem(player, "Sword")
	end)
end)